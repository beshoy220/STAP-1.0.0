import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Local_providers/gades_classes.dart';
import 'package:school_manager/Data/Local_providers/list_of_week.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';

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

class SesssionViewGradesForWindows extends StatelessWidget {
  const SesssionViewGradesForWindows({Key? key}) : super(key: key);
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
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      NavigateTo(
                          context,
                          SesssionViewClassesForWindows(
                            grade: index,
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

class SesssionViewClassesForWindows extends StatelessWidget {
  SesssionViewClassesForWindows({Key? key, required this.grade})
      : super(key: key);
  var grade;

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
                Map<String, int> gradeClass = {'grade': grade, 'class': index};
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      print(gradeClass);
                      NavigateTo(context, TableLayOutForWindows());
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
///
///
/// TableLayOut
///
///
///
///
///
///

class TableLayOutForWindows extends StatefulWidget {
  const TableLayOutForWindows({Key? key}) : super(key: key);

  @override
  State<TableLayOutForWindows> createState() => _TableLayOutForWindowsState();
}

class _TableLayOutForWindowsState extends State<TableLayOutForWindows> {
  var sessionNumCodeController = TextEditingController(text: '1');

  var sessionSubjectCodeController = TextEditingController(text: 'Maths');

  var sessionTaecherCodeController = TextEditingController(text: 'Mr Ahmed');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppMeta.appName),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: daysOfWeek.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                      child: Text(
                    daysOfWeek[index].toString(),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  )),
                ),
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                          label: Text('Session',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Subject',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Name',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(
                          TextField(
                            controller: sessionNumCodeController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        DataCell(
                          TextField(
                            controller: sessionSubjectCodeController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        DataCell(
                          TextField(
                            controller: sessionTaecherCodeController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('2')),
                        DataCell(Text('Arabic')),
                        DataCell(Text('Mrs Amany')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('3')),
                        DataCell(Text('English')),
                        DataCell(Text('Mrs Denna')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('4')),
                        DataCell(Text('Scince')),
                        DataCell(Text('Mrs naglah')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('5')),
                        DataCell(Text('Scince')),
                        DataCell(Text('Mrs naglah')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('6')),
                        DataCell(Text('break')),
                        DataCell(Text('--')),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('7')),
                        DataCell(Text('Arabic')),
                        DataCell(Text('Mrs Amany')),
                      ]),
                    ],
                  ),
                ),
              ]);
            },
          ),
        ));
  }
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<Map> _books = [
//     {'id': 100, 'title': 'Flutter Basics', 'author': 'David John'},
//     {'id': 101, 'title': 'Flutter Basics', 'author': 'David John'},
//     {'id': 102, 'title': 'Git and GitHub', 'author': 'Merlin Nick'}
//   ];
//   int _currentSortColumn = 0;
//   bool _isSortAsc = true;
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('DataTable Demo'),
//         ),
//         body: ListView(
//           children: [_createDataTable()],
//         ),
//       ),
//     );
//   }

//   DataTable _createDataTable() {
//     return DataTable(
//       columns: _createColumns(),
//       rows: _createRows(),
//       sortColumnIndex: _currentSortColumn,
//       sortAscending: _isSortAsc,
//     );
//   }

//   List<DataColumn> _createColumns() {
//     return [
//       DataColumn(
//         label: Text('ID'),
//         onSort: (columnIndex, _) {
//           setState(() {
//             _currentSortColumn = columnIndex;
//             if (_isSortAsc) {
//               _books.sort((a, b) => b['id'].compareTo(a['id']));
//             } else {
//               _books.sort((a, b) => a['id'].compareTo(b['id']));
//             }
//             _isSortAsc = !_isSortAsc;
//           });
//         },
//       ),
//       DataColumn(label: Text('Book')),
//       DataColumn(label: Text('Author'))
//     ];
//   }

//   List<DataRow> _createRows() {
//     return _books
//         .map((book) => DataRow(cells: [
//               DataCell(Text('#${book['id']}')),
//               DataCell(Text(book['title'])),
//               DataCell(Text(book['author']))
//             ]))
//         .toList();
//   }
// }
