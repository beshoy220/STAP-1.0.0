import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';
import 'package:school_manager/Data/Local_providers/gades_classes.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Services/Theme/theme.dart';
import 'package:school_manager/Presentation/Screens/admin_panal.dart';
import 'package:number_selection/number_selection.dart';

class StudentOperations extends StatelessWidget {
  const StudentOperations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppMeta.appName),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.output))
        ],
      ),
      body: Consumer(builder: (context, ThemeModel themeNotifier, child) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: studentOperations.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                onTap: () {
                  if (index == 0 || index == 1 || index == 2) {
                    NavigateTo(
                        context,
                        ViewGrades(
                          opreationType: index,
                        ));
                  } else if (index == 3) {
                    NavigateTo(context, const StudentStatus());
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
                          studentOperations[index][1],
                          size: 40,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          studentOperations[index][0].toString().tr(),
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
  const ViewGrades({Key? key, required this.opreationType}) : super(key: key);
  final dynamic opreationType;
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
                Map map = <String, dynamic>{
                  'operation': opreationType,
                  'grade': grades[index].toLowerCase()
                };
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      print(map);

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
  const ViewClasses({Key? key, required this.source}) : super(key: key);
  final Map source;
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
                Map<String, dynamic> destiney = {
                  'operation': source['operation'],
                  'grade': source['grade'],
                  'class': classes[index].toLowerCase()
                };
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      // print(destiney['operation']);
                      // print(destiney);
                      switch (destiney['operation']) {
                        case 0:
                          NavigateTo(
                              context,
                              AddStudent(
                                grade: destiney['grade'],
                                classs: destiney['class'],
                              ));
                          break;
                        case 1:
                          NavigateTo(
                              context,
                              DeleteStudent(
                                grade: destiney['grade'],
                                classs: destiney['class'],
                              ));
                          break;
                        case 2:
                          NavigateTo(
                              context,
                              EditStudent(
                                grade: destiney['grade'],
                                classs: destiney['class'],
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

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key, required this.grade, required this.classs})
      : super(key: key);
  final String grade;
  final String classs;
  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  bool selectedMale = false;
  bool selectedFemale = false;
  int numOfForms = 0;
  List forms = [];
  final DateTime _selectedDate = DateTime.now();
  Database db = Database();
  addForm() {
    forms.add({
      'name_controller': TextEditingController(),
      'parent_controller': TextEditingController(),
      'religion_controller': TextEditingController(),
      'national_id_controller': TextEditingController(),
      'phone_number': TextEditingController(),
      'birth_date': _selectedDate,
      'isMale': false,
      'isFemale': false,
      'gender': 'null'
    });
  }

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
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  height: 90,
                  child: NumberSelection(
                    theme: NumberSelectionTheme(
                        iconsColor: Colors.white,
                        outOfConstraintsColor: Colors.deepOrange),
                    initialValue: 0,
                    minValue: 0,
                    maxValue: 10,
                    direction: Axis.horizontal,
                    withSpring: false,
                    onChanged: (int value) {
                      setState(() {
                        numOfForms = value;
                      });
                      addForm();
                    },
                    enableOnOutOfConstraintsAnimation: true,
                  ),
                )),
            const SizedBox(
              height: 50,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: numOfForms,
              itemBuilder: (BuildContext context, int index) {
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
                            Text('${'Student'.tr()} ${index + 1}'),
                            TextField(
                              controller: forms[index]['name_controller'],
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                  labelText: "Enter Student Name".tr()),
                              keyboardType: TextInputType.name,
                            ),
                            TextField(
                              controller: forms[index]['parent_controller'],
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                  labelText: "Enter Parent Name".tr()),
                              keyboardType: TextInputType.name,
                            ),
                            TextField(
                              controller: forms[index]['religion_controller'],
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                  labelText: "Enter Religion".tr()),
                              keyboardType: TextInputType.name,
                            ),
                            TextField(
                              controller: forms[index]
                                  ['national_id_controller'],
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                  labelText: "Enter Student National ID".tr()),
                              keyboardType: TextInputType.number,
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: InternationalPhoneNumberInput(
                                onInputChanged: (PhoneNumber number) {
                                  print(number.phoneNumber);
                                },
                                onInputValidated: (bool value) {
                                  print(value);
                                },
                                selectorConfig: const SelectorConfig(
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
                                ),
                                ignoreBlank: false,
                                autoValidateMode: AutovalidateMode.disabled,
                                initialValue: PhoneNumber(isoCode: 'EG'),
                                textFieldController: forms[index]
                                    ['phone_number'],
                                formatInput: false,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                inputBorder: const OutlineInputBorder(),
                                onSaved: (PhoneNumber number) {
                                  print('On Saved: $number');
                                },
                              ),
                            ),
                            TextButton(
                              child: Row(
                                children: [
                                  const Icon(Icons.calendar_today_rounded),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      '${forms[index]['birth_date'].year}/${forms[index]['birth_date'].month}/${forms[index]['birth_date'].day}')
                                ],
                              ),
                              onPressed: () async {
                                DateTime? date = await showDatePicker(
                                  context: context,
                                  initialDatePickerMode: DatePickerMode.year,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                );
                                if (date != null &&
                                    date != forms[index]['birth_date']) {
                                  setState(() {
                                    forms[index]['birth_date'] = date;
                                  });
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InputChip(
                                  onSelected: (value) {
                                    if (!forms[index]['isFemale']) {
                                      setState(() {
                                        forms[index]['isMale'] = value;
                                        forms[index]['gender'] = 'male';
                                      });
                                    }
                                  },
                                  avatar: const Icon(
                                    Icons.male,
                                    color: Colors.white,
                                  ),
                                  selected: forms[index]['isMale'],
                                  label: Text(
                                    'male'.tr(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                                InputChip(
                                  onSelected: (value) {
                                    if (!forms[index]['isMale']) {
                                      setState(() {
                                        forms[index]['isFemale'] = value;
                                        forms[index]['gender'] = 'female';
                                      });
                                    }
                                  },
                                  avatar: const Icon(
                                    Icons.female,
                                    color: Colors.white,
                                  ),
                                  selected: forms[index]['isFemale'],
                                  label: Text(
                                    'female'.tr(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.pink,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
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
                      final snackBar = SnackBar(
                        content: Text('All users have been saved !'.tr()),
                        action: SnackBarAction(
                          textColor: Colors.blue,
                          label: 'Okay'.tr(),
                          onPressed: () {},
                        ),
                      );

                      (numOfForms != 0)
                          ? ScaffoldMessenger.of(context).showSnackBar(snackBar)
                          : debugPrint('no Users');
                      for (int i = 0; i < numOfForms; i++) {
                        db.registeUserAccWithIcromentForParent(
                            widget.grade,
                            widget.classs,
                            forms[i]['name_controller'].text,
                            forms[i]['parent_controller'].text,
                            forms[i]['religion_controller'].text,
                            forms[i]['national_id_controller'].text,
                            forms[i]['phone_number'].text,
                            i.toString(),
                            forms[i]['birth_date'],
                            forms[i]['gender']);
                      }
                    },
                    child: Text('Save all at once'.tr())),
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

class DeleteStudent extends StatefulWidget {
  DeleteStudent({Key? key, required this.grade, required this.classs})
      : super(key: key);
  String grade;
  String classs;
  @override
  State<DeleteStudent> createState() => _DeleteStudentState();
}

class _DeleteStudentState extends State<DeleteStudent> {
  bool selectAll = false;
  List<bool> checkBoxs = [];

  final TextEditingController _controllerForSearch = TextEditingController();

  List listOfDelete = [];

  showAlertDialog(
      BuildContext context, String id, String emailId, String gender) {
    Widget cancelButton = TextButton(
      child: Text("don't".tr()),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        "Delete".tr(),
        style: const TextStyle(color: Colors.red),
      ),
      onPressed: () {
        Navigator.of(context).pop();
        Database().deleteParentUserById(
            widget.grade, widget.classs, id, gender, emailId);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Delete From DataBase".tr()),
      content: Text(
          "You are tring to delete some people from database , Are you sure that you want to delete them?"
              .tr()),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

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
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2.2 * 4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                      child: Text(
                    'Registed students'.tr(),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controllerForSearch,
                    decoration: InputDecoration(
                      hintText: 'Search...'.tr(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: Text(
                                'Name'.tr(),
                                style: Theme.of(context).textTheme.titleLarge,
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: Text('Parent'.tr(),
                                  style:
                                      Theme.of(context).textTheme.titleLarge)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: Text('Parent Email (ID)'.tr(),
                                  style:
                                      Theme.of(context).textTheme.titleLarge)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: Row(
                              children: [
                                Text(
                                  'select all'.tr(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                Checkbox(
                                    value: selectAll,
                                    onChanged: (value) {
                                      setState(() {
                                        selectAll = value!;
                                      });
                                    })
                              ],
                            ),
                          )
                        ],
                      ),
                      const Divider(),
                      SizedBox(
                        child: FirebaseAnimatedList(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            query: Database()
                                .getUsersOfClass(widget.grade, widget.classs),
                            itemBuilder: (BuildContext context,
                                DataSnapshot snapshot,
                                Animation<double> animation,
                                int index) {
                              Map mappingValues = snapshot.value as Map;
                              String mappingKeysId = snapshot.key as String;
                              if (checkBoxs.length == index) {
                                checkBoxs.add(true);
                              }
                              if (listOfDelete.length == index) {
                                listOfDelete.add({
                                  'id': mappingKeysId,
                                  'gender': mappingValues['gender'],
                                  'email(id)': mappingValues['email(id)']
                                      .toString()
                                      .split('@')
                                      .first,
                                });
                              }

                              if (_controllerForSearch.text == '') {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            child: Text(
                                              mappingValues['name'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            )),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            child: Text(
                                              mappingValues['parent_name'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            )),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            child: Text(
                                              mappingValues['email(id)'],
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            )),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            child: selectAll
                                                ? Checkbox(
                                                    value: checkBoxs[index],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        checkBoxs[index] =
                                                            value!;

                                                        if (checkBoxs[index] ==
                                                            false) {
                                                          listOfDelete
                                                              .removeAt(index);
                                                          listOfDelete.insert(
                                                              index, 'null');
                                                        } else {
                                                          listOfDelete
                                                              .removeAt(index);
                                                          listOfDelete.insert(
                                                              index,
                                                              snapshot.key
                                                                  .toString());
                                                        }
                                                      });
                                                    })
                                                : OutlinedButton(
                                                    onPressed: () {
                                                      showAlertDialog(
                                                          context,
                                                          mappingKeysId,
                                                          mappingValues[
                                                                  'email(id)']
                                                              .toString()
                                                              .split('@')
                                                              .first,
                                                          mappingValues[
                                                              'gender']);
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text('Delete'.tr()),
                                                        const Icon(Icons.delete)
                                                      ],
                                                    ))),
                                      ],
                                    ),
                                    const Divider()
                                  ],
                                );
                              } else {
                                return (mappingValues['name'] ==
                                            _controllerForSearch.text ||
                                        mappingValues['parent_name'] ==
                                            _controllerForSearch.text)
                                    ? Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.3,
                                                  child: Text(
                                                    mappingValues['name'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.3,
                                                  child: Text(
                                                    mappingValues[
                                                        'parent_name'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.3,
                                                  child: Text(
                                                    mappingValues['email(id)'],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.3,
                                                  child: selectAll
                                                      ? Checkbox(
                                                          value: false,
                                                          onChanged: (value) {})
                                                      : OutlinedButton(
                                                          onPressed: () {
                                                            showAlertDialog(
                                                                context,
                                                                mappingKeysId,
                                                                mappingValues[
                                                                        'email(id)']
                                                                    .toString()
                                                                    .split('@')
                                                                    .first,
                                                                mappingValues[
                                                                    'gender']);
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text('Delete'
                                                                  .tr()),
                                                              const Icon(
                                                                  Icons.delete)
                                                            ],
                                                          ))),
                                            ],
                                          ),
                                          const Divider()
                                        ],
                                      )
                                    : Text(
                                        'No user found with name or parent name of ${_controllerForSearch.text}');
                              }
                            }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                        onPressed: () {
                          selectAll
                              ? showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Delete From DataBase"),
                                      content: const Text(
                                          "You are tring to delete some people from database , Are you sure that you want to delete them?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('cancel')),
                                        TextButton(
                                          child: const Text(
                                            "Delete",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            for (var i = 0;
                                                i < listOfDelete.length;
                                                i++) {
                                              if (listOfDelete[i] != 'null') {
                                                Database().deleteParentUserById(
                                                    widget.grade,
                                                    widget.classs,
                                                    listOfDelete[i]['id'],
                                                    listOfDelete[i]['gender'],
                                                    listOfDelete[i]
                                                        ['email(id)']);
                                              }
                                            }
                                          },
                                        ),
                                      ],
                                    );
                                    ;
                                  },
                                )
                              : debugPrint('object');
                          Navigator.pop(context);
                        },
                        child: selectAll
                            ? Text('Delete Selected Students'.tr())
                            : Text('Done'.tr())),
                  ),
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // List Search(String query) {
  //   return query == ""
  //       ? [
  //           ['Ahmed walee labib', 'walee labib', true],
  //           ['Nada youssef hesham', 'amany hesham', true],
  //           ['Nader youssef hesham', 'amany hesham', true],
  //         ]
  //       : rows.where((row) {
  //           final editedQuery = query.toLowerCase();
  //           final editedRow = row[0].toString().toLowerCase();

  //           return editedRow.contains(editedQuery);
  //         }).toList();
  // }
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

