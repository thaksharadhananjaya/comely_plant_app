import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/home/components/body.dart';

class HomeScreen extends StatelessWidget {
   final globalKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: buildAppBar(),
      drawer: buildDrawer(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () => globalKey.currentState.openDrawer(),
      ),
    );
  }

   Drawer buildDrawer() {
    return Drawer(
        child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  CircleAvatar(
                    radius: 73,
                    backgroundColor:kPrimaryColor,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/comelyLogo.png',),
                      
                    ),
                  ),

                  SizedBox(
                    height: 48,
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.security, color: kPrimaryColor,),
                            SizedBox(
                              width: 4,
                            ),
                            Text('Terms & Condision',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_forward_ios)),
                      ],
                    ),
                    onPressed: () => null),
                  

                  // ignore: deprecated_member_use
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.info, color: kPrimaryColor,),
                            SizedBox(
                              width: 4,
                            ),
                            Text('About',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_forward_ios)),
                      ],
                    ),
                    onPressed: () => null),
                  

                  // ignore: deprecated_member_use
                  FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.mail, color: kPrimaryColor,),
                            SizedBox(
                              width: 4,
                            ),
                            Text('Contact Us',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_forward_ios)),
                      ],
                    ),
                    onPressed: () => null),
                  
                ],
              ),
              /*GestureDetector(
                onTap: () async {
                  await launch('https://www.widdev.com',
                      forceSafariVC: false, forceWebView: false);
                },
                child: Text(
                  'Powered By Widdev',
                  style: TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w700),
                ),
              )*/
            ]),
      ),
    ));
  }
}
