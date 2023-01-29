import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:number_selection/number_selection.dart';
import 'package:provider/provider.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Data/Local_providers/stages.dart';
import 'package:school_manager/Data/Local_providers/subject_dropdownlist.dart';
import 'package:school_manager/Services/Theme/theme.dart';
import 'package:school_manager/Presentation/Screens/admin_panal.dart';

class TeacherOperations extends StatelessWidget {
  const TeacherOperations({super.key});

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
          itemCount: teacherOperations.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                onTap: () {
                  switch (index) {
                    case 0:
                      NavigateTo(context, const AddTeacher());

                      break;
                    case 1:
                      NavigateTo(context, const DeleteTeacher());

                      break;
                    case 2:
                      NavigateTo(context, TeacherStatus());
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
                          teacherOperations[index][1],
                          size: 40,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          teacherOperations[index][0].toString().tr(),
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

class AddTeacher extends StatefulWidget {
  const AddTeacher({Key? key}) : super(key: key);
  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  bool selectedMale = false;
  bool selectedFemale = false;
  int numOfForms = 0;
  List forms = [];
  final DateTime _selectedDate = DateTime.now();
  // var dropdownValue = stages.first;

  String errorMessage = '';
  addForm() {
    forms.add({
      'name_controller': TextEditingController(),
      'religion_controller': TextEditingController(),
      'national_id_controller': TextEditingController(),
      'phone_number': TextEditingController(),
      'stage_1': stages.first,
      'stage_2': stages.first,
      'stage_3': stages.first,
      'subject': subjectForDropdownlist.first,
      'birth_date': _selectedDate,
      'isMale': false,
      'isFemale': false,
      'gender': ''
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
                            Text('${'Teacher'.tr()} ${index + 1}'),
                            TextField(
                              controller: forms[index]['name_controller'],
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                  labelText: "Enter Teacher Name".tr()),
                              keyboardType: TextInputType.name,
                            ),
                            TextField(
                              controller: forms[index]['subject_controller'],
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                  labelText: "Enter Religion".tr()),
                              keyboardType: TextInputType.name,
                            ),
                            TextField(
                              controller: forms[index]['subject_controller'],
                              onChanged: (value) {},
                              decoration: InputDecoration(
                                  labelText: "Enter Teacher National ID".tr()),
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
                            Text(
                              errorMessage.tr(),
                              style: const TextStyle(color: Colors.red),
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
                            Row(
                              children: [
                                Text('${'Stage'.tr()} :  '),
                                DropdownButton<String>(
                                  value: forms[index]['stage_1'],
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      forms[index]['stage_1'] = value;
                                    });
                                  },
                                  items: stages.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value.tr()),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('${'Stage'.tr()} :  '),
                                DropdownButton<String>(
                                  value: forms[index]['stage_2'],
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? value) {
                                    // This is called when the user selects an item.
                                    setState(() {
                                      forms[index]['stage_2'] = value!;
                                    });
                                  },
                                  items: stages.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value.tr()),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('${'Stage'.tr()} :  '),
                                DropdownButton<String>(
                                  value: forms[index]['stage_3'],
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      forms[index]['stage_3'] = value!;
                                    });
                                  },
                                  items: stages.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value.tr()),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('${'Subject'.tr()} :  '),
                                DropdownButton<String>(
                                  value: forms[index]['subject'],
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.deepPurpleAccent,
                                  ),
                                  onChanged: (String? value) {
                                    setState(() {
                                      forms[index]['subject'] = value!;
                                    });
                                  },
                                  items: subjectForDropdownlist
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value.tr()),
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
                                    'Male'.tr(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                                InputChip(
                                  onSelected: (value) {
                                    if (!forms[index]['isMale']) {
                                      setState(() {
                                        forms[index]['isFemale'] = value;
                                        forms[index]['gender'] = 'male';
                                      });
                                    }
                                  },
                                  avatar: const Icon(
                                    Icons.female,
                                    color: Colors.white,
                                  ),
                                  selected: forms[index]['isFemale'],
                                  label: Text(
                                    'Female'.tr(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.pink,
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                    onPressed: () {
                      for (int i = 0; i < numOfForms; i++) {
                        Database().registeUserAccWithIcromentForTeacher(
                            forms[i]['name_controller'].text,
                            forms[i]['religion_controller'].text,
                            forms[i]['national_id_controller'].text,
                            forms[i]['phone_number'].text,
                            forms[i]['birth_date'],
                            forms[i]['gender'],
                            forms[i]['stage_1'],
                            forms[i]['stage_2'],
                            forms[i]['stage_3'],
                            forms[i]['subject'],
                            i.toString());
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const AdminPanal()),
                            (Route<dynamic> route) => route is AdminPanal);

                        // setState(() {
                        //   errorMessage =
                        //       'The national ID or phone nuber is not filled correctly (More or less than expected numbers)';
                        // });

                      }
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
                    },
                    child: Text('Save all at once'.tr())),
              ),
            ),
            const SizedBox(
              height: 10,
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

class DeleteTeacher extends StatefulWidget {
  const DeleteTeacher({Key? key}) : super(key: key);
  @override
  State<DeleteTeacher> createState() => _DeleteTeacherState();
}

class _DeleteTeacherState extends State<DeleteTeacher> {
  bool selectAll = false;
  showAlertDialog(
      BuildContext context, String subject, String id, String gender) {
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
        Database().deleteUserByIdTeacher(subject, id, gender);
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
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Center(
                        child: Text(
                      'Registed teacher'.tr(),
                      style: const TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        SizedBox(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2.2 * 4,
                            child: FirebaseAnimatedList(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                query: Database().getUsersTeacher(),
                                itemBuilder: (BuildContext context,
                                    DataSnapshot snapshot,
                                    Animation<double> animation,
                                    int index) {
                                  String subject = snapshot.key as String;

                                  if (snapshot.exists) {
                                    return Column(
                                      children: [
                                        Container(
                                          color: const Color.fromARGB(
                                              171, 0, 56, 185),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(18.0),
                                                child: Text(
                                                  subject
                                                      .toString()
                                                      .capitalize()
                                                      .tr(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displaySmall,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
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
                                                        'Teacher'.tr(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleLarge,
                                                      )),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                      child: Text('Stage'.tr(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge)),
                                                  SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                      child: Text(
                                                          'Teacher ID'.tr(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleLarge)),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.3,
                                                    child: Row(
                                                      children: const [
                                                        // Text(
                                                        //   '',
                                                        //   style:
                                                        //       Theme.of(context)
                                                        //           .textTheme
                                                        //           .titleLarge,
                                                        // ),
                                                        // Checkbox(
                                                        //     value: selectAll,
                                                        //     onChanged: (value) {
                                                        //       setState(() {
                                                        //         selectAll =
                                                        //             value!;
                                                        //       });
                                                        //     })
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const Divider(),
                                            ],
                                          ),
                                        ),
                                        const Divider(),
                                        FirebaseAnimatedList(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            query: Database()
                                                .getTeachersBySubject(
                                                    subject.toString()),
                                            itemBuilder: (context, snapshot,
                                                animation, index) {
                                              Map mappingValues =
                                                  snapshot.value as Map;
                                              String id =
                                                  snapshot.key as String;

                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.3,
                                                        child: Text(
                                                          mappingValues['name']
                                                              .toString(),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium,
                                                        )),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.3,
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: 3,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          itemBuilder:
                                                              (context,
                                                                      index) =>
                                                                  Text(
                                                                    ((mappingValues['stages'] as List)[index] ==
                                                                            'None')
                                                                        ? ''
                                                                        : (mappingValues['stages']
                                                                                as List)[index]
                                                                            .toString()
                                                                            .tr(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleMedium,
                                                                  )),
                                                    ),
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.3,
                                                        child: Text(
                                                          mappingValues[
                                                              'email(id)'],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleMedium,
                                                        )),
                                                    SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.3,
                                                        child: selectAll
                                                            ? Checkbox(
                                                                value: false,
                                                                onChanged:
                                                                    (value) {})
                                                            : OutlinedButton(
                                                                onPressed: () {
                                                                  showAlertDialog(
                                                                      context,
                                                                      subject,
                                                                      id,
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
                                                                    const Icon(Icons
                                                                        .delete)
                                                                  ],
                                                                ))),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ],
                                    );
                                  } else {
                                    return const Text('No data');
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: selectAll
                            ? Text('Delete Selected Teachers'.tr())
                            : Text('Save'.tr())),
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
/// TEACHER STATUS FROM DB
///
/// TEACHER STATUS FROM DB
///
/// TEACHER STATUS FROM DB
///
///
///
///
///
///
///
///
/// TEACHER STATUS FROM DB
///
/// TEACHER STATUS FROM DB
///
/// TEACHER STATUS FROM DB
///
///
///
///
///
///
///
///
/// TEACHER STATUS FROM DB
///
/// TEACHER STATUS FROM DB
///
/// TEACHER STATUS FROM DB
///
///

class TeacherStatus extends StatefulWidget {
  TeacherStatus({super.key});

  @override
  State<TeacherStatus> createState() => _TeacherStatusState();
}

class _TeacherStatusState extends State<TeacherStatus> {
  late String males = '0';

  late String females = '0';

  @override
  void initState() {
    super.initState();
    Database().ref.child('/gender/teacher/female').onValue.listen((event) {
      setState(() {
        females = event.snapshot.value.toString();
      });
    });

    Database().ref.child('/gender/teacher/male').onValue.listen((event) {
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  '${'Registed Men'.tr()} : $males',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Icon(
                  Icons.boy,
                  color: Colors.blue,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  '${'Registed Women'.tr()} : $females',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Icon(Icons.girl, color: Colors.pink)
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          // Text('Who is absent today :'),
          // Padding(
          //   padding: EdgeInsets.all(18.0),
          //   child: _createTable(),
          // ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