class EditStudent extends StatefulWidget {
  EditStudent({Key? key, required this.grade, required this.classs})
      : super(key: key);
  String grade;
  String classs;
  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
  List nameControllers = [];

  String messageError = '';
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
            const SizedBox(
              height: 10,
            ),
            FirebaseAnimatedList(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                query: Database().getUsersOfClass(widget.grade, widget.classs),
                itemBuilder: (context, snapshot, animation, index) {
                  nameControllers.add([
                    TextEditingController(),
                    TextEditingController(),
                    TextEditingController(),
                    TextEditingController()
                  ]);

                  Map mappingValues = snapshot.value as Map;
                  String mappingKeyId = snapshot.key as String;
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
                                '${'Student'.tr()} ${index + 1}',
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                mappingValues['name'],
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              TextField(
                                controller: nameControllers[index][0],
                                decoration: InputDecoration(
                                    labelText: "Student name".tr()),
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: nameControllers[index][1],
                                decoration: InputDecoration(
                                    labelText: "Parent name".tr()),
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: nameControllers[index][2],
                                decoration:
                                    InputDecoration(labelText: "Religion".tr()),
                                keyboardType: TextInputType.name,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextField(
                                controller: nameControllers[index][3],
                                decoration: InputDecoration(
                                    labelText: "National ID".tr()),
                                keyboardType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    mappingValues['birth_date']
                                        .toString()
                                        .split(' ')
                                        .first
                                        .toString(),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                mappingValues['gender']
                                    .toString()
                                    .split(' ')
                                    .first
                                    .toString()
                                    .tr(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: (mappingValues['gender']
                                                .toString()
                                                .split(' ')
                                                .first
                                                .toString() ==
                                            'male')
                                        ? Colors.blue
                                        : Colors.pink),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                messageError.tr(),
                                style: const TextStyle(color: Colors.red),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: OutlinedButton(
                                      onPressed: () {
                                        if (nameControllers[index]
                                                        [0]
                                                    .text ==
                                                '' ||
                                            nameControllers[index][1].text ==
                                                '' ||
                                            nameControllers[index][2].text ==
                                                '') {
                                          setState(() {
                                            messageError =
                                                'Fill all the inputs and check that national id equals 14 number !';
                                          });
                                        } else {
                                          final snackBar = SnackBar(
                                            content: Text(
                                                'User ${mappingValues['name']} edited !'),
                                            action: SnackBarAction(
                                              textColor: Colors.blue,
                                              label: 'Okay',
                                              onPressed: () {},
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                          Database().updateUserById(
                                              widget.grade,
                                              widget.classs,
                                              mappingKeyId,
                                              'name',
                                              nameControllers[index][0].text);
                                          Database().updateUserById(
                                              widget.grade,
                                              widget.classs,
                                              mappingKeyId,
                                              'parent_name',
                                              nameControllers[index][1].text);
                                          Database().updateUserById(
                                              widget.grade,
                                              widget.classs,
                                              mappingKeyId,
                                              'religion',
                                              nameControllers[index][2].text);
                                          Database().updateUserById(
                                              widget.grade,
                                              widget.classs,
                                              mappingKeyId,
                                              'national_id',
                                              nameControllers[index][3].text);
                                        }
                                      },
                                      child: Text('Done'.tr())),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 30,
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
/// STUDENT STATUS FROM DB
///
/// STUDENT STATUS FROM DB
///
/// STUDENT STATUS FROM DB
///
///
///
///
///
///
///
///
/// STUDENT STATUS FROM DB
///
/// STUDENT STATUS FROM DB
///
/// STUDENT STATUS FROM DB
///
///
///
///
///
///
///
///
/// STUDENT STATUS FROM DB
///
/// STUDENT STATUS FROM DB
///
/// STUDENT STATUS FROM DB
///
///

class StudentStatus extends StatefulWidget {
  const StudentStatus({super.key});

  @override
  State<StudentStatus> createState() => _StudentStatusState();
}

class _StudentStatusState extends State<StudentStatus> {
  String? gradeDropDownList;
  String? classDropDownList;
  bool dataRequested = false;
  late String males = '0';
  late String females = '0';
  @override
  void initState() {
    super.initState();
    Database().ref.child('/gender/student/female').onValue.listen((event) {
      setState(() {
        females = event.snapshot.value.toString();
      });
    });

    Database().ref.child('/gender/student/male').onValue.listen((event) {
      setState(() {
        males = event.snapshot.value.toString();
      });
    });
  }

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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 30,
                    child: Row(
                      children: [
                        Text(
                          '${'Registed Boys'.tr()} : $males',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Icon(
                          Icons.boy,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width - 20,
                  height: 30,
                  child: Row(
                    children: [
                      Text(
                        '${'Registed Girls'.tr()} : $females',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Icon(
                        Icons.girl,
                        color: Colors.pink,
                      )
                    ],
                  )),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('${'View status'.tr()} '),
                ),
                const SizedBox(
                  width: 20,
                ),
                DropdownButton<String>(
                  value: gradeDropDownList,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      gradeDropDownList = value!;
                    });
                  },
                  items: grades.map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  width: 20,
                ),
                DropdownButton<String>(
                  value: classDropDownList,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.blue),
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      classDropDownList = value!;
                    });
                  },
                  items: classes.map<DropdownMenuItem<String>>((dynamic value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            Container(
                child: dataRequested
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.2 * 8,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        child: Text(
                                          'Name'.tr(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        )),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        child: Text('Parent'.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge)),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.3,
                                        child: Text('National ID'.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge)),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      child: Row(
                                        children: [
                                          Text(
                                            'Religion'.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      child: Row(
                                        children: [
                                          Text(
                                            'Birth Date'.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      child: Row(
                                        children: [
                                          Text(
                                            'Phone Number'.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Row(
                                        children: [
                                          Text(
                                            'Parent Email (ID)'.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      child: Row(
                                        children: [
                                          Text(
                                            'Gender'.tr(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const Divider(),
                                Column(
                                  children: [
                                    FirebaseAnimatedList(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        query: Database().getUsersOfClass(
                                          gradeDropDownList
                                              .toString()
                                              .toLowerCase(),
                                          classDropDownList
                                              .toString()
                                              .toLowerCase(),
                                        ),
                                        itemBuilder: (BuildContext context,
                                            DataSnapshot snapshot,
                                            Animation<double> animation,
                                            int index) {
                                          Map mappingValues =
                                              snapshot.value as Map;
                                          return Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                      child: Text(
                                                        mappingValues['name'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium,
                                                      )),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                      child: Text(
                                                        mappingValues[
                                                            'parent_name'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium,
                                                      )),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                      child: Text(
                                                        mappingValues[
                                                            'national_id'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium,
                                                      )),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                      child: Text(mappingValues[
                                                          'religion'])),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                      child: Text(mappingValues[
                                                              'birth_date']
                                                          .toString()
                                                          .split(' ')
                                                          .first)),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                      child: Text(mappingValues[
                                                          'phone_number'])),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                      child: Text(mappingValues[
                                                          'email(id)'])),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                      child: Text(mappingValues[
                                                              'gender']
                                                          .toString()
                                                          .tr())),
                                                ],
                                              ),
                                              const Divider()
                                            ],
                                          );
                                        }),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: OutlinedButton(
                                            onPressed: () {
                                              setState(() {
                                                dataRequested = false;
                                              });
                                            },
                                            child: Text('Get Back !'.tr())),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          const SizedBox(
                            height: 150,
                          ),
                          const Icon(
                            Icons.spellcheck_outlined,
                            size: 35,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Select the grade & the class up to fetch data from server'
                                .tr()
                                .tr(),
                            style: Theme.of(context).textTheme.caption,
                          ),
                          Container(
                              child: (classDropDownList == null ||
                                      gradeDropDownList == null)
                                  ? const SizedBox(
                                      height: 10,
                                    )
                                  : TextButton(
                                      onPressed: () {
                                        setState(() {
                                          dataRequested = true;
                                        });
                                      },
                                      child: Text('Get from server'.tr())))
                        ],
                      )),
          ],
        ),
      ),
    );
  }
}
