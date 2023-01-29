import 'package:firebase_database/firebase_database.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';

class Database {
  final ref = FirebaseDatabase.instance.ref();

  registeUserAccWithIcromentForParent(
      String grade,
      String classs,
      String name,
      String parentName,
      String religion,
      String nationalId,
      String phone,
      String i,
      DateTime birthDate,
      String gender) {
    ref.child('gender/student/$gender').once().then((value) {
      int valuee = int.parse(value.snapshot.value.toString());
      int inc = valuee + 1;
      //
      ref.child('gender/student/$gender').set(inc);
    });

    ref.child('user_email_num/parent').once().then((value) {
      //
      int valuee = int.parse(value.snapshot.value.toString());
      int newuserAcc = valuee + 1;
      //
      ref.child('user_email_num').update({'parent': newuserAcc});
      //
      Auth().createUserWithEmailAndPassword(
          email: 'pt-$newuserAcc$i@school.com', password: nationalId);
      var newUserNode = {
        'name': name,
        'parent_name': parentName,
        'religion': religion,
        'national_id': nationalId,
        'phone_number': phone,
        'email(id)': 'pt-$newuserAcc$i@school.com',
        'birth_date': birthDate.toString(),
        'gender': gender,
      };
      // ref
      //     .child('parent_feed/pt-$newuserAcc$i/sessions')
      //     .set({'grade': grade, 'class': classs});
      // ref
      //     .child('parent_feed/pt-$newuserAcc$i/votes_messages')
      //     .set({'grade': grade, 'class': classs});
      ref
          .child('parent_acc')
          .child(grade)
          .child(classs)
          .child('users')
          .child('pt-$newuserAcc$i')
          .set(newUserNode);
    });
  }

  readGender(String ptOrTc, String genderType) {
    return ref.child('gender/students/{$genderType}').get();
  }

  getUsersOfClass(String grade, String classs) {
    return ref.child('parent_acc').child(grade).child(classs).child('users');
  }

  deleteParentUserById(
      String grade, String classs, String id, String gender, String emailId) {
    ref.child('/gender/student/$gender').once().then((value) {
      //
      int valuee = int.parse(value.snapshot.value.toString());
      int newuserAcc = valuee - 1;
      //
      ref.child('/gender/student').update({gender: newuserAcc});
      //
    });
    ref.child('parent_acc/$grade/$classs/users/$id').remove();
    ref.child('parent_feed/$emailId').remove();
  }

  updateUserById(String grade, String classs, String id, String keyOfUpdate,
      String valueOfUpdate) {
    print(valueOfUpdate);
    return ref
        .child('parent_acc')
        .child(grade)
        .child(classs)
        .child('users')
        .child(id)
        .update({keyOfUpdate: valueOfUpdate});
  }

  registeUserAccWithIcromentForTeacher(
    String name,
    String religion,
    String nationalId,
    String phone,
    DateTime birthDate,
    String gender,
    // List stages,
    String stage1,
    String stage2,
    String stage3,
    String subject,
    String i,
  ) {
    ref.child('gender/teacher/$gender').once().then((value) {
      int valuee = int.parse(value.snapshot.value.toString());
      int inc = valuee + 1;
      //
      ref.child('gender/teacher/$gender').set(inc);
    });
    ref.child('user_email_num/teacher').once().then((value) {
      //
      int valuee = int.parse(value.snapshot.value.toString());
      int newuserAcc = valuee + 1;
      //
      ref.child('user_email_num').update({'teacher': newuserAcc});
      //
      Auth().createUserWithEmailAndPassword(
          email: 'tc-$newuserAcc$i@school.com', password: nationalId);

      var newUserNode = {
        'name': name,
        'religion': religion,
        'national_id': nationalId,
        'phone_number': phone,
        'email(id)': 'tc-$newuserAcc$i@school.com',
        'birth_date': birthDate.toString(),
        'gender': gender,
        'stages': [stage1, stage2, stage3]
      };
      ref
          .child('teacher_feed/tc-$newuserAcc$i/')
          .set({'subject': subject.toLowerCase()});
      ref
          .child('teacher_acc')
          .child(subject.toLowerCase())
          .child('users')
          .child('tc-$newuserAcc$i')
          .set(newUserNode);
    });

    // print([stage1, stage2, stage3]);
  }

  getUsersTeacher() {
    return ref.child('teacher_acc');
  }

  getTeachersBySubject(String subject) {
    return ref.child('/teacher_acc/$subject/users');
  }

  deleteUserByIdTeacher(String subject, String id, String gender) {
    ref.child('gender/teacher/$gender').once().then((value) {
      int valuee = int.parse(value.snapshot.value.toString());
      int inc = valuee - 1;
      //
      ref.child('gender/teacher/$gender').set(inc);
    });
    ref.child('teacher_feed/$id').remove();
    ref.child('teacher_acc/$subject/users/$id').remove();
  }

