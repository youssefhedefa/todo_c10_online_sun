import 'package:flutter/material.dart';
import 'package:todo_c10_online_sun/core/utilits/app_colors.dart';
import 'package:todo_c10_online_sun/ui/settings/settings.dart';
import 'package:todo_c10_online_sun/ui/tasks_list/add_task_bottom_sheet.dart';
import 'package:todo_c10_online_sun/ui/tasks_list/tasl_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  var tabs = [
    TaskScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.lightGreen,
      appBar: AppBar(
        toolbarHeight: 110,
        backgroundColor: AppColor.primaryColor,
        title: Text(
          "To Do List",
          style: TextStyle(color: AppColor.whihtColor),
        ),
      ),

      body: tabs[selectedIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primaryColor,
        shape: StadiumBorder(
            side: BorderSide(color: AppColor.whihtColor, width: 4)),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  size: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings, size: 30), label: ""),
          ],
        ),
      ),
    );
  }

  void showAddTaskBottomSheet() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding:  EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddTaskBottomSheet(),
        );
      },
    );
  }
}
