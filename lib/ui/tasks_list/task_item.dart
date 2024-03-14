import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_online_sun/core/firestore_helper.dart';
import 'package:todo_c10_online_sun/core/providers/auth_provider.dart';
import 'package:todo_c10_online_sun/core/utilits/app_colors.dart';
import 'package:todo_c10_online_sun/model/task.dart';
import 'package:todo_c10_online_sun/ui/edit_task/edit_task_screen.dart';

class TaskItem extends StatefulWidget {
  Task task;
  TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {

  late bool done;
  late AuthUserProvider provider;
  @override
  void initState() {
    super.initState();
    done = widget.task.isDone!;
    provider = Provider.of<AuthUserProvider>(context , listen: false);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if(done == false){
          Navigator.pushNamed(context, EditTaskScreen.routeName,arguments: widget.task);
        }
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                height: 80,
                width: 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: done ? AppColor.doneColor : AppColor.primaryColor,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      widget.task.title ?? "",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: done ? AppColor.doneColor : Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                      widget.task.description ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: done ? AppColor.doneColor : Colors.black,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              done ? Text(
                  'Done!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: done ? AppColor.doneColor : Colors.black,
                ),
              )
              : InkWell(
                onTap: () {
                  FirestoreHelper.updateTaskToTrue(
                    task: widget.task,
                    userId: provider.authUser!.uid,
                  );
                  setState(() {
                    done = true;
                  });
                },
                child: Container(
                    width: 50,
                    height: 40,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 25,
                    ),),
              ),
              const SizedBox(width: 4,),
            ],
          ),
        ),
      ),
    );
  }
}
