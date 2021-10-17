import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_gay_agenda/widgets/profile_picture_picker.dart';

class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class User {
  String firstName = '';
  String lastName = '';
  String email = '';
  String photoPath = '';

  save() {}
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const ProfilePicturePicker(),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'First name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your first name';
                              }
                            },
                            onSaved: (value) =>
                                setState(() => _user.firstName = value!),
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Last name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your last name';
                              }
                            },
                            onSaved: (value) =>
                                setState(() => _user.lastName = value!),
                          ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Email'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your email';
                              }
                            },
                            onSaved: (value) =>
                                setState(() => _user.email = value!),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    final form = _formKey.currentState;
                                    if (form!.validate()) {
                                      form.save();
                                      _user.save();
                                      _showDialog(context);
                                    }
                                  },
                                  child: const Text('Save'))),
                        ])))));
  }

  _showDialog(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Submitting form')));
  }
}
