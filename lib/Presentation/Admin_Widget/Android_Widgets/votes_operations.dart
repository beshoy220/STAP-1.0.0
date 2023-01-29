import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';
import 'package:school_manager/Data/Local_providers/gades_classes.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Presentation/Screens/admin_panal.dart';

class ViewGradesForVotes extends StatelessWidget {
  const ViewGradesForVotes({Key? key}) : super(key: key);
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
                Map map = <String, int>{'grade': index};
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
                String classs = 'class ${index + 1}';
                String grade = 'grade ${source['grade'] + 1}';

                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: InkWell(
                    onTap: () {
                      NavigateTo(
                          context,
                          Votes(
                            grade: grade,
                            classs: classs,
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

class Votes extends StatefulWidget {
  String grade;
  String classs;

  Votes({super.key, required this.grade, required this.classs});

  @override
  State<Votes> createState() => _VotesState();
}

class _VotesState extends State<Votes> {
  MaterialColor nUrget = Colors.green;
  MaterialColor sUrget = Colors.amber;
  MaterialColor vUrget = Colors.red;

  bool selectNotUrget = false;
  bool selectSemiUrget = false;
  bool selectVeryUrget = false;

  final TextEditingController _controllerForTopic = TextEditingController();

  final TextEditingController _controllerForOption1 = TextEditingController();
  final TextEditingController _controllerForOption2 = TextEditingController();
  final TextEditingController _controllerForOption3 = TextEditingController();
  final TextEditingController _controllerForOption4 = TextEditingController();

  String errorMessage = '';
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                  controller: _controllerForTopic,
                  textAlignVertical: TextAlignVertical.top,
                  maxLines: 5,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      hintText: 'Topic to vote here'.tr())),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controllerForOption1,
                  decoration: InputDecoration(hintText: 'Option 1'.tr()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controllerForOption2,
                  decoration: InputDecoration(hintText: 'Option 2'.tr()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controllerForOption3,
                  decoration: InputDecoration(hintText: 'Option 3'.tr()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _controllerForOption4,
                  decoration: InputDecoration(hintText: 'Option 4'.tr()),
                ),
              ),
              Text(errorMessage.tr()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: OutlinedButton(
                        onPressed: () {
                          if (_controllerForTopic.text.isEmpty ||
                              _controllerForOption1.text.isEmpty ||
                              _controllerForOption2.text.isEmpty) {
                            setState(() {
                              errorMessage =
                                  'It seems that you did not fill the topic or option 1 or otption 2 or all of them ';
                            });
                          } else if (_controllerForOption1.text.length >= 41 ||
                              _controllerForOption2.text.length >= 41 ||
                              _controllerForOption3.text.length >= 41 ||
                              _controllerForOption4.text.length >= 41) {
                            setState(() {
                              errorMessage =
                                  'It seems that there is an option equal or more than 41 characters';
                            });
                          } else {
                            Database().setVote(
                                widget.grade,
                                widget.classs,
                                _controllerForTopic.text,
                                _controllerForOption1.text,
                                _controllerForOption2.text,
                                _controllerForOption3.text,
                                _controllerForOption4.text);
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Send vote'.tr()))),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            isDismissible: false,
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 30,
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
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        query: Database().veiwVoteForAdmin(
                                            widget.grade, widget.classs),
                                        itemBuilder: (context, snapshot,
                                            animation, index) {
                                          Map mappingValues =
                                              snapshot.value as Map;

                                          return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 30),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 0,
                                                          vertical: 20),
                                                      child: Text(
                                                        mappingValues['topic'],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium,
                                                      )),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppMeta.color,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  mappingValues[
                                                                          'option1']
                                                                      [
                                                                      'option'],
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              Text(
                                                                  mappingValues[
                                                                              'option1']
                                                                          [
                                                                          'num_of_voters']
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white))
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                AppMeta.color,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  mappingValues[
                                                                          'option2']
                                                                      [
                                                                      'option'],
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              Text(
                                                                  mappingValues[
                                                                              'option2']
                                                                          [
                                                                          'num_of_voters']
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white))
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  (mappingValues['option3']
                                                              ['option']
                                                          .toString()
                                                          .isNotEmpty)
                                                      ? SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: AppMeta
                                                                      .color,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        mappingValues['option3']
                                                                            [
                                                                            'option'],
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                    Text(
                                                                        mappingValues['option3']['num_of_voters']
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white))
                                                                  ],
                                                                ),
                                                              )),
                                                        )
                                                      : const Text(''),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  (mappingValues['option4']
                                                              ['option']
                                                          .toString()
                                                          .isNotEmpty)
                                                      ? SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: AppMeta
                                                                      .color,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                        mappingValues['option4']
                                                                            [
                                                                            'option'],
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                    Text(
                                                                        mappingValues['option4']['num_of_voters']
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white))
                                                                  ],
                                                                ),
                                                              )),
                                                        )
                                                      : const Text(''),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: OutlinedButton(
                                                        onPressed: () {
                                                          Database().delelteVote(
                                                              widget.grade,
                                                              widget.classs,
                                                              snapshot.key
                                                                  .toString(),
                                                              mappingValues[
                                                                  'topic']);
                                                        },
                                                        child: Text(
                                                            'Delete'.tr())),
                                                  )
                                                ],
                                              ));
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ElevatedButton(
                                            child:
                                                Text('Close BottomSheet'.tr()),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Text('View votes !'.tr())),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
