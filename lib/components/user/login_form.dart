import 'package:edu_app/models/user.dart';
import 'package:edu_app/providers/session_provider.dart';
import 'package:edu_app/screens/introduction.dart';
import 'package:edu_app/screens/user/sign_up.dart';
import 'package:edu_app/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:edu_app/services/user_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Define a custom Form widget.
class LoginForm extends StatefulHookConsumerWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class LoginFormState extends ConsumerState<LoginForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<LoginFormState>.
  final _formKey = GlobalKey<FormState>();

  late final Future<List<DropdownMenuItem<String>>> _userDropdownOptions;
  String selectedUserId = "";

  @override
  void initState() {
    super.initState();
    _userDropdownOptions = initiateDropdownValues();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<DropdownMenuItem<String>>> initiateDropdownValues() async {
    List<User> users = await UserService.getUsers();
    List<DropdownMenuItem<String>> options = users
        .map((user) => DropdownMenuItem(child: Text(user.name), value: user.id))
        .toList();

    options.add(const DropdownMenuItem(child: Text('Select value'), value: ''));

    return options;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _userDropdownOptions,
        builder:
            (context, AsyncSnapshot<List<DropdownMenuItem<String>>> snapshot) {
          if (snapshot.hasData) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    items: snapshot.data,
                    value: selectedUserId,
                    onChanged: (newValue) {
                      setState(() {
                        selectedUserId = newValue ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a user or create one';
                      }

                      return null;
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextButton(
                        child: const Text('Add a new user',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            )),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/' + SignUpScreen.routeName);
                        },
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 25))),
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              ref
                                  .watch(quizSessionProvider.notifier)
                                  .startSession(selectedUserId)
                                  .then((value) {
                                Navigator.pushNamed(context,
                                    '/' + IntroductionScreen.routeName);
                              });
                            }
                          },
                          child: const Text('Submit',
                              style: TextStyle(fontSize: 20)),
                        )),
                  ),
                ],
              ),
            );
          }

          return const CircularProgressIndicator();
        });
  }
}
