import 'package:edu_app/screens/introduction.dart';
import 'package:edu_app/utils/session_helper.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/utils/user_helper.dart';

import '../../models/user.dart';

// Define a custom Form widget.
class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  SignUpFormState createState() {
    return SignUpFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class SignUpFormState extends State<SignUpForm> {
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
          TextFormField(
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
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Processing Data:')),
                  // );

                  User newUser =
                      await UserHelper.addNewUser(_nicknameController.text);

                  SessionHelper.startSession(newUser.id).then((value) {
                    // ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //       backgroundColor: Colors.green,
                    //       content: Text('Success' + newUser.id)),
                    // );

                    Navigator.pushNamed(
                        context, '/' + IntroductionScreen.routeName);
                  });
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
