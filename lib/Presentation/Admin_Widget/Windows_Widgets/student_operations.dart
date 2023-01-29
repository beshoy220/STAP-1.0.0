// import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Local_providers/gades_classes.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:desktop_window/desktop_window.dart';

///
///
///
///
///
/// View Grades
///
///
///
///
///
///

class ViewGradesForWindowsStudentOperation extends StatelessWidget {
  const ViewGradesForWindowsStudentOperation(
      {Key? key, required this.opreationType})
      : super(key: key);
  final dynamic opreationType;
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    IconData icon = Icons.add;
    switch (opreationType) {
      case 0:
        icon = Icons.add;
        break;
      case 1:
        icon = Icons.delete;
        break;
      case 2:
        icon = Icons.edit;
        break;
      default:
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: currentWidth < 1200 ? 3 : 6,
              ),
              shrinkWrap: true,
              itemCount: grades.length,
              itemBuilder: (BuildContext context, int index) {
                Map map = <String, int>{
                  'operation': opreationType,
                  'grade': index
                };
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      print(map);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ViewClasses()),
                      // );
                      NavigateTo(
                          context,
                          ViewClassesForWindows(
                            source: map,
                          ));
                    },
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 109, 109, 109)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  grades[index],
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Contains ${classes.length} classes',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Icon(
                                  icon,
                                  color: Colors.amber,
                                ),
                              )),
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
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
///
/// View classes
///
///
///
///
///

class ViewClassesForWindows extends StatelessWidget {
  const ViewClassesForWindows({Key? key, required this.source})
      : super(key: key);
  final Map source;
  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: currentWidth < 1200 ? 3 : 6,
              ),
              shrinkWrap: true,
              itemCount: classes.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, int> destiney = {
                  'operation': source['operation'],
                  'grade': source['grade'],
                  'class': index
                };
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      print(destiney['operation']);
                      int? x = destiney['operation'];
                      print(destiney);
                      switch (x) {
                        case 0:
                          NavigateTo(context, const AddStudentForWindows());
                          break;
                        case 1:
                          NavigateTo(context, const DeleteStudentForWindows());
                          break;
                        case 2:
                          NavigateTo(context, const EditStudentForWindows());
                          break;
                      }
                    },
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: const Color.fromARGB(255, 109, 109, 109)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(18.0),
                                      child: Icon(
                                        Icons.bookmark,
                                        color: Colors.amber,
                                      ),
                                    )),
                                Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            classes[index],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            'Contains 0 students',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ))
                              ]),
                          // Align(
                          //     alignment: Alignment.topRight,
                          //     child: Container(
                          //         color: Colors.amber,
                          //         child: const Icon(
                          //           Icons.add,
                          //           color: Color(0xFF6D6D6D),
                          //         ))),
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
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
/// ADD STUDENT FOR DB
///
/// ADD STUDENT FOR DB
///
/// ADD STUDENT FOR DB
///
///
///
///
///
///
///
///
/// ADD STUDENT FOR DB
///
/// ADD STUDENT FOR DB
///
/// ADD STUDENT FOR DB
///
///
///
///
///
///
///
///
/// ADD STUDENT FOR DB
///
/// ADD STUDENT FOR DB
///
/// ADD STUDENT FOR DB
///
///

class AddStudentForWindows extends StatefulWidget {
  const AddStudentForWindows({Key? key}) : super(key: key);
  @override
  State<AddStudentForWindows> createState() => _AddStudentForWindowsState();
}

