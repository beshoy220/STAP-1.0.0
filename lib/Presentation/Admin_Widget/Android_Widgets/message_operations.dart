import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';
import 'package:school_manager/Data/Local_providers/gades_classes.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Services/Theme/theme.dart';
import 'package:school_manager/Presentation/Screens/admin_panal.dart';

class MessageOperations extends StatelessWidget {
  const MessageOperations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AdminPanal()),
                    (Route<dynamic> route) => route is AdminPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: Consumer(builder: (context, ThemeModel themeNotifier, child) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: messageOperations.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                onTap: () {
                  switch (index) {
                    case 0:
                      NavigateTo(
                          context,
                          ViewGrades(
                            opreationType: index,
                          ));
                      break;
                    case 1:
                      NavigateTo(
                          context,
                          ViewGrades(
                            opreationType: index,
                          ));
                      break;
                    case 2:
                      NavigateTo(context, const MessageTeacher());
                      break;

                    default:
                  }
                },
                child: FutureBuilder(
                  future: ThemeModel().themeFromSharedPref(),
                  initialData: false,
                  builder: (BuildContext context, AsyncSnapshot snapshot) =>
                      Container(
                    decoration: BoxDecoration(
                        color: snapshot.data ? Colors.blueGrey : AppMeta.color,
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
                          messageOperations[index][0].toString().tr(),
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
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

class ViewGrades extends StatelessWidget {
  ViewGrades({Key? key, required this.opreationType}) : super(key: key);
  var opreationType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AdminPanal()),
                    (Route<dynamic> route) => route is AdminPanal);
              },
              icon: const Icon(Icons.output))
        ],
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
                      //   MaterialPageRoute(builder: (context) => ViewClasses()),
                      // );
                      NavigateTo(
                          context,
                          ViewClasses(
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
                                          grades[index].toString().tr(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${'Contains'.tr()} ${classes.length} ${'classes'.tr()}',
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

class ViewClasses extends StatelessWidget {
  ViewClasses({Key? key, required this.source}) : super(key: key);
  Map source;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AdminPanal()),
                    (Route<dynamic> route) => route is AdminPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: classes.length,
              itemBuilder: (BuildContext context, int index) {
                String grade = 'grade ${source['grade'] + 1}';
                String classs = 'class ${index + 1}';

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
                          NavigateTo(
                              context,
                              PrivateMessage(
                                grade: grade,
                                classs: classs,
                              ));
                          break;
                        case 1:
                          NavigateTo(
                              context,
                              PublicMessage(
                                grade: grade,
                                classs: classs,
                              ));
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
                                            classes[index].toString().tr(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Contains students'.tr(),
                                            style: const TextStyle(
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

class PrivateMessage extends StatefulWidget {
  String grade;
  String classs;

  PrivateMessage({Key? key, required this.grade, required this.classs})
      : super(key: key);
  @override
  State<PrivateMessage> createState() => _PrivateMessageState();
}

class _PrivateMessageState extends State<PrivateMessage> {
  bool selectAll = false;
  List<bool> checkBoxs = [];
  List<String> listOfMessageTo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AdminPanal()),
                    (Route<dynamic> route) => route is AdminPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: Text('Parent name'.tr())),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('select all'.tr()),
                              Checkbox(
                                  value: selectAll,
                                  onChanged: (value) {
                                    setState(() {
                                      selectAll = value!;
                                    });
                                  })
                            ],
                          )),
                    ],
                  ),
                  FirebaseAnimatedList(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    query:
                        Database().getUsersOfClass(widget.grade, widget.classs),
                    itemBuilder: (context, snapshot, animation, index) {
                      Map mappingValue = snapshot.value as Map;

                      if (checkBoxs.length == index) {
                        checkBoxs.add(true);
                      }

                      if (listOfMessageTo.length == index) {
                        listOfMessageTo.add(snapshot.key.toString());
                        // print('messages : ${listOfMessageTo.length} --- index : $index');
                      }

                      return Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child:
                                  Text(mappingValue['parent_name'].toString())),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: selectAll
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Checkbox(
                                          value: checkBoxs[index],
                                          onChanged: (value) {
                                            setState(() {
                                              checkBoxs[index] = value!;
                                              if (checkBoxs[index] == false) {
                                                listOfMessageTo.removeAt(index);
                                                listOfMessageTo.insert(
                                                    index, 'null');
                                              } else {
                                                listOfMessageTo.removeAt(index);
                                                listOfMessageTo.insert(index,
                                                    snapshot.key.toString());
                                              }
                                            });
                                          }),
                                    )
                                  : OutlinedButton(
                                      onPressed: () {
                                        NavigateTo(
                                            context,
                                            PrivateMessageForm(
                                                grade: widget.grade,
                                                classs: widget.classs,
                                                messageTo: [
                                                  snapshot.key.toString()
                                                ]));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Send !'.tr()),
                                          const Icon(Icons.arrow_right_rounded)
                                        ],
                                      ))),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            selectAll
                ? Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                          onPressed: () {
                            NavigateTo(
                                context,
                                PrivateMessageForm(
                                  grade: widget.grade,
                                  classs: widget.classs,
                                  messageTo: listOfMessageTo,
                                ));

                            // debugPrint(listOfMessageTo.toString());
                          },
                          child: Text('Message'.tr())),
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  )
          ],
        ),
      ),
    );
  }
}

