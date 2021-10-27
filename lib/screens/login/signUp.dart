import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:plant_app/screens/post/dashboad.dart';
import '../../constants.dart';
import 'signIn.dart';

class SignUP extends StatefulWidget {
  SignUP({Key key}) : super(key: key);

  @override
  _SignUPState createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textPhoneController = new TextEditingController();
  TextEditingController textPassController = new TextEditingController();
  TextEditingController textComPassController = new TextEditingController();
  String errorPhone = '', errorPass = '', errorCPass = '';
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
            Text('Create an account',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 40,
            ),
            buildTextField(
                context,
                "Mobile number",
                Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ), (text) {
              if (text.isEmpty) {
                setState(() {
                  errorPhone = 'Enter mobile number';
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
                "Password",
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
              } else if (text.length < 6) {
                setState(() {
                  errorPass = "Password must have at least 6 characters";
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
            buildTextFieldPass(
                context,
                "Comfirm Password",
                Icon(
                  Icons.lock,
                  color: kPrimaryColor,
                ), (text) {
              if (text.isEmpty) {
                setState(() {
                  errorCPass = "Retype your password";
                });
                return null;
              } else if (text != textPassController.text) {
                setState(() {
                  errorCPass = "Passowrd doesn't match";
                });
                return null;
              }
              setState(() {
                errorCPass = "";
              });
              return null;
            }, textComPassController),
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
                  if (errorCPass == '' && errorPass == '' && errorPhone == '') {
                    createUser(
                        textPhoneController.text, textPassController.text);
                    print('pass');
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
                Text('  Already member? ',
                    style: TextStyle(
                      fontSize: 16,
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                    );
                  },
                  child: Text('  Sign In    ',
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

  Widget buildTextField(
      BuildContext context, String text, Icon icon, Function validator) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 8),
          child: Text(
            text,
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

  Widget buildTextFieldPass(BuildContext context, String text, Icon icon,
      Function validator, TextEditingController textEditingController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 8),
          child: Text(
            text,
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
            text == "Password" ? errorPass : errorCPass,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> createUser(String mobile, String password) async {
    try {
      String path = "$url/createUser.php";

      final response = await http.post(Uri.parse(path),
          body: {"key": accessKey, "phone": "$mobile", "pass": "$password"});

      String data = jsonDecode(response.body).toString();
      if (data == '1062') {
        Flushbar(
          message: 'Mobile number already use !',
          messageColor: Colors.red,
          backgroundColor: kPrimaryColor,
          duration: Duration(seconds: 3),
          icon: Icon(
            Icons.warning_rounded,
            color: Colors.red,
          ),
        ).show(context);
      } else {
        //await storage.write(key: 'mobile', value: mobile);
        //await storage.write(key: 'pass', value: password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboad()));
      }
    } catch (e) {
      print(e);
    }
  }
}