class _AddStudentForWindowsState extends State<AddStudentForWindows> {
  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: TextField(
                onChanged: (value) {
                  int newValue = int.parse(value);
                  if (newValue != null && newValue <= 150) {
                    debugPrint(newValue.toString());
                    setState(() {
                      num = newValue;
                    });
                  }
                },
                decoration: const InputDecoration(
                    labelText: "Enter number of students"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'preferred with full screen',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              cacheExtent: 2,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: (double.maxFinite / double.maxFinite),
              ),
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
                        child: SingleChildScrollView(
                          physics: const ScrollPhysics(),
                          child: Column(
                            children: [
                              Text('Student $newindex'),
                              TextField(
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                    labelText: "Enter Student Name "),
                                keyboardType: TextInputType.name,
                              ),
                              TextField(
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                    labelText: "Enter Student Nationality "),
                                keyboardType: TextInputType.name,
                              ),
                              TextField(
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                    labelText: "Student Birth Date"),
                                keyboardType: TextInputType.name,
                              ),
                              TextField(
                                onChanged: (value) {},
                                decoration: const InputDecoration(
                                    labelText: "Enter Student ID"),
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FilterChip(
                                      // backgroundColor: Colors.black,
                                      onSelected: (selected) {
                                        if (selected == true) {
                                          setState(() {});
                                        }
                                      },
                                      avatar: CircleAvatar(
                                        backgroundColor: Colors.grey.shade800,
                                        child: const Icon(Icons.female),
                                      ),
                                      label: const Text(
                                        'Female',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    FilterChip(
                                      onSelected: (selected) {
                                        if (selected == true) {
                                          setState(() {});
                                        }
                                      },
                                      avatar: CircleAvatar(
                                        backgroundColor: Colors.grey.shade800,
                                        child: const Icon(Icons.male),
                                      ),
                                      label: const Text('Male'),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: OutlinedButton(
                                    onPressed: () {},
                                    child: const Text('Save')),
                              )
                            ],
                          ),
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
                child: const Text('Save All')),
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
/// DELETE STUDENT FOR DB
///
/// DELETE STUDENT FOR DB
///
/// DELETE STUDENT FOR DB
///
///
///
///
///
///
///
///
/// DELETE STUDENT FOR DB
///
/// DELETE STUDENT FOR DB
///
/// DELETE STUDENT FOR DB
///
///
///
///
///
///
///
///
/// DELETE STUDENT FOR DB
///
/// DELETE STUDENT FOR DB
///
/// DELETE STUDENT FOR DB
///
///

class DeleteStudentForWindows extends StatefulWidget {
  const DeleteStudentForWindows({Key? key}) : super(key: key);
  @override
  State<DeleteStudentForWindows> createState() =>
      _DeleteStudentForWindowsState();
}

class _DeleteStudentForWindowsState extends State<DeleteStudentForWindows> {
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
                  'Registed students',
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
                        label: Text('Nationlity',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('Delete',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('Mariam youssef seif')),
                      DataCell(Text('Egypt')),
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
                      DataCell(Text('Abd-El-Rahman Ahmed')),
                      DataCell(Text('Egypt')),
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
                      DataCell(Text('Denna Ahmed Saad')),
                      DataCell(Text('Egypt')),
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
                      DataCell(Text('Ahmed mohamed ahmed')),
                      DataCell(Text('France')),
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
                      DataCell(Text('nada wageh')),
                      DataCell(Text('Egypt')),
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
                      DataCell(Text('bola ashraf saad')),
                      DataCell(Text('Iraq')),
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
                      DataCell(Text('Amany saad ahmed')),
                      DataCell(Text('Egypt')),
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

///
///
///
///
/// EDIT STUDENT FOR DB
///
/// EDIT STUDENT FOR DB
///
/// EDIT STUDENT FOR DB
///
///
///
///
///
///
///
///
/// EDIT STUDENT FOR DB
///
/// EDIT STUDENT FOR DB
///
/// EDIT STUDENT FOR DB
///
///
///
///
///
///
///
///
/// EDIT STUDENT FOR DB
///
/// EDIT STUDENT FOR DB
///
/// EDIT STUDENT FOR DB
///
///

class EditStudentForWindows extends StatefulWidget {
  const EditStudentForWindows({Key? key}) : super(key: key);
  @override
  State<EditStudentForWindows> createState() => _EditStudentForWindowsState();
}

class _EditStudentForWindowsState extends State<EditStudentForWindows> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Student $newindex',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Name',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              controller: TextEditingController(
                                text: 'Ahmed Ayman saad',
                              ),
                              onChanged: (value) {},
                              decoration: const InputDecoration(labelText: ""),
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Natonality',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              controller: TextEditingController(
                                text: ' Egyption',
                              ),
                              onChanged: (value) {},
                              decoration: const InputDecoration(labelText: ""),
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Birth Date',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            TextField(
                              controller: TextEditingController(
                                text: '2006/11/3',
                              ),
                              onChanged: (value) {},
                              decoration: const InputDecoration(labelText: ""),
                              keyboardType: TextInputType.name,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Male',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            const SizedBox(
                              height: 30,
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
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