  getSessions(
    String grade,
    String classs,
  ) {
    return ref.child('parent_acc').child(grade).child(classs).child('sessions');
  }

  intiateSessions(
    String grade,
    String classs,
  ) {
    Map intialData = {
      'day1': {
        'sessions': [
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
        ],
      },
      'day2': {
        'sessions': [
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
        ],
      },
      'day3': {
        'sessions': [
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
        ],
      },
      'day4': {
        'sessions': [
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
        ],
      },
      'day5': {
        'sessions': [
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
          '--_--',
        ],
      }
    };
    ref.child('parent_acc/$grade/$classs/users').once().then((value) {
      Map mappingValues = value.snapshot.value as Map;
      mappingValues.forEach((key, value) {
        ref.child('parent_feed/$key/sessions/day1').set(intialData['day1']);
        ref.child('parent_feed/$key/sessions/day2').set(intialData['day2']);
        ref.child('parent_feed/$key/sessions/day3').set(intialData['day3']);
        ref.child('parent_feed/$key/sessions/day4').set(intialData['day4']);
        ref.child('parent_feed/$key/sessions/day5').set(intialData['day5']);
      });
    });
    ref
        .child('parent_acc/$grade/$classs/sessions/day1')
        .set(intialData['day1']);
    ref
        .child('parent_acc/$grade/$classs/sessions/day2')
        .set(intialData['day2']);
    ref
        .child('parent_acc/$grade/$classs/sessions/day3')
        .set(intialData['day3']);
    ref
        .child('parent_acc/$grade/$classs/sessions/day4')
        .set(intialData['day4']);
    ref
        .child('parent_acc/$grade/$classs/sessions/day5')
        .set(intialData['day5']);
  }

  updateTableOfSessionsByDay(
      String grade, String classs, String day, List data) {
    var refactorData = {
      'sessions': [
        '${data[0]['sessions']}_${data[0]['teacher'].toString().split(': ').last.split('_').first}',
        '${data[1]['sessions']}_${data[1]['teacher'].toString().split(': ').last.split('_').first}',
        '${data[2]['sessions']}_${data[2]['teacher'].toString().split(': ').last.split('_').first}',
        '${data[3]['sessions']}_${data[3]['teacher'].toString().split(': ').last.split('_').first}',
        '${data[4]['sessions']}_${data[4]['teacher'].toString().split(': ').last.split('_').first}',
        '${data[5]['sessions']}_${data[5]['teacher'].toString().split(': ').last.split('_').first}',
        '${data[6]['sessions']}_${data[6]['teacher'].toString().split(': ').last.split('_').first}',
        '${data[7]['sessions']}_${data[7]['teacher'].toString().split(': ').last.split('_').first}',
      ],
    };
// EMAIL : data[0]['teacher'].toString().split('_').last
// CLASS : classs
// GRADE : grade
    for (var i = 0; i < 8; i++) {
      (data[i]['teacher'].toString().split('_').last == '--')
          ? ""
          : ref.child('sessions_teacher/').update({
              's${i + 1}_${grade}_${classs}_$day':
                  data[i]['teacher'].toString().split('_').last
            });
    }

    ///
    ///
    ///
    ///

    ref.child('parent_acc/$grade/$classs/users').once().then((value) {
      Map mappingValues = value.snapshot.value as Map;
      mappingValues.forEach((key, value) {
        ref.child('parent_feed/$key/sessions/$day').set(refactorData);
      });
    });
    ref.child('parent_acc/$grade/$classs/sessions/$day').update(refactorData);
  }

  getSessionsForTeacher() {
    return ref.child('sessions_teacher');
  }

  setVote(String grade, String classs, String voteTopic, String option1,
      String option2,
      [String? option3, String? option4]) {
    ref.child('parent_acc/$grade/$classs/users').once().then((value) {
      (value.snapshot.value as Map).forEach((key, value) {
        ref.child('parent_feed/$key/community/vote').push().set({
          'path': '$classs-$grade',
          'topic': voteTopic,
          'who_voted': [],
          'option1': {'option': option1, 'voters': [], 'num_of_voters': 0},
          'option2': {'option': option2, 'voters': [], 'num_of_voters': 0},
          'option3': {'option': option3, 'voters': [], 'num_of_voters': 0},
          'option4': {'option': option4, 'voters': [], 'num_of_voters': 0}
        });
      });
    });
    ref.child('parent_acc/$grade/$classs/vote').push().set({
      'topic': voteTopic,
      'who_voted': [],
      'option1': {'option': option1, 'voters': [], 'num_of_voters': 0},
      'option2': {'option': option2, 'voters': [], 'num_of_voters': 0},
      'option3': {'option': option3, 'voters': [], 'num_of_voters': 0},
      'option4': {'option': option4, 'voters': [], 'num_of_voters': 0}
    });
  }

