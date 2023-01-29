import 'package:flutter/material.dart';
import 'package:school_manager/App/meta.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:school_manager/Presentation/Screens/admin_panal.dart';

class WelcomePageWindow extends StatefulWidget {
  const WelcomePageWindow({Key? key}) : super(key: key);

  @override
  State<WelcomePageWindow> createState() => _WelcomePageWindowState();
}

class _WelcomePageWindowState extends State<WelcomePageWindow> {
  TextEditingController schoolCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rewritepasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    schoolCodeController.text;
    passwordController.text;
    rewritepasswordController.text;
  }

  @override
  void initState() {
    super.initState();
    testWindowFunctions();
  }

  Future testWindowFunctions() async {
    Size size = await DesktopWindow.getWindowSize();
    // await DesktopWindow.setWindowSize(Size(500, 500));
    await DesktopWindow.setMinWindowSize(const Size(900, 500));
    // await DesktopWindow.setMaxWindowSize(Size(800, 800));
    // await DesktopWindow.resetMaxWindowSize();
    // await DesktopWindow.toggleFullScreen();
    // bool isFullScreen = await DesktopWindow.getFullScreen();
    await DesktopWindow.setFullScreen(true);
    // await DesktopWindow.setFullScreen(false);
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
          padding: currentWidth < 800
              ? const EdgeInsets.all(40)
              : const EdgeInsets.only(
                  left: 250, right: 250, top: 100, bottom: 100),
          child: ListView(
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
                  child: const Text(
                    'LogIn',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: schoolCodeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'School Code',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  // obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  // obscureText: true,
                  controller: rewritepasswordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Re-Write Password',
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
                    child: const Text('Login'),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminPanal()),
                      );
                      print(schoolCodeController.text);
                      print(passwordController.text);
                    },
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('For any bugs contact us'),
                  TextButton(
                    child: const Text(
                      'Contact',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(child: Text('V ${AppMeta.version}'))
            ],
          )),
    );
  }
}
