import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/screens/post/dashboad.dart';

import '../../constants.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textPhoneController = new TextEditingController();
  TextEditingController textPassController = new TextEditingController();
  String errorPhone = '', errorPass = '';
  bool passVisibility = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: buildBody()),
    );
  }

  Container buildBody() {
    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding, vertical: kDefaultPadding),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text('Sign in to your account',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 40,
            ),
            buildTextField(
                context,
                Icon(
                  Icons.smartphone,
                  color: kPrimaryColor,
                ), (text) {
              if (text.isEmpty) {
                setState(() {
                  errorPhone = 'Enter phone number';
                });
                return null;
              } else if (text.length < 10 ||
                  text.toString().substring(0, 2) != '07') {
                setState(() {
                  errorPhone = 'Invalid phone number';
                });
                return null;
              }
              setState(() {
                errorPhone = "";
              });
              return null;
            }),
            buildTextFieldPass(
                context,
                Icon(
                  Icons.lock,
                  color: kPrimaryColor,
                ), (text) {
              RegExp regex = new RegExp("[']");
              if (text.isEmpty) {
                setState(() {
                  errorPass = "Enter password";
                });
                return null;
              } else if (regex.hasMatch(text)) {
                setState(() {
                  errorPass = "Invalid Password !";
                });
                return null;
              }
              setState(() {
                errorPass = "";
              });
              return null;
            }, textPassController),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: kPrimaryColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.5),
                  ),
                ],
              ),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  formKey.currentState.validate();
                  if (errorPass == '' && errorPhone == '') {
                    print('pass');
                    login(textPhoneController.text, textPassController.text);
                  } else {}
                },
                child: Text("Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    )),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('  Create an account ',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('  Sign Up    ',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget buildTextField(BuildContext context, Icon icon, Function validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 8),
          child: Text(
            "Mobile number or e-mail",
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
        ),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 25,
                  color: kPrimaryColor.withOpacity(0.20),
                ),
              ],
            ),
            child: TextFormField(
              controller: textPhoneController,
              validator: validator,
              maxLength: 10,
              cursorColor: Colors.green,
              inputFormatters: [
                // ignore: deprecated_member_use
                new WhitelistingTextInputFormatter(RegExp("[0-9]")),
              ],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counterText: '',
                hintStyle: TextStyle(
                  color: kPrimaryColor.withOpacity(0.5),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                icon: icon,
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 40, top: 3),
          child: Text(
            errorPhone,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextFieldPass(BuildContext context, Icon icon, Function validator,
      TextEditingController textEditingController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 8),
          child: Text(
            "Password",
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
        ),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 25,
                  color: kPrimaryColor.withOpacity(0.20),
                ),
              ],
            ),
            child: TextFormField(
              controller: textEditingController,
              cursorColor: Colors.green,
              obscureText: passVisibility ? true : false,
              validator: validator,
              maxLength: 8,
              decoration: InputDecoration(
                counterText: '',
                hintStyle: TextStyle(
                  color: kPrimaryColor.withOpacity(0.5),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                border: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                suffixIcon: IconButton(
                    icon: Icon(
                      passVisibility ? Icons.visibility_off : Icons.visibility,
                      color: kPrimaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        if (passVisibility)
                          passVisibility = false;
                        else
                          passVisibility = true;
                      });
                    }),
                icon: icon,
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 40, top: 3),
          child: Text(
            errorPass,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> login(String user, String password) async {
    try {
      String path = "$url/login.php";

      final response = await http.post(Uri.parse(path),
          body: {"key": accessKey, "user": "$user", "pass": "$password"});

      String data = jsonDecode(response.body).toString();print(data);
      if (data != 'null') {
        
        //await storage.write(key: 'uID', value: data);
        //await storage.write(key: 'mobile', value: user);
        // await storage.write(key: 'pass', value: password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboad()));
      } else {
        Flushbar(
          message: 'Wrong username or password !',
          messageColor: Colors.red,
          backgroundColor: kPrimaryColor,
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.warning_rounded,
            color: Colors.red,
          ),
        ).show(context);
      }
    } catch (e) {
      print(e);
    }
  }
}