  veiwVoteForAdmin(
    String grade,
    String classs,
  ) {
    return ref.child('parent_acc/$grade/$classs/vote');
  }

  voteOperation(String grade, String classs, String topicToVote, String email,
      String optionToVote) {
    // print('GRADE : ' + grade + '\n' + "CLASS : " + classs);
    ref.child('/parent_acc/$grade/$classs/vote/').once().then((value) {
      (value.snapshot.value as Map).forEach((key, value) {
        if (value['topic'] == topicToVote) {
          String id = key;
          ref.child('parent_acc/$grade/$classs/users').once().then((value) {
            (value.snapshot.value as Map).forEach((key, value) {
              String emailUser = key;
              ref
                  .child('parent_feed/$emailUser/community/vote')
                  .once()
                  .then((value) {
                (value.snapshot.value as Map).forEach((key, value) {
                  String idKey = key;
                  if (value['topic'] == topicToVote) {
                    if (value['who_voted'] == null) {
                      List list = [];
                      list.add(email);

                      ref
                          .child(
                              '/parent_feed/$emailUser/community/vote/$idKey/$optionToVote/num_of_voters')
                          .once()
                          .then((value) {
                        int valuee = int.parse(value.snapshot.value.toString());
                        int inc = valuee + 1;
                        //
                        ref
                            .child(
                                '/parent_feed/$emailUser/community/vote/$idKey/$optionToVote/num_of_voters')
                            .set(inc);
                      });
                      ref
                          .child(
                              '/parent_feed/$emailUser/community/vote/$idKey/')
                          .update({'who_voted': list});
                    } else {
                      if (value['who_voted'].contains(email)) {
                        // no code to excute
                      } else {
                        List list2 = value['who_voted'] as List;
                        List list3 = [];
                        for (var element in list2) {
                          list3.add(element);
                        }
                        list3.add(email);
                        ref
                            .child(
                                '/parent_feed/$emailUser/community/vote/$idKey/$optionToVote/num_of_voters')
                            .once()
                            .then((value) {
                          int valuee =
                              int.parse(value.snapshot.value.toString());
                          int inc = valuee + 1;
                          //
                          ref
                              .child(
                                  '/parent_feed/$emailUser/community/vote/$idKey/$optionToVote/num_of_voters')
                              .set(inc);
                        });
                        ref
                            .child(
                                '/parent_feed/$emailUser/community/vote/$idKey/')
                            .update({'who_voted': list3});
                      }
                    }
                  }
                });
              });
            });
          });
          ref
              .child('/parent_acc/$grade/$classs/vote/$id/who_voted')
              .once()
              .then((value) {
            if (value.snapshot.value == null) {
              List list = [];
              list.add(email);

              ref
                  .child(
                      '/parent_acc/$grade/$classs/vote/$id/$optionToVote/num_of_voters')
                  .once()
                  .then((value) {
                int valuee = int.parse(value.snapshot.value.toString());
                int inc = valuee + 1;
                //
                ref
                    .child(
                        '/parent_acc/$grade/$classs/vote/$id/$optionToVote/num_of_voters')
                    .set(inc);
              });
              ref
                  .child('/parent_acc/$grade/$classs/vote/$id/')
                  .update({'who_voted': list});
            } else {
              // print(list3);
              if ((value.snapshot.value as List).contains(email)) {
                // no code to excute
              } else {
                List list2 = value.snapshot.value as List;
                List list3 = [];
                for (var element in list2) {
                  list3.add(element);
                }
                list3.add(email);
                ref
                    .child(
                        '/parent_acc/$grade/$classs/vote/$id/$optionToVote/num_of_voters')
                    .once()
                    .then((value) {
                  int valuee = int.parse(value.snapshot.value.toString());
                  int inc = valuee + 1;
                  //
                  ref
                      .child(
                          '/parent_acc/$grade/$classs/vote/$id/$optionToVote/num_of_voters')
                      .set(inc);
                });
                ref
                    .child('/parent_acc/$grade/$classs/vote/$id/')
                    .update({'who_voted': list3});
              }
            }
          });
        }
      });
    });
  }

