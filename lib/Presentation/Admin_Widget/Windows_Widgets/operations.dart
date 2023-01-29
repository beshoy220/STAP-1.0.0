import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Presentation/Admin_Widget/Windows_Widgets/message_operations.dart';
import 'package:school_manager/Presentation/Admin_Widget/Windows_Widgets/sessions_operatios.dart';
import 'package:school_manager/Presentation/Admin_Widget/Windows_Widgets/student_operations.dart';
import 'package:school_manager/Presentation/Admin_Widget/Windows_Widgets/teacher_operations.dart';

class Operations extends StatelessWidget {
  const Operations(
      {super.key, required this.source, required this.operationsOf});
  final dynamic source;
  final dynamic operationsOf;
  @override
  Widget build(BuildContext context) {
    var currentwidth = MediaQuery.of(context).size.width;
    if (currentwidth < 1000) {
      return const Center(
        child: Text('Window is too small to display content'),
      );
    } else {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          itemCount: currentwidth < 1000 ? 1 : source.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                if (operationsOf == 'student') {
                  NavigateTo(
                      context,
                      ViewGradesForWindowsStudentOperation(
                        opreationType: index,
                      ));
                } else if (operationsOf == 'teacher') {
                  switch (index) {
                    case 0:
                      NavigateTo(context, const AddTeacherForWindows());
                      break;
                    case 1:
                      NavigateTo(context, const DeleteTeacherForWindows());
                      break;
                  }
                } else if (operationsOf == 'sessions') {
                  NavigateTo(context, const SesssionViewGradesForWindows());
                } else if (operationsOf == 'message') {
                  NavigateTo(context, const MessageOperationsForWindows());
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppMeta.color,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        source[index][1],
                        size: 40,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        source[index][0],
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    }
  }
}
