import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Local_providers/gades_classes.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';

class MessageOperationsForWindows extends StatelessWidget {
  const MessageOperationsForWindows({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppMeta.appName)),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: messageOperations.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: InkWell(
              onTap: () {
                NavigateTo(
                    context,
                    ViewGradesForWindows(
                      opreationType: index,
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: AppMeta.color,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      messageOperations[index][1],
                      size: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      messageOperations[index][0],
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

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

class ViewGradesForWindows extends StatelessWidget {
  const ViewGradesForWindows({Key? key, required this.opreationType})
      : super(key: key);
  final dynamic opreationType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
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
                      //   MaterialPageRoute(builder: (context) => ViewClassesForWindows()),
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
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(18.0),
                                        child: Icon(
                                          Icons.bookmark,
                                          color: Colors.amber,
                                        ),
                                      ),
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
                                  ))
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
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
                          NavigateTo(context, const PrivateMessageForWindows());
                          break;
                        case 1:
                          NavigateTo(
                              context, const PublicMessageFormForWindows());
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
                                Expanded(
                                    flex: 2,
                                    child: Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(18.0),
                                          child: Icon(
                                            Icons.bookmark,
                                            color: Colors.amber,
                                          ),
                                        ),
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
/// ADD PRiVATTE MESSAGE FOR DB
///
/// ADD PRiVATTE MESSAGE FOR DB
///
/// ADD PRiVATTE MESSAGE FOR DB
///
///
///
///
///
///
///
///
/// ADD PRiVATTE MESSAGE FOR DB
///
/// ADD PRiVATTE MESSAGE FOR DB
///
/// ADD PRiVATTE MESSAGE FOR DB
///
///
///
///
///
///
///
///
/// ADD PRiVATTE MESSAGE FOR DB
///
/// ADD PRiVATTE MESSAGE FOR DB
///
/// ADD PRiVATTE MESSAGE FOR DB
///
///

class PrivateMessageForWindows extends StatefulWidget {
  const PrivateMessageForWindows({Key? key}) : super(key: key);
  @override
  State<PrivateMessageForWindows> createState() =>
      _PrivateMessageForWindowsState();
}

class _PrivateMessageForWindowsState extends State<PrivateMessageForWindows> {
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
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                      label: Text('Parent Name',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Nationlity',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Text('Message Privatley',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text('Mariam youssef seif')),
                    DataCell(Text('Egypt')),
                    DataCell(OutlinedButton(
                        onPressed: () {
                          NavigateTo(
                              context, const PrivateMessageForWindowsForm());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Send',
                              style: TextStyle(color: AppMeta.color),
                            ),
                            Icon(
                              Icons.send,
                              color: AppMeta.color,
                            ),
                          ],
                        ))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Abd-El-Rahman Ahmed')),
                    DataCell(Text('Egypt')),
                    DataCell(OutlinedButton(
                        onPressed: () {
                          NavigateTo(
                              context, const PrivateMessageForWindowsForm());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Send',
                              style: TextStyle(color: AppMeta.color),
                            ),
                            Icon(
                              Icons.send,
                              color: AppMeta.color,
                            ),
                          ],
                        ))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Denna Ahmed Saad')),
                    DataCell(Text('Egypt')),
                    DataCell(OutlinedButton(
                        onPressed: () {
                          NavigateTo(
                              context, const PrivateMessageForWindowsForm());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Send',
                              style: TextStyle(color: AppMeta.color),
                            ),
                            Icon(
                              Icons.send,
                              color: AppMeta.color,
                            ),
                          ],
                        ))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Ahmed mohamed ahmed')),
                    DataCell(Text('France')),
                    DataCell(OutlinedButton(
                        onPressed: () {
                          NavigateTo(
                              context, const PrivateMessageForWindowsForm());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Send',
                              style: TextStyle(color: AppMeta.color),
                            ),
                            Icon(
                              Icons.send,
                              color: AppMeta.color,
                            ),
                          ],
                        ))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('nada wageh')),
                    DataCell(Text('Egypt')),
                    DataCell(OutlinedButton(
                        onPressed: () {
                          NavigateTo(
                              context, const PrivateMessageForWindowsForm());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Send',
                              style: TextStyle(color: AppMeta.color),
                            ),
                            Icon(
                              Icons.send,
                              color: AppMeta.color,
                            ),
                          ],
                        ))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('bola ashraf saad')),
                    DataCell(Text('Iraq')),
                    DataCell(OutlinedButton(
                        onPressed: () {
                          NavigateTo(
                              context, const PrivateMessageForWindowsForm());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Send',
                              style: TextStyle(color: AppMeta.color),
                            ),
                            Icon(
                              Icons.send,
                              color: AppMeta.color,
                            ),
                          ],
                        ))),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Amany saad ahmed')),
                    DataCell(Text('Egypt')),
                    DataCell(OutlinedButton(
                        onPressed: () {
                          NavigateTo(
                              context, const PrivateMessageForWindowsForm());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Send',
                              style: TextStyle(color: AppMeta.color),
                            ),
                            Icon(
                              Icons.send,
                              color: AppMeta.color,
                            ),
                          ],
                        ))),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivateMessageForWindowsForm extends StatelessWidget {
  const PrivateMessageForWindowsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(28.0),
              child: Text(
                'The message will appeare only to the parent you choosed',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Message Title'),
                )),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  // expands: true,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Add Message Body'),
                )),
            const SizedBox(
              height: 50,
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Send !')),
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
/// ADD PUBLIC FOR DB
///
/// ADD PUBLIC FOR DB
///
/// ADD PUBLIC FOR DB
///
///
///
///
///
///
///
///
/// ADD PUBLIC FOR DB
///
/// ADD PUBLIC FOR DB
///
/// ADD PUBLIC FOR DB
///
///
///
///
///
///
///
///
/// ADD PUBLIC FOR DB
///
/// ADD PUBLIC FOR DB
///
/// ADD PUBLIC FOR DB
///
///

class PublicMessageFormForWindows extends StatelessWidget {
  const PublicMessageFormForWindows({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(28.0),
              child: Text(
                'The message will appeare to the whole parents on the class',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Message Title'),
                )),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  // expands: true,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Add Message Body'),
                )),
            const SizedBox(
              height: 50,
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Send !')),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