  delelteVote(String grade, String classs, String id, String topicToDelete) {
    ref.child('parent_acc/$grade/$classs/users').once().then((value) {
      (value.snapshot.value as Map).forEach((key, value) {
        String email = key;
        ref.child('parent_feed/$key/community/vote').once().then((value) {
          (value.snapshot.value as Map).forEach((key, value) {
            if (value['topic'] == topicToDelete) {
              ref.child('parent_feed/$email/community/vote/$key').remove();
            }
          });
        });
      });
    });
    ref.child('parent_acc/$grade/$classs/vote/$id').remove();
  }

  sendPrivateMessageToParent(String grade, String classs, String id,
      String from, String title, String body, String status) {
    if (from.toString().split('-').first == 'admin') {
      ref.child('parent_feed/$id/community/private_message').push().set({
        'from': 'ADMIN',
        'title': title,
        'body': body,
        'status': status,
        'date':
            '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}'
      });
    } else if (from.toString().split('-').first == 'tc') {
      ref.child('teacher_feed/$from').once().then((value) {
        Map map = value.snapshot.value as Map;
        ref
            .child('teacher_acc/${map['subject']}/users/$from')
            .once()
            .then((value) {
          Map map = value.snapshot.value as Map;
          return ref
              .child('parent_feed/$id/community/private_message')
              .push()
              .set({
            'from': map['name'],
            'title': title,
            'body': body,
            'status': status,
            'date':
                '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}'
          });
        });
      });
    }
  }

  sendPuplicMessageToParent(String grade, String classs, String id, String from,
      String title, String body, String status) {
    if (from.toString().split('-').first == 'admin') {
      ref.child('parent_feed/$id/community/public_message').push().set({
        'from': "ADMIN",
        'title': title,
        'body': body,
        'status': status,
        'date':
            '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}'
      });
    } else if (from.toString().split('-').first == 'tc') {
      ref.child('teacher_feed/$from').once().then((value) {
        Map map = value.snapshot.value as Map;
        ref
            .child('teacher_acc/${map['subject']}/users/$from')
            .once()
            .then((value) {
          Map map = value.snapshot.value as Map;
          return ref
              .child('parent_feed/$id/community/public_message')
              .push()
              .set({
            'from': map['name'],
            'title': title,
            'body': body,
            'status': status,
            'date':
                '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}'
          });
        });
      });
    }
  }

  sendTeacherMessage(String subject, String id, String from, String title,
      String body, String status) {
    return ref
        .child('teacher_acc')
        .child(subject)
        .child('users')
        .child(id)
        .child('messages')
        .push()
        .set({
      'from': "ADMIN",
      'title': title,
      'body': body,
      'status': status,
      'date':
          '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}'
    });
  }

  getTeachersNamesBySubject(String subject) {
    return ref.child('teacher_acc').child(subject).child('users');
  }

  reportError(String title, String body, String from) {
    return ref
        .child('error_reports')
        .child(from)
        .push()
        .set({'title': title, 'body': body});
  }

  getSessionsForParent(String email, int indexDay) {
    return ref.child('parent_feed/$email/sessions/day${indexDay + 1}/sessions');
  }

  getVotesForParent(String grade, String classs, String email) {
    return ref.child('/parent_feed/$email/community/vote');
  }

  getPrivateMessageForParent(String email) {
    return ref.child('parent_feed/$email/community/private_message');
  }

  getPublicMessageForParent(String email) {
    return ref.child('parent_feed/$email/community/public_message');
  }

  getTeacherMessages(String subject, String email) {
    return ref.child('/teacher_acc/$subject/users/$email/messages');
  }

  sendMarks(String grade, String classs, String parentEmail, String email,
      String mark, String comment, String testType, String examMark) {
    ref.child('teacher_feed/$email/subject').once().then((value) {
      String subject = value.snapshot.value as String;

      ref.child('parent_feed/$parentEmail/evaluation').update({
        subject: {
          'mark': mark,
          'exam_mark': examMark,
          'comment': comment,
          'test_type': testType
        }
      });
    });
  }

  getEvaluation(String email) {
    return ref.child('/parent_feed/$email/evaluation');
  }

  quitRequest(String email, String reason) {
    ref.child('/parent_feed/$email/sessions').update({
      'quit_request': {'reason': reason, 'accepted': false}
    });
  }

  getQuitRequest(String email) {
    return ref.child('/parent_feed/$email/sessions/quit_request').once();
  }

  presnces(String email, String today, int todayNum, bool check) {
    print(todayNum);
    ref.child('parent_feed/$email/presence/$today').once().then((value) {
      if (value.snapshot.value == null) {
        List list = [];
        list.add(check);
        ref.child('parent_feed/$email/presence/$today').set(list);
      } else {
        List list2 = value.snapshot.value as List;
        List list3 = [];
        for (var element in list2) {
          list3.add(element);
        }
        list3.add(check);
        ref.child('parent_feed/$email/presence/$today').set(list3);
      }
    });
  }
}