class PrivateMessageForm extends StatefulWidget {
  List<String> messageTo;
  String grade;
  String classs;
  PrivateMessageForm(
      {super.key,
      required this.messageTo,
      required this.grade,
      required this.classs});

  @override
  State<PrivateMessageForm> createState() => _PrivateMessageFormState();
}

class _PrivateMessageFormState extends State<PrivateMessageForm> {
  String finalStatus = '';
  MaterialColor nUrget = Colors.green;
  MaterialColor sUrget = Colors.amber;
  MaterialColor vUrget = Colors.red;

  bool selectVeryUrget = false;
  bool selectSemiUrget = false;
  bool selectNotUrget = false;

  final TextEditingController _controllerForMessageTitle =
      TextEditingController();
  final TextEditingController _controllerForMessageBody =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // print(Auth().currentUser!.email!.split('@').first);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AdminPanal()),
                    (Route<dynamic> route) => route is AdminPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputChip(
                      selected: selectNotUrget,
                      onPressed: () {
                        if (selectSemiUrget == true ||
                            selectVeryUrget == true) {
                        } else {
                          setState(() {
                            switch (selectNotUrget) {
                              case false:
                                selectNotUrget = true;
                                finalStatus = 'not_urgent';
                                break;
                              case true:
                                selectNotUrget = false;
                                finalStatus = '';
                                break;
                            }
                          });
                        }
                      },
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        'Not-Urgent'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: nUrget,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputChip(
                      selected: selectSemiUrget,
                      onPressed: () {
                        if (selectNotUrget == true || selectVeryUrget == true) {
                        } else {
                          setState(() {
                            switch (selectSemiUrget) {
                              case false:
                                selectSemiUrget = true;
                                finalStatus = 'semi_urgent';

                                break;
                              case true:
                                selectSemiUrget = false;
                                finalStatus = '';

                                break;
                            }
                          });
                        }
                      },
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        'Semi-Urgent'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: sUrget,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputChip(
                      selected: selectVeryUrget,
                      onPressed: () {
                        if (selectNotUrget == true || selectSemiUrget == true) {
                        } else {
                          setState(() {
                            switch (selectVeryUrget) {
                              case false:
                                selectVeryUrget = true;
                                finalStatus = 'very_urgent';

                                break;
                              case true:
                                selectVeryUrget = false;
                                finalStatus = '';

                                break;
                            }
                          });
                        }
                      },
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        'Very-Urgent'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: vUrget,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: _controllerForMessageTitle,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Message Title'.tr()),
                )),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  controller: _controllerForMessageBody,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Add Message Body'.tr()),
                )),
            const SizedBox(
              width: 50,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    for (var i = 0; i < widget.messageTo.length; i++) {
                      if (widget.messageTo[i] != 'null') {
                        Database().sendPrivateMessageToParent(
                            widget.grade,
                            widget.classs,
                            widget.messageTo[i],
                            'admin-somebody',
                            _controllerForMessageTitle.text,
                            _controllerForMessageBody.text,
                            finalStatus);
                      } else {}
                    }
                  },
                  child: Text('Send !'.tr())),
            ),
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
/// ADD PUBLIC MESSAGE FOR DB
///
/// ADD PUBLIC MESSAGE FOR DB
///
/// ADD PUBLIC MESSAGE FOR DB
///
///
///
///
///
///
///
///
/// ADD PUBLIC MESSAGE FOR DB
///
/// ADD PUBLIC MESSAGE FOR DB
///
/// ADD PUBLIC MESSAGE FOR DB
///
///
///
///
///
///
///
///
/// ADD PUBLIC MESSAGE FOR DB
///
/// ADD PUBLIC MESSAGE FOR DB
///
/// ADD PUBLIC MESSAGE FOR DB
///
///
class PublicMessage extends StatefulWidget {
  String grade;
  String classs;

