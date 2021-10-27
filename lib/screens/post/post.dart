import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class Post extends StatefulWidget {
  Post({Key key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController textPhoneController = new TextEditingController();
  TextEditingController textTitleController = new TextEditingController();
  TextEditingController textWappController = new TextEditingController();
  TextEditingController textEmailController = new TextEditingController();
  TextEditingController textPriceController = new TextEditingController();
  TextEditingController textDisController = new TextEditingController();
  String errorPrice = '',
      errorTitle = '',
      errorPhone = '',
      errorWhatsapp = '',
      errorEmail = '',
      errorDiscription = '';
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
      padding: EdgeInsets.only(left: kDefaultPadding, right: kDefaultPadding, top: kDefaultPadding),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Post your plant ad',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 40,
              ),
              buildTextFieldTitle(),
              buildTextFieldPrice(),
              buildTextFieldDis(),
              buildTextFieldPhone(),
              buildTextFieldWhatsApp(),
              buildTextFieldEmail(),

              buildButton(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Container buildButton() {
    return Container(
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
                      if (errorTitle == '' &&
                          errorWhatsapp == '' &&
                          errorPhone == '' &&
                          errorDiscription == '' &&
                          errorEmail == '') {
                        print('pass');
                      } else {}
                    },
                    child: Text("Post",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )),
                  ),
                );
  }

  Widget buildTextFieldTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 8),
          child: Text(
            'Title',
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
              controller: textTitleController,
              validator: (text) {
                if (text.isEmpty) {
                  setState(() {
                    errorTitle = 'Enter title';
                  });
                  return null;
                }

                setState(() {
                  errorTitle = "";
                });
                return null;
              },
              maxLength: 10,
              cursorColor: Colors.green,
              inputFormatters: [
                // ignore: deprecated_member_use
                new WhitelistingTextInputFormatter(RegExp("[a-zA-Z- ]")),
              ],
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
                icon: Icon(
                  Icons.title,
                  color: kPrimaryColor,
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 40, top: 3),
          child: Text(
            errorTitle,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextFieldPrice() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 8),
          child: Text(
            'Price (LKR)',
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
              controller: textPriceController,
              validator: (text) {
                if (text.isEmpty) {
                  setState(() {
                    errorPrice = 'Enter Price';
                  });
                  return null;
                }

                setState(() {
                  errorPrice = "";
                });
                return null;
              },
              maxLength: 12,
              cursorColor: Colors.green,
              inputFormatters: [
                // ignore: deprecated_member_use
                new WhitelistingTextInputFormatter(RegExp("[0-9.]")),
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
                icon: Icon(
                  Icons.money,
                  color: kPrimaryColor,
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 40, top: 3),
          child: Text(
            errorPrice,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextFieldPhone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 8),
          child: Text(
            'Mobile number',
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
              validator: (text) {
                if (text.isEmpty) {
                  setState(() {
                    errorPhone = 'Enter mobile number';
                  });
                  return null;
                } else if (text.length < 10) {
                  setState(() {
                    errorPhone = 'Invalid mobile number';
                  });
                  return null;
                }

                setState(() {
                  errorPhone = "";
                });
                return null;
              },
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
                icon: Icon(
                  Icons.smartphone,
                  color: kPrimaryColor,
                ),
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

  Widget buildTextFieldWhatsApp() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 8),
          child: Text(
            'Whatsapp number (Optional)',
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
              controller: textWappController,
              validator: (text) {
                if (text.length > 0 && text.length < 10) {
                  setState(() {
                    errorWhatsapp = 'Invalid whatsapp number';
                  });
                  return null;
                }

                setState(() {
                  errorWhatsapp = "";
                });
                return null;
              },
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
                icon: FaIcon(
                  FontAwesomeIcons.whatsapp,
                  color: kPrimaryColor,
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 40, top: 3),
          child: Text(
            errorWhatsapp,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextFieldEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 8),
          child: Text(
            'Email (Optional)',
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
              controller: textEmailController,
              validator: (text) {
                setState(() {
                  errorEmail = "";
                });
                return null;
              },
              maxLength: 120,
              cursorColor: Colors.green,
              inputFormatters: [
                // ignore: deprecated_member_use
                new WhitelistingTextInputFormatter(RegExp("[a-zA-Z-0-9-.@_]")),
              ],
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
                icon: Icon(
                  Icons.email,
                  color: kPrimaryColor,
                ),
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 40, top: 3),
          child: Text(
            errorEmail,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextFieldDis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6, left: 8),
          child: Text(
            'Discription',
            style: TextStyle(
              color: kPrimaryColor,
            ),
          ),
        ),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            height: 120,
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
              controller: textDisController,
              validator: (text) {
                if (text.isEmpty) {
                  setState(() {
                    errorDiscription = 'Enter discription';
                  });
                  return null;
                }

                setState(() {
                  errorDiscription = "";
                });
                return null;
              },
              maxLength: 150,
              maxLines: 5,
              cursorColor: Colors.green,
              inputFormatters: [
                // ignore: deprecated_member_use
                new WhitelistingTextInputFormatter(
                    RegExp("[a-zA-Z- ,.!'*/-{}%\$#&^=~]")),
              ],
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
              ),
            )),
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 40, top: 3),
          child: Text(
            errorDiscription,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
