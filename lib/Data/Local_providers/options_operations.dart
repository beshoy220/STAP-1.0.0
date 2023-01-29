import 'package:flutter/material.dart';
import 'package:school_manager/Presentation/Admin_Widget/Android_Widgets/message_operations.dart';
import 'package:school_manager/Presentation/Admin_Widget/Android_Widgets/sessions_operatios.dart';
import 'package:school_manager/Presentation/Admin_Widget/Android_Widgets/student_operations.dart';
import 'package:school_manager/Presentation/Admin_Widget/Android_Widgets/teacher_operations.dart';
import 'package:school_manager/Presentation/Admin_Widget/Android_Widgets/votes_operations.dart';
import 'package:school_manager/Presentation/Teacher_Widget/operations.dart';
import 'package:school_manager/Presentation/Teacher_Widget/view_sessions.dart';

///
///
///
/// ADMIN SECTION
/// ADMIN SECTION
/// ADMIN SECTION
///
///
///
///
///
///
/// ADMIN SECTION
/// ADMIN SECTION
/// ADMIN SECTION
///
///
///
///
///
/// ADMIN SECTION
/// ADMIN SECTION
/// ADMIN SECTION
///
///
///
///
///
/// ADMIN SECTION
/// ADMIN SECTION
/// ADMIN SECTION
///
///
///
///
///
///
/// ADMIN SECTION
/// ADMIN SECTION
/// ADMIN SECTION
///
///
///
///

List adminOptionsForAndroid = [
  ['Student Affairs', Icons.group, const StudentOperations()],
  ['Teacher Affairs', Icons.edit, const TeacherOperations()],
  ['Table Of Sessions', Icons.table_chart_outlined, const SesssionViewGrades()],
  ['Message', Icons.messenger_outline, const MessageOperations()],
  ['Votes', Icons.bar_chart_outlined, const ViewGradesForVotes()]
];

List adminOptionsForWindows = [
  ['Student Affairs', Icons.group, const StudentOperations()],
  ['Teacher Affairs', Icons.edit, const TeacherOperations()],
  ['Table Of Sessions', Icons.table_chart_outlined, const SesssionViewGrades()],
  ['Message', Icons.messenger_outline, const MessageOperations()],
];

// ignore: non_constant_identifier_names
NavigateTo(BuildContext context, Widget path) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => path),
  );
}

List studentOperations = [
  ['Add Student', Icons.add],
  ['Delete Student', Icons.delete],
  ['Edit Student', Icons.edit],
  ['Student Status', Icons.align_vertical_bottom],
];

List teacherOperations = [
  ['Add Teacher', Icons.add_box_outlined],
  ['Delete Teacher', Icons.delete_forever],
  ['Teacher Status', Icons.align_vertical_bottom],
];

List sessionOperations = [
  ['View Sessions', Icons.table_rows_outlined],
  ['Edit Sessions', Icons.edit],
];

List messageOperations = [
  ['Private Message \n(Parent)', Icons.messenger_outline],
  ['Public Message \n(Parent)', Icons.event_rounded],
  ['Message Teacher', Icons.message_outlined],
];

List subjects = [
  [Icons.translate, 'Arabic'],
  [Icons.translate, 'English'],
  [Icons.translate, 'French'],
  [Icons.science_rounded, 'Science'],
  [Icons.science_rounded, 'Chemistry'],
  [Icons.science_rounded, 'Physics'],
  [Icons.science_rounded, 'Biology'],
  [Icons.language, 'Geology'],
  [Icons.accessibility_new, 'Social Studies'],
  [Icons.history_edu, 'History'],
  [Icons.computer, 'Computer'],
  [Icons.art_track, 'Art'],
];

///
///
///
/// TEACHER SECTION
/// TEACHER SECTION
/// TEACHER SECTION
///
///
///
///
///
///
/// TEACHER SECTION
/// TEACHER SECTION
/// TEACHER SECTION
///
///
///
///
///
/// TEACHER SECTION
/// TEACHER SECTION
/// TEACHER SECTION
///
///
///
///
///
/// TEACHER SECTION
/// TEACHER SECTION
/// TEACHER SECTION
///
///
///
///
///
///
/// TEACHER SECTION
/// TEACHER SECTION
/// TEACHER SECTION
///
///
///
///

List teacherHomeNav = [
  [
    Icons.table_chart_outlined,
    'Sessions',
    'View all sessions of the week',
    'assets/teacher/priscilla-du-preez-ggeZ9oyI-PE-unsplash (2).jpg',
    const TeacherSessions()
  ],
  [
    Icons.messenger_outline,
    'Message Parent',
    'Message parent privately only the selected parent will recive the message',
    'assets/teacher/dawid-malecki-fw7lR3ibfpU-unsplash.jpg',
    const ViewGradesForTeacher(
      opreationType: 0,
    )
  ],
  [
    Icons.person,
    'Presence',
    'Check who is in the class from students by a small mark',
    'assets/teacher/feliphe-schiarolli-hes6nUC1MVc-unsplash.jpg',
    const ViewGradesForTeacher(
      opreationType: 1,
    )
  ],
  [
    Icons.paste_rounded,
    'Evaluation',
    'Evaluations is a good way to give a suitable data for the parent to track his/her child',
    'assets/teacher/yustinus-tjiuwanda-BCBGahg0MH0-unsplash.jpg',
    const ViewGradesForTeacher(
      opreationType: 2,
    )
  ],
  [
    Icons.outbound_rounded,
    'Permissions',
    'Send permissions so you can let the parent notify if his son wants to quit schedule',
    'assets/teacher/clay-banks-pNEmlb1CMZM-unsplash.jpg',
    const ViewGradesForTeacher(
      opreationType: 3,
    )
  ],
  [
    Icons.lock,
    'Assinment (Next Version)',
    'Describtion Should Be Here For Next Version',
    'assets/teacher/daniel-chekalov-OxU08SFhPbI-unsplash.jpg',
    const ViewGradesForTeacher(
      opreationType: 4,
    )
  ],
  [
    Icons.lock,
    'Set online exam (Next Version)',
    'Describtion Should Be Here For Next Version',
    'assets/teacher/daniel-chekalov-OxU08SFhPbI-unsplash.jpg',
    const ViewGradesForTeacher(
      opreationType: 4,
    )
  ],
];