  PublicMessage({Key? key, required this.grade, required this.classs})
      : super(key: key);
  @override
  State<PublicMessage> createState() => _PublicMessageState();
}

class _PublicMessageState extends State<PublicMessage> {
  bool selectAll = false;
  List<bool> checkBoxs = [];
  List<String> listOfMessageTo = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AdminPanal()),
                    (Route<dynamic> route) => route is AdminPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: Text('Parent name'.tr())),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('select all'.tr()),
                              Checkbox(
                                  value: selectAll,
                                  onChanged: (value) {
                                    setState(() {
                                      selectAll = value!;
                                    });
                                  })
                            ],
                          )),
                    ],
                  ),
                  FirebaseAnimatedList(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    query:
                        Database().getUsersOfClass(widget.grade, widget.classs),
                    itemBuilder: (context, snapshot, animation, index) {
                      Map mappingValue = snapshot.value as Map;

                      if (checkBoxs.length == index) {
                        checkBoxs.add(true);
                      }

                      if (listOfMessageTo.length == index) {
                        listOfMessageTo.add(snapshot.key.toString());
                        // print('messages : ${listOfMessageTo.length} --- index : $index');
                      }

                      return Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child:
                                  Text(mappingValue['parent_name'].toString())),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: selectAll
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Checkbox(
                                          value: checkBoxs[index],
                                          onChanged: (value) {
                                            setState(() {
                                              checkBoxs[index] = value!;
                                              if (checkBoxs[index] == false) {
                                                listOfMessageTo.removeAt(index);
                                                listOfMessageTo.insert(
                                                    index, 'null');
                                              } else {
                                                listOfMessageTo.removeAt(index);
                                                listOfMessageTo.insert(index,
                                                    snapshot.key.toString());
                                              }
                                            });
                                          }),
                                    )
                                  : OutlinedButton(
                                      onPressed: () {
                                        NavigateTo(
                                            context,
                                            PublicMessageForm(
                                                grade: widget.grade,
                                                classs: widget.classs,
                                                messageTo: [
                                                  snapshot.key.toString()
                                                ]));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Send !'.tr()),
                                          const Icon(Icons.arrow_right_rounded)
                                        ],
                                      ))),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            selectAll
                ? Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: OutlinedButton(
                          onPressed: () {
                            NavigateTo(
                                context,
                                PublicMessageForm(
                                  grade: widget.grade,
                                  classs: widget.classs,
                                  messageTo: listOfMessageTo,
                                ));

                            // debugPrint(listOfMessageTo.toString());
                          },
                          child: const Text('Message')),
                    ),
                  )
                : const SizedBox(
                    height: 10,
                  )
          ],
        ),
      ),
    );
  }
}

class PublicMessageForm extends StatefulWidget {
  List<String> messageTo;
  String grade;
  String classs;
  PublicMessageForm(
      {super.key,
      required this.messageTo,
      required this.grade,
      required this.classs});

  @override
  State<PublicMessageForm> createState() => _PublicMessageFormState();
}

class _PublicMessageFormState extends State<PublicMessageForm> {
  String finalStatus = '';
  MaterialColor nUrget = Colors.green;
  MaterialColor sUrget = Colors.amber;
  MaterialColor vUrget = Colors.red;

  bool selectVeryUrget = false;
  bool selectSemiUrget = false;
  bool selectNotUrget = false;

