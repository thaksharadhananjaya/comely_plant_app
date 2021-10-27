import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plant_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'image_and_icons.dart';
import 'title_and_price.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    this.image1,
    this.image2,
    this.title,
    this.city,
    this.price,
    this.discription,
    this.category,
    this.date,
    this.email,
    this.wapp,
    this.phone,
  }) : super(key: key);

  final String image1,
      image2,
      title,
      city,
      price,
      discription,
      category,
      date,
      email;
  final int wapp, phone;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ImageAndICons(
                size: size,
                image1: image1,
                image2: image2,
                discription: discription,
                category: category,
                phone: phone,
                wapp: wapp,
                email: email,
              ),
              TitleAndPrice(title: title, city: city, price: price),
              SizedBox(height: kDefaultPadding + 80),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: size.width / 2,
                height: 84,
                // ignore: deprecated_member_use
                child: FlatButton.icon(
                  color: kPrimaryColor,
                  onPressed: () async{await launch('tel: $phone',
                          forceSafariVC: false, forceWebView: false);},
                  label: Text(
                    "Call Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  icon: Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: size.width / 2,
                height: 84,
                // ignore: deprecated_member_use
                child: FlatButton.icon(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  color: kPrimaryColor.withOpacity(0.2),
                  onPressed: () async {
                    if (wapp != 0) {
                      await launch('whatsapp://send?phone=+94$wapp&text= ${Uri.encodeFull('I see *$title plant* ad on comely')}',
                          forceSafariVC: false, forceWebView: false);
                    } else {
                      Flushbar(
                        message: 'This publisher not provide whatshapp',
                      ).show(context);
                    }
                  },
                  label: Text("Whatsapp",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 16,
                      )),
                  icon: FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: kPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
