import 'package:flutter/material.dart';
import 'package:todo_c10_online_sun/core/utilits/app_colors.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Card(
      margin: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25)
      ),
      child: Container(
        padding: EdgeInsets.all(10),
        //color: Colors.white,
        // height: 110,
        // width: 200,
        child: Row(
          
          children: [
            
            Container(
              margin: EdgeInsets.all(15),
              // padding: EdgeInsets.all(20),
              height: 80,
              width: 4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColor.primaryColor
      
              ),
            ),
      
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Task Title"),
                SizedBox(
                  height: 12,
                ),
                Text("Task Description"),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {
      
              },
              child: Container(
                 width: 50,
                 height: 40,
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
              decoration: BoxDecoration(
                color: AppColor.primaryColor,
                borderRadius: BorderRadius.circular(15),
      
                  ),
      
                  child: Icon(Icons.check,size: 25,)),
            )
          ],
        ),
      ),
    );
  }
}