  final TextEditingController _controllerForMessageTitle =
      TextEditingController();
  final TextEditingController _controllerForMessageBody =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AdminPanal()),
                    (Route<dynamic> route) => route is AdminPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputChip(
                      selected: selectNotUrget,
                      onPressed: () {
                        if (selectSemiUrget == true ||
                            selectVeryUrget == true) {
                        } else {
                          setState(() {
                            switch (selectNotUrget) {
                              case false:
                                selectNotUrget = true;
                                finalStatus = 'not_urgent';
                                break;
                              case true:
                                selectNotUrget = false;
                                finalStatus = '';
                                break;
                            }
                          });
                        }
                      },
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        'Not-Urgent'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: nUrget,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputChip(
                      selected: selectSemiUrget,
                      onPressed: () {
                        if (selectNotUrget == true || selectVeryUrget == true) {
                        } else {
                          setState(() {
                            switch (selectSemiUrget) {
                              case false:
                                selectSemiUrget = true;
                                finalStatus = 'semi_urgent';

                                break;
                              case true:
                                selectSemiUrget = false;
                                finalStatus = '';

                                break;
                            }
                          });
                        }
                      },
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        'Semi-Urgent'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: sUrget,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputChip(
                      selected: selectVeryUrget,
                      onPressed: () {
                        if (selectNotUrget == true || selectSemiUrget == true) {
                        } else {
                          setState(() {
                            switch (selectVeryUrget) {
                              case false:
                                selectVeryUrget = true;
                                finalStatus = 'very_urgent';

                                break;
                              case true:
                                selectVeryUrget = false;
                                finalStatus = '';

                                break;
                            }
                          });
                        }
                      },
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        'Very-Urgent'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: vUrget,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: _controllerForMessageTitle,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Message Title'.tr()),
                )),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  textAlignVertical: TextAlignVertical.top,
                  controller: _controllerForMessageBody,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Add Message Body'.tr()),
                )),
            const SizedBox(
              width: 50,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    for (var i = 0; i < widget.messageTo.length; i++) {
                      if (widget.messageTo[i] != 'null') {
                        Database().sendPuplicMessageToParent(
                            widget.grade,
                            widget.classs,
                            widget.messageTo[i],
                            'admin-somebody',
                            _controllerForMessageTitle.text,
                            _controllerForMessageBody.text,
                            finalStatus);
                      }
                    }
                  },
                  child: Text('Send !'.tr())),
            ),
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
/// SEND TEACHER MESSAGE FOR DB
///
/// SEND TEACHER MESSAGE FOR DB
///
/// SEND TEACHER MESSAGE FOR DB
///
///
///
///
///
///
///
///
/// SEND TEACHER MESSAGE FOR DB
///
/// SEND TEACHER MESSAGE FOR DB
///
/// SEND TEACHER MESSAGE FOR DB
///
///
///
///
///
///
///
///
/// SEND TEACHER MESSAGE FOR DB
///
/// SEND TEACHER MESSAGE FOR DB
///
/// SEND TEACHER MESSAGE FOR DB
///
///

class MessageTeacher extends StatefulWidget {
  const MessageTeacher({super.key});

  @override
  State<MessageTeacher> createState() => _MessageTeacherState();
}

class _MessageTeacherState extends State<MessageTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppMeta.appName), actions: [
        IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const AdminPanal()),
                  (Route<dynamic> route) => route is AdminPanal);
            },
            icon: const Icon(Icons.output))
      ]),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: subjects.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 18.0, left: 18, right: 18),
                        child: InkWell(
                          onTap: () {
                            NavigateTo(
                                context,
                                ViewTeachers(
                                    subject: subjects[index][1]
                                        .toString()
                                        .toLowerCase()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                gradient: const LinearGradient(
                                    colors: [Colors.blue, Colors.indigo])),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Icon(
                                        subjects[index][0],
                                        color: Colors.white,
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            subjects[index][1].toString().tr(),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            // ignore: prefer_interpolation_to_compose_strings
                                            'All teachers of'.tr() +
                                                ' ${subjects[index][1].toString().tr()} ' +
                                                'will be nested here'.tr(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20)
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewTeachers extends StatefulWidget {
  ViewTeachers({super.key, required this.subject});
  final String subject;

  @override
  State<ViewTeachers> createState() => _ViewTeachersState();
}

class _ViewTeachersState extends State<ViewTeachers> {
  bool selectAll = false;
  List<bool> checkBoxs = [];
  List<String> listOfMessageTo = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AdminPanal()),
                    (Route<dynamic> route) => route is AdminPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: Text('Teacher name'.tr())),
                      SizedBox(
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('select all'.tr()),
                              Checkbox(
                                  value: selectAll,
                                  onChanged: (value) {
                                    setState(() {
                                      selectAll = value!;
                                    });
                                  })
                            ],
                          )),
                    ],
                  ),
                  FirebaseAnimatedList(
                    shrinkWrap: true,
                    defaultChild: Center(
                      child: Column(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Fetching data')
                        ],
                      ),
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    query: Database().getTeachersBySubject(widget.subject),
                    itemBuilder: (context, snapshot, animation, index) {
                      Map mappingValue = snapshot.value as Map;
                      if (checkBoxs.length == index) {
                        checkBoxs.add(true);
                      }

                      if (listOfMessageTo.length == index) {
                        listOfMessageTo.add(snapshot.key.toString());
                      }

                      return Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: Text(mappingValue['name'])),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: selectAll
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Checkbox(
                                          value: checkBoxs[index],
                                          onChanged: (value) {
                                            setState(() {
                                              checkBoxs[index] = value!;
                                              if (checkBoxs[index] == false) {
                                                listOfMessageTo.removeAt(index);
                                                listOfMessageTo.insert(
                                                    index, 'null');
                                              } else {
                                                listOfMessageTo.removeAt(index);
                                                listOfMessageTo.insert(index,
                                                    snapshot.key.toString());
                                              }
                                            });
                                          }),
                                    )
                                  : OutlinedButton(
                                      onPressed: () {
                                        NavigateTo(
                                            context,
                                            TeacherMessageForm(messageTo: [
                                              snapshot.key.toString()
                                            ], subject: widget.subject));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Send !'.tr()),
                                          const Icon(Icons.arrow_right_rounded)
                                        ],
                                      ))),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            selectAll
                ? Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: OutlinedButton(
                            onPressed: () {
                              NavigateTo(
                                  context,
                                  TeacherMessageForm(
                                      messageTo: listOfMessageTo,
                                      subject: widget.subject));
                            },
                            child: const Text('Message'))),
                  )
                : const SizedBox(
                    height: 10,
                  )
          ],
        ),
      ),
    );
  }
}

