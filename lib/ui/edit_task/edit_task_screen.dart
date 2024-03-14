import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c10_online_sun/core/firestore_helper.dart';
import 'package:todo_c10_online_sun/core/providers/auth_provider.dart';
import 'package:todo_c10_online_sun/core/utilits/app_colors.dart';
import 'package:todo_c10_online_sun/core/utilits/my_date_utilis.dart';
import 'package:todo_c10_online_sun/model/task.dart';
import 'package:todo_c10_online_sun/ui/componant/custom_text_form_field.dart';

class EditTaskScreen extends StatefulWidget {
  static const routeName = '/editHomeScreen';

  const EditTaskScreen({super.key, required this.task,});
  final Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController tittleController = TextEditingController();

  TextEditingController discController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Task task = Task(date: null, title: '', description: '');


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    task = ModalRoute.of(context)?.settings.arguments as Task;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.lightGreen,
      body: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.3,
            color: AppColor.primaryColor,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(
              top: 80,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'To Do List',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 22),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: (MediaQuery.sizeOf(context).height * 0.2),
              left: 30,
              right: 30,
              bottom: (MediaQuery.sizeOf(context).height * 0.1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                const Text(
                  'Edit Task',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  controller: tittleController,
                  decoration: const InputDecoration(
                    label: Text(
                      'This is title',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  controller: discController,
                  decoration: const InputDecoration(
                    label: Text(
                      'Task details',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Selected date",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    showTaskdatePicker();
                  },
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(MyDataUtilis.formateTaskDate(selectedDate))),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async{
                    AuthUserProvider provider = Provider.of<AuthUserProvider>(context , listen: false);
                    await FirestoreHelper.updateTaskDetails(
                      task: task,
                      title: tittleController.text,
                      userId: provider.authUser!.uid,
                      date: Timestamp.fromMillisecondsSinceEpoch(selectedDate.millisecondsSinceEpoch),
                      discription: discController.text,
                    ).then((value) {
                      Navigator.pop(context);
                    });
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width/2,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: AppColor.primaryColor,
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showTaskdatePicker() async {
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (date == null) return;
    selectedDate = date;
    setState(() {});
  }
}
