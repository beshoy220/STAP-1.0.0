import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Local_providers/stages.dart';

// class TeacherOperationsForWindows extends StatelessWidget {
//   const TeacherOperationsForWindows({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(AppMeta.appName)),
//       body: GridView.builder(
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//         ),
//         itemCount: teacherOperations.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: InkWell(
//               onTap: () {
//                 switch (index) {
//                   case 0:
//                     NavigateTo(context, const AddTeacherForWindows());

//                     break;
//                   case 1:
//                     NavigateTo(context, const DeleteTeacherForWindows());

//                     break;
//                   default:
//                 }
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: AppMeta.color,
//                     borderRadius: BorderRadius.circular(5)),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       teacherOperations[index][1],
//                       size: 40,
//                       color: Colors.white,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       teacherOperations[index][0],
//                       style: const TextStyle(color: Colors.white),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

///
///
///
///
/// ADD TEACHER
/// ADD TEACHER
/// ADD TEACHER
///
///
///
///
///
/// ADD TEACHER
/// ADD TEACHER
/// ADD TEACHER
///
///
///
///
/// ADD TEACHER
/// ADD TEACHER
/// ADD TEACHER
///
///
///
///
///

class AddTeacherForWindows extends StatefulWidget {
  const AddTeacherForWindows({Key? key}) : super(key: key);
  @override
  State<AddTeacherForWindows> createState() => _AddTeacherForWindowsState();
}

class _AddTeacherForWindowsState extends State<AddTeacherForWindows> {
  late String dropdownValue = stages.first;

  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                onChanged: (value) {
                  int newValue = int.parse(value);
                  if (newValue != null && newValue <= 150) {
                    print(newValue);
                    setState(() {
                      num = newValue;
                    });
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Enter number of Teachers"),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: num,
              itemBuilder: (BuildContext context, int index) {
                var newindex = index + 1;
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Teacher $newindex',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                  labelText: "Enter Teacher Name "),
                              keyboardType: TextInputType.name,
                            ),
                            TextField(
                              onChanged: (value) {},
                              decoration: const InputDecoration(
                                  labelText: "Enter Teacher Subject"),
                              keyboardType: TextInputType.name,
                            ),
                            Row(
                              children: [
                                const Text('Stage : '),
                                DropdownButton<String>(
                                  value: dropdownValue,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style: TextStyle(color: AppMeta.color),
                                  underline: Container(
                                    height: 2,
                                    color: AppMeta.color,
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      dropdownValue = value!;
                                    });
                                  },
                                  items: stages.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Chip(
                                    backgroundColor: AppMeta.color,
                                    avatar: CircleAvatar(
                                      backgroundColor: AppMeta.color,
                                      child: const Icon(Icons.male),
                                    ),
                                    label: const Text(
                                      'Male',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: const Chip(
                                    backgroundColor: Colors.purple,
                                    avatar: CircleAvatar(
                                      backgroundColor: Colors.purple,
                                      child: Icon(Icons.female),
                                    ),
                                    label: Text(
                                      'Female',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Done !')),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

///
///
///
///
/// DELETE TEACHER
/// DELETE TEACHER
/// DELETE TEACHER
///
///
///
///
///
/// DELETE TEACHER
/// DELETE TEACHER
/// DELETE TEACHER
///
///
///
///
/// DELETE TEACHER
/// DELETE TEACHER
/// DELETE TEACHER
///
///
///
///
///

class DeleteTeacherForWindows extends StatefulWidget {
  const DeleteTeacherForWindows({Key? key}) : super(key: key);
  @override
  State<DeleteTeacherForWindows> createState() =>
      _DeleteTeacherForWindowsState();
}

class _DeleteTeacherForWindowsState extends State<DeleteTeacherForWindows> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            ListView(shrinkWrap: true, children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(18.0),
                child: Center(
                    child: Text(
                  'Registed teacher',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
              ),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                        label: Text('Name',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Subject',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Delete',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Mrs Mariam youssef seif')),
                      DataCell(Text('Arabic')),
                      DataCell(OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.delete,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ],
                          ))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Mr Abd-El-Rahman Ahmed')),
                      DataCell(Text('English')),
                      DataCell(OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.delete,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ],
                          ))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Mrs Denna Ahmed Saad')),
                      DataCell(Text('French')),
                      DataCell(OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.delete,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ],
                          ))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Mr Ahmed mohamed ahmed')),
                      DataCell(Text('Math')),
                      DataCell(OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.delete,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ],
                          ))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Mrs Nada wageh')),
                      DataCell(Text('Arabic')),
                      DataCell(OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.delete,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ],
                          ))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Mr Bola ashraf saad')),
                      DataCell(Text('Physics')),
                      DataCell(OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.delete,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ],
                          ))),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Mrs Amany saad ahmed')),
                      DataCell(Text('English')),
                      DataCell(OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              Icon(
                                Icons.delete,
                                color: Colors.deepOrange,
                              ),
                              Text(
                                'Delete',
                                style: TextStyle(color: Colors.deepOrange),
                              ),
                            ],
                          ))),
                    ]),
                  ],
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
