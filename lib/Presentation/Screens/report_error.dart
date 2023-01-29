import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Firebase/real_time_db.dart';
import 'package:easy_localization/easy_localization.dart';

class ReportError extends StatefulWidget {
  const ReportError({super.key});

  @override
  State<ReportError> createState() => _ReportErrorState();
}

class _ReportErrorState extends State<ReportError> {
  final TextEditingController _controllerForErrorBody = TextEditingController();
  final TextEditingController _controllerForErrorTitle =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report error'.tr()),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text(
                  AppMeta.appName,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text(
                  'Fill the fields down'.tr(),
                  style: const TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _controllerForErrorTitle,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Error Title'.tr(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                controller: _controllerForErrorBody,
                maxLines: 8,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Describe the problem...'.tr(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: Text('Send !'.tr()),
                  onPressed: () {
                    Navigator.pop(context);
                    String emailId = (Auth().currentUser != null)
                        ? Auth().currentUser!.email!.split('@').first
                        : 'anonymous';
                    // print(emailId);
                    Database().reportError(_controllerForErrorTitle.text,
                        _controllerForErrorBody.text, emailId);
                    final snackBar = SnackBar(
                      content: Text('Thanks for your feedback !'.tr()),
                      action: SnackBarAction(
                        textColor: Colors.blue,
                        label: '',
                        onPressed: () {},
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        '   All reports are going to be \nconsidered in the next version'
                            .tr()),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(child: Text('V ${AppMeta.version}'))
          ],
        ),
      ),
    );
  }
}