class TeacherMessageForm extends StatefulWidget {
  List messageTo;
  String subject;

  TeacherMessageForm(
      {super.key, required this.messageTo, required this.subject});

  @override
  State<TeacherMessageForm> createState() => _TeacherMessageFormState();
}

class _TeacherMessageFormState extends State<TeacherMessageForm> {
  String finalStatus = '';
  MaterialColor nUrget = Colors.green;
  MaterialColor sUrget = Colors.amber;
  MaterialColor vUrget = Colors.red;

  bool selectNotUrget = false;
  bool selectSemiUrget = false;
  bool selectVeryUrget = false;

  final TextEditingController _controllerForMessageTitle =
      TextEditingController();
  final TextEditingController _controllerForMessageBody =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const AdminPanal()),
                    (Route<dynamic> route) => route is AdminPanal);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputChip(
                      selected: selectNotUrget,
                      onPressed: () {
                        if (selectSemiUrget == true ||
                            selectVeryUrget == true) {
                        } else {
                          setState(() {
                            switch (selectNotUrget) {
                              case false:
                                selectNotUrget = true;
                                finalStatus = 'not_urgent';
                                break;
                              case true:
                                selectNotUrget = false;
                                finalStatus = '';

                                break;
                            }
                          });
                        }
                      },
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        'Not-Urgent'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: nUrget,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputChip(
                      selected: selectSemiUrget,
                      onPressed: () {
                        if (selectNotUrget == true || selectVeryUrget == true) {
                        } else {
                          setState(() {
                            switch (selectSemiUrget) {
                              case false:
                                selectSemiUrget = true;
                                finalStatus = 'semi_urgent';

                                break;
                              case true:
                                selectSemiUrget = false;
                                finalStatus = '';

                                break;
                            }
                          });
                        }
                      },
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        'Semi-Urgent'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: sUrget,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InputChip(
                      selected: selectVeryUrget,
                      onPressed: () {
                        if (selectNotUrget == true || selectSemiUrget == true) {
                        } else {
                          setState(() {
                            switch (selectVeryUrget) {
                              case false:
                                selectVeryUrget = true;
                                finalStatus = 'very_urgent';

                                break;
                              case true:
                                selectVeryUrget = false;
                                finalStatus = '';

                                break;
                            }
                          });
                        }
                      },
                      labelPadding: const EdgeInsets.all(2.0),
                      label: Text(
                        'Very-Urgent'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: vUrget,
                      elevation: 6.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: _controllerForMessageTitle,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Message Title'.tr()),
                )),
            Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                  controller: _controllerForMessageBody,
                  textAlignVertical: TextAlignVertical.top,
                  // expands: true,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Add Message Body'.tr()),
                )),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AdminPanal()),
                          (Route<dynamic> route) => route is AdminPanal);
                      // print(widget.messageTo);

                      for (var i = 0; i < widget.messageTo.length; i++) {
                        if (widget.messageTo[i] != 'null') {
                          Database().sendTeacherMessage(
                              widget.subject,
                              widget.messageTo[i],
                              Auth().currentUser!.email!.split('@').first,
                              _controllerForMessageTitle.text,
                              _controllerForMessageBody.text,
                              finalStatus);
                        }
                      }
                    },
                    child: Text('Send !'.tr())),
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
