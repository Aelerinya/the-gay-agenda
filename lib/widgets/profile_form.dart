import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_gay_agenda/services/user.dart';
import 'package:the_gay_agenda/widgets/profile_picture_picker.dart';

class ProfileForm extends StatefulWidget {
  final User user;
  const ProfileForm({required this.user, Key? key}) : super(key: key);

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Builder(
            builder: (context) => Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ProfilePicturePicker(
                        user: widget.user,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'First name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your first name';
                          }
                        },
                        onSaved: (value) =>
                            setState(() => widget.user.firstName = value!),
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
                            setState(() => widget.user.lastName = value!),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                        },
                        onSaved: (value) =>
                            setState(() => widget.user.email = value!),
                      ),
                      Container(
                          padding: const EdgeInsets.all(16),
                          child: ElevatedButton(
                              onPressed: () {
                                final form = _formKey.currentState;
                                if (form!.validate()) {
                                  form.save();
                                  widget.user.save();
                                  _showDialog(context);
                                }
                              },
                              child: const Text('Save'))),
                    ]))));
  }

  _showDialog(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Submitting form')));
  }
}
