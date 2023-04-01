import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/auth.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscuredata = true;
  final _passwordFocusNode = FocusNode();
  void _toggle() {
    setState(() {
      _obscuredata = !_obscuredata;
    });
  }

  var credentials = Auth(email: '', password: '');

  void _saveForm() {
    print(credentials);
    final validater = _formKey.currentState?.validate();
    print(validater);
    print('validater');
    if (!validater!) {
      return;
    }
    _formKey.currentState?.save();
    if (credentials.email == 'admin' && credentials.password == 'admin') {
      Navigator.pushNamed(context, HomePage.routeName);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Invaild Credentials")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red[700],
                          borderRadius: BorderRadius.circular(10)),
                      height: 100,
                      width: 100,
                    ),
                    _textWidget(
                        "WELCOME", Colors.red[700], 22.0, FontWeight.bold),
                    _textWidget("Log in to continue", Colors.black, 18.0,
                        FontWeight.normal),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      onSaved: (newValue) {
                        credentials = Auth(email: newValue, password: credentials.password);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email Address is Mandatory';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        label: Text("Email Address"),
                      ),
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is Mandatory';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        credentials = Auth(email: credentials.email, password: newValue);
                      },
                      obscureText: _obscuredata,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: IconButton(
                            onPressed: _toggle,
                            icon: (_obscuredata)
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility)),
                        label: const Text("Password"),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.red[700]!),
                        ),
                        onPressed: _saveForm,
                        child: _textWidget(
                            "Sign In", Colors.white, 18.0, FontWeight.normal),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _textWidget("Don't have an account?", Colors.black,
                            14.0, FontWeight.normal),
                        TextButton(
                          onPressed: () {},
                          child: _textWidget("Sign Up", Colors.red[700], 14.0,
                              FontWeight.normal),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _textWidget(
                            "Skip", Colors.black, 18.0, FontWeight.normal),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward_sharp))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _textWidget(title, color, size, weight) {
    return Text(
      title,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }
}
