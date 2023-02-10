import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:local_auth/local_auth.dart';
import 'package:school_manager/App/meta.dart';
import 'package:school_manager/Data/Firebase/authentication.dart';
import 'package:school_manager/Data/Firebase/messaging.dart';
import 'package:school_manager/Data/Local_providers/options_operations.dart';
import 'package:school_manager/Presentation/Screens/admin_panal.dart';
import 'package:school_manager/Presentation/Screens/home_panal.dart';
import 'package:school_manager/Presentation/Screens/report_error.dart';
import 'package:school_manager/Presentation/Screens/teacher_panel.dart';
import 'package:school_manager/main.dart';

class WelcomeSingInMobile extends StatefulWidget {
  const WelcomeSingInMobile({Key? key}) : super(key: key);

  @override
  State<WelcomeSingInMobile> createState() => _WelcomeSingInMobileState();
}

class _WelcomeSingInMobileState extends State<WelcomeSingInMobile> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) =>
          LiquidSwipe(enableLoop: false, pages: [const Welcome(), SignIn()]),
    );
  }
}

/// Welcome & SignIn Widgets

/// Welcome Page

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Container(
                decoration: const BoxDecoration(),
                child: Image.asset(
                    'assets/welcome/undraw_education_f8ru-removebg-preview.png')),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome...\n'.tr(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25)),
                    Text(
                        '${AppMeta.appName} ${'is a simple and easy application designed to track your children\'s progress at school. \n\n\nWe use simple nice smooth colors to illustrate student\'s status Just by signing in \n\n\nAll interactions are presence too such as: messaging, voting and evaluation in the application '.tr()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios),
                      Text(
                        'Swipe to continue!'.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}

///
///
///
/////////////////////////   ||||||||||||||||||
////////////////////////    ||||||||||||||||||
///
///
///
///
///
/// SIGNIN & AUTH. PAGE   ||||||||||||||||||
/// SIGNIN & AUTH. PAGE   ||||||||||||||||||
/// SIGNIN & AUTH. PAGE   ||||||||||||||||||
///
///
///
///
///
/// SIGNIN & AUTH. PAGE   ||||||||||||||||||
/// SIGNIN & AUTH. PAGE   ||||||||||||||||||
/// SIGNIN & AUTH. PAGE   ||||||||||||||||||
///
///
///
///
///
/// SIGNIN & AUTH. PAGE   ||||||||||||||||||
/// SIGNIN & AUTH. PAGE   ||||||||||||||||||
/// SIGNIN & AUTH. PAGE   ||||||||||||||||||
///
///
///
///
///
/// SIGNIN & AUTH. PAGE   ||||||||||||||||||
/// SIGNIN & AUTH. PAGE   ||||||||||||||||||
/// SIGNIN & AUTH. PAGE   ||||||||||||||||||
///
///
///
///
///////////////////////   ||||||||||||||||||
///////////////////////   ||||||||||||||||||
///
///
///
///

class SignIn extends StatefulWidget {
  SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate(String navigatePath) async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }

    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');

    ///
    ///
    ///
    ///
    ///
    ///
    ///
    ///
    ///
    ///
    ///
    /// NAVIGATION
    /// NAVIGATION
    /// NAVIGATION
    ///
    ///
    ///
    ///
    ///
    ///
    ///
    ///
    if (authenticated) {
      switch (navigatePath) {
        case 'pt':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ParentPanel()),
          );
          break;
        case 'tc':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TeacherPanal()),
          );
          break;
        case 'admin':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const AdminPanal()),
          );
          break;
        default:
      }
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  final myControllerForEmail = TextEditingController();
  final myControllerForStudentId = TextEditingController();
  final myControllerForStudentPassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    myControllerForEmail.dispose();
    myControllerForStudentId.dispose();
    myControllerForStudentPassword.dispose();
  }

  bool _showPassword = false;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // SizedBox(height: 200),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: SizedBox(
                  height: 300,
                  child: Image.asset(
                    'assets/welcome/undraw_Login_re_4vu2-removebg-preview.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Text(
                AppMeta.appName,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 130,
                height: 10,
                decoration: BoxDecoration(
                    color: AppMeta.color,
                    borderRadius: BorderRadius.circular(20)),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextField(
                  // onChanged: (value) {
                  // },
                  controller: myControllerForEmail,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Enter School Code'.tr(),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextField(
                  controller: myControllerForStudentId,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Student/Teacher ID'.tr(),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                child: TextField(
                  obscureText: !_showPassword,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: myControllerForStudentPassword,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: 'Student/Teacher Password'.tr(),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _togglevisibility();
                      },
                      child: Icon(
                        _showPassword ? Icons.visibility : Icons.visibility_off,
                        color: AppMeta.color,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              Text(
                errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'For any bugs contact us'.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    child: Text(
                      'Contact'.tr(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      NavigateTo(context, const ReportError());
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () {
                        // sendNotification();
                        // Auth().signInWithCustomToken(token)
                        // print(getToken());
                        String emailId = [
                          myControllerForStudentId.text,
                          '@',
                          myControllerForEmail.text
                        ].join();
                        Auth()
                            .signInWithEmailAndPassword(
                                email: emailId,
                                password: myControllerForStudentPassword.text)
                            .then((value) {
                          switch (
                              myControllerForStudentId.text.split('-').first) {
                            case 'pt':
                              if (_supportState == _SupportState.unsupported) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ParentPanel()),
                                );
                              } else {
                                _authenticate('pt');
                              }
                              break;
                            case 'tc':
                              if (_supportState == _SupportState.unsupported) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const TeacherPanal()),
                                );
                              } else {
                                _authenticate('tc');
                              }
                              break;
                            case 'admin':
                              if (_supportState == _SupportState.unsupported) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AdminPanal()),
                                );
                              } else {
                                _authenticate('admin');
                              }
                              break;
                            default:
                          }
                        }).onError((error, stackTrace) {
                          setState(() {
                            errorMessage = error.toString().split(']').last;
                          });
                        });
                      },
                      child: Text('Sign in'.tr())),
                ),
              ),
              Text('V ${AppMeta.version}'),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
