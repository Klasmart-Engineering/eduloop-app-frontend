import 'package:edu_app/components/user/cloud.dart';
import 'package:edu_app/components/user/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const routeName = 'sign-up';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Container(
            child: Column(
          children: [
            const Flexible(flex: 1, child: const HeroImage()),
            const FormContainer()
          ],
        )));
  }
}

class HeroImage extends StatelessWidget {
  const HeroImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.width * 0.1,
          child: const Cloud(
              delay: .05, scale: .8, duration: Duration(seconds: 5)),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          left: -40,
          child: const Cloud(
            delay: .1,
            scale: .7,
            duration: Duration(seconds: 5),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.25,
          right: -20,
          child: const Cloud(duration: Duration(seconds: 4)),
        ),
        Align(
          heightFactor: 1,
          widthFactor: 1,
          alignment: Alignment.center,
          child: Image.asset('assets/images/dog.png'),
        )
      ],
    );
  }
}

class FormContainer extends StatelessWidget {
  const FormContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  )),
              SignUpForm()
            ]));
  }
}
