import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  List<bool> chipSelection = [true, false, false];
  int selectedMessageType = 0;
  List messageType = [
    const Votes(),
    const PrivateMessage(),
    const PublicMessage()
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                      selected: chipSelection[0],
                      backgroundColor: AppMeta.color,
                      onSelected: (selected) {
                        setState(() {
                          chipSelection[0] = selected;
                          chipSelection[1] = !selected;
                          chipSelection[2] = !selected;
                        });
                        if (selected == true) {
                          setState(() {
                            selectedMessageType = 0;
                          });
                        }
                      },
                      avatar: CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        child: const Icon(Icons.align_vertical_bottom),
                      ),
                      label: Text(
                        'Votes'.tr(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                      selected: chipSelection[1],
                      backgroundColor: AppMeta.color,
                      onSelected: (selected) {
                        setState(() {
                          chipSelection[0] = !selected;
                          chipSelection[1] = selected;
                          chipSelection[2] = !selected;
                        });
                        if (selected == true) {
                          setState(() {
                            selectedMessageType = 1;
                          });
                        }
                      },
                      avatar: CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        child: const Icon(Icons.private_connectivity),
                      ),
                      label: Text(
                        'Private Messages'.tr(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ChoiceChip(
                      selected: chipSelection[2],
                      backgroundColor: AppMeta.color,
                      onSelected: (selected) {
                        setState(() {
                          chipSelection[0] = !selected;
                          chipSelection[1] = !selected;
                          chipSelection[2] = selected;
                        });
                        if (selected == true) {
                          setState(() {
                            selectedMessageType = 2;
                          });
                        }
                      },
                      avatar: CircleAvatar(
                        backgroundColor: Colors.grey.shade800,
                        child: const Icon(Icons.public),
                      ),
                      label: Text(
                        'Public Messages'.tr(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          messageType.elementAt(selectedMessageType)
        ],
      ),
    );
  }
}

class Votes extends StatefulWidget {
  const Votes({super.key});

  @override
  State<Votes> createState() => _VotesState();
}

class _VotesState extends State<Votes> {
  String email = Auth().currentUser!.email!.split('@').first;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAnimatedList(
      reverse: true,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      defaultChild: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 4),
            const CircularProgressIndicator(),
            const SizedBox(height: 20),
            Text('Loading...'.tr())
          ],
        ),
      ),
      query: Database().getVotesForParent(email),
      itemBuilder: (context, snapshot, animation, index) {
        Map mappingValue = snapshot.value as Map;
        int voters1 = mappingValue['option1']['num_of_voters'] + 1;
        int voters2 = mappingValue['option2']['num_of_voters'] + 1;
        int voters3 = mappingValue['option3']['num_of_voters'] + 1;
        int voters4 = mappingValue['option4']['num_of_voters'] + 1;
        int total = mappingValue['option1']['num_of_voters'] +
            mappingValue['option2']['num_of_voters'] +
            mappingValue['option3']['num_of_voters'] +
            mappingValue['option4']['num_of_voters'] +
            1;

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                mappingValue['topic'],
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            InkWell(
                onTap: () {
                  Database().voteOperation(
                      mappingValue['path'].toString().split('-').last,
                      mappingValue['path'].toString().split('-').first,
                      mappingValue['topic'],
                      email,
                      'option1');
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Stack(children: [
                    Container(
                      width: MediaQuery.of(context).size.width *
                          voters1 /
                          total *
                          100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                          alignment:
                              (context.locale == const Locale('en', 'US'))
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Text(
                            mappingValue['option1']['num_of_voters'].toString(),
                            style: const TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              mappingValue['option1']['option'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                )),
            InkWell(
                onTap: () {
                  Database().voteOperation(
                      mappingValue['path'].toString().split('-').last,
                      mappingValue['path'].toString().split('-').first,
                      mappingValue['topic'],
                      email,
                      'option2');
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Stack(children: [
                    Container(
                      width: MediaQuery.of(context).size.width *
                          voters2 /
                          total *
                          100,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                          alignment:
                              (context.locale == const Locale('en', 'US'))
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                          child: Text(
                            mappingValue['option2']['num_of_voters'].toString(),
                            style: const TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              mappingValue['option2']['option'],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                )),
            (mappingValue['option3']['option'].toString().isNotEmpty)
                ? InkWell(
                    onTap: () {
                      Database().voteOperation(
                          mappingValue['path'].toString().split('-').last,
                          mappingValue['path'].toString().split('-').first,
                          mappingValue['topic'],
                          email,
                          'option3');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Stack(children: [
                        Container(
                          width: MediaQuery.of(context).size.width *
                              voters3 /
                              total *
                              100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Align(
                              alignment:
                                  (context.locale == const Locale('en', 'US'))
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: Text(
                                mappingValue['option3']['num_of_voters']
                                    .toString(),
                                style: const TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  mappingValue['option3']['option'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ))
                : const Text(''),
            (mappingValue['option4']['option'].toString().isNotEmpty)
                ? InkWell(
                    onTap: () {
                      Database().voteOperation(
                          mappingValue['path'].toString().split('-').last,
                          mappingValue['path'].toString().split('-').first,
                          mappingValue['topic'],
                          email,
                          'option4');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Stack(children: [
                        Container(
                          width: MediaQuery.of(context).size.width *
                              voters4 /
                              total *
                              100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Align(
                              alignment:
                                  (context.locale == const Locale('en', 'US'))
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                              child: Text(
                                mappingValue['option4']['num_of_voters']
                                    .toString(),
                                style: const TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  mappingValue['option4']['option'],
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ))
                : const Text('')
          ],
        );
      },
    );
  }
}

class PrivateMessage extends StatefulWidget {
  const PrivateMessage({Key? key}) : super(key: key);

  @override
  State<PrivateMessage> createState() => _PrivateMessageState();
}

class _PrivateMessageState extends State<PrivateMessage> {
  List colorsText = [
    [Colors.red, 'Red for urgent messages'],
    [Colors.amber, 'Yellow for semi-urgent messages'],
    [Colors.green, 'Green For non-urgent messages']
  ];

  String email = Auth().currentUser!.email!.split('@').first;
  @override
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: colorsText.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        decoration: BoxDecoration(
                            color: colorsText[index][0],
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        colorsText[index][1].toString().tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          FirebaseAnimatedList(
            reverse: true,
            defaultChild: Center(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 4),
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20),
                  Text('Loading...'.tr())
                ],
              ),
            ),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            query: Database().getPrivateMessageForParent(email),
            itemBuilder: (context, snapshot, animation, index) {
              Map mappingValue = snapshot.value as Map;
              Color urgetStatus = mappingValue['status'] == 'very_urgent'
                  ? Colors.red
                  : mappingValue['status'] == 'semi_urgent'
                      ? Colors.yellow
                      : Colors.green;
              return Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(139, 88, 88, 88)),
                  child: Row(children: [
                    Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Icon(
                                Icons.mode_comment_outlined,
                                color: urgetStatus,
                              ),
                            ),
                          ),
                        )),
                    Expanded(
                        flex: 6,
                        child: Center(
                          child: Stack(children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    ' ${mappingValue['title']}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 18.0, right: 8.0, left: 5.0),
                                  child: Text(
                                    mappingValue['body'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 18.0, right: 8.0, left: 5.0),
                                  child: Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'From'.tr() +
                                        ' : ' +
                                        mappingValue['from'] +
                                        '\n' +
                                        'Date'.tr() +
                                        ' : ' +
                                        mappingValue['date'],
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment:
                                    (context.locale == const Locale('en', 'US'))
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: urgetStatus,
                                      borderRadius:
                                          BorderRadius.circular(1000)),
                                  width: 12,
                                  height: 12,
                                ),
                              ),
                            )
                          ]),
                        ))
                  ]),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PublicMessage extends StatefulWidget {
  const PublicMessage({Key? key}) : super(key: key);

  @override
  State<PublicMessage> createState() => _PublicMessageState();
}

class _PublicMessageState extends State<PublicMessage> {
  String email = Auth().currentUser!.email!.split('@').first;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: FirebaseAnimatedList(
        reverse: true,
        defaultChild: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 4),
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              const Text('Loading...')
            ],
          ),
        ),
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        query: Database().getPublicMessageForParent(email),
        itemBuilder: (context, snapshot, animation, index) {
          Map mappingValue = snapshot.value as Map;
          Color urgetStatus = mappingValue['status'] == 'very_urgent'
              ? Colors.red
              : mappingValue['status'] == 'semi_urgent'
                  ? Colors.yellow
                  : Colors.green;
          // urgetStatus.add(Colors.red);

          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color.fromARGB(255, 134, 148, 227)),
              child: Row(children: [
                Expanded(
                    flex: 2,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Icon(
                            Icons.notifications,
                            color: urgetStatus,
                          ),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 6,
                    child: Center(
                      child: Stack(children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                ' ${mappingValue['title']}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 18.0, right: 8.0, left: 5.0),
                              child: Text(
                                mappingValue['body'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 18.0, right: 8.0, left: 5.0),
                              child: Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                '${'From'.tr() + ' : ' + mappingValue['from']}\n${'Date'.tr()} : ' +
                                    mappingValue['date'],
                                style: Theme.of(context).textTheme.caption,
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment:
                                (context.locale == const Locale('en', 'US'))
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: urgetStatus,
                                  borderRadius: BorderRadius.circular(1000)),
                              width: 12,
                              height: 12,
                            ),
                          ),
                        )
                      ]),
                    ))
              ]),
            ),
          );
        },
      ),
    );
  }
}
