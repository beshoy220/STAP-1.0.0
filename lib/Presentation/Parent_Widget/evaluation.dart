import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';
import 'package:easy_localization/easy_localization.dart';

class Evaluation extends StatefulWidget {
  const Evaluation({super.key});

  @override
  State<Evaluation> createState() => _EvaluationState();
}

class _EvaluationState extends State<Evaluation> {
  String email = Auth().currentUser!.email!.split('@').first;
  int dem = 0;
  int nem = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Evaluation Total'.tr(),
              style: const TextStyle(fontSize: 22),
            ),
          ),
          FirebaseAnimatedList(
              defaultChild: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const CircularProgressIndicator(),
                    const SizedBox(height: 20),
                    Text('Loading...'.tr()),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              query: Database().getEvaluation(email),
              itemBuilder: (context, snapshot, animation, index) {
                Map mappingValues = snapshot.value as Map;
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            'Subject'.tr() +
                                ' :  ' +
                                snapshot.key.toString().capitalize().tr(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            '${'Exam mark'.tr() + ' :  ' + mappingValues['mark']}/' +
                                mappingValues['exam_mark'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            'Exam type'.tr() +
                                ' :  ' +
                                mappingValues['test_type'].toString().tr(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            (mappingValues['comment'].toString().isNotEmpty)
                                // ignore: prefer_interpolation_to_compose_strings
                                ? 'Comment'.tr() +
                                    ' : ' +
                                    mappingValues['comment']
                                : '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
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
