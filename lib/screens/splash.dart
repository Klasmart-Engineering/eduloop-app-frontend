import 'package:edu_app/models/user.dart';
import 'package:edu_app/utils/user_helper.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/screens/user/login.dart';
import 'package:edu_app/screens/user/sign_up.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const routeName = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), () {
      determineLoginPath(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/kidsloop_splash.png',
          width: 250,
        ),
      ),
    );
  }

  void determineLoginPath(BuildContext context) async {
    List<User> users = await UserHelper.getUsers();
    if (users.isEmpty) {
      Navigator.pushNamed(context, '/' + SignUpScreen.routeName);
      return;
    }

    Navigator.pushNamed(context, '/' + LoginScreen.routeName);
  }
}
