import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_online_sun/core/firestore_helper.dart';
import 'package:todo_c10_online_sun/core/providers/auth_provider.dart';
import 'package:todo_c10_online_sun/ui/tasks_list/task_item.dart';

import '../../core/utilits/app_colors.dart';
import '../../model/task.dart';

class TaskScreen extends StatefulWidget {

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DateTime mySelectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AuthUserProvider provider = Provider.of<AuthUserProvider>(context);
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            mySelectedDate = selectedDate;
            setState(() {

            });
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.fullDateDMY(),
          ),
          dayProps:  const EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff3371FF),
                    Color(0xff8426D6),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: FutureBuilder(
            future: FirestoreHelper.GetAllTasks(provider.authUser!.uid,Timestamp.fromMillisecondsSinceEpoch(mySelectedDate.millisecondsSinceEpoch)),
            builder: (BuildContext context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                // loading
                return const Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.hasError){
                // error
                return Column(
                  children: [
                    const Text("Something went wrong"),
                    ElevatedButton(onPressed: (){}, child: const Text("try again"))
                  ],
                );
              }
              // success
              List<Task> tasks = snapshot.data??[];
              return ListView.builder(
              itemBuilder: (context , index) => TaskItem(task: tasks[index],),
              itemCount: tasks.length,
              );
            },

          ),
        )
      ],
    );
  }
}
