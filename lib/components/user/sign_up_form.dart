import 'package:edu_app/providers/session_provider.dart';
import 'package:edu_app/screens/introduction.dart';
import 'package:edu_app/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/services/user_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/user.dart';

// Define a custom Form widget.
class SignUpForm extends StatefulHookConsumerWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class SignUpFormState extends ConsumerState<SignUpForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<SignUpFormState>.
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nicknameController;

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nickname", textAlign: TextAlign.start),
          TextFormField(
            decoration: InputDecoration(isDense: true),
            controller: _nicknameController,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 25))),
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   const SnackBar(content: Text('Processing Data:')),
                      // );

                      User newUser = await UserService.addNewUser(
                          _nicknameController.text);

                      ref
                          .watch(quizSessionProvider.notifier)
                          .startSession(newUser.id)
                          .then((value) {
                        Navigator.pushNamed(
                            context, '/' + IntroductionScreen.routeName);
                      });
                    }
                  },
                  child: const Text('Submit', style: TextStyle(fontSize: 20)),
                )),
          ),
        ],
      ),
    );
  }
}
