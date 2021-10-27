import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/constants.dart';

import 'plants.dart';
import 'featured_plants.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController textSearchController = new TextEditingController();
  String search = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSearch(context),
          textSearchController.text.isEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TitleWithMoreBtn(title: "Featured Plants", press: () {}),
                    Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: FeaturedPlants(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: kDefaultPadding),
                      child: TitleWithCustomUnderline(
                        text: "For You",
                      ),
                    ),
                    Plants(),
                    SizedBox(height: kDefaultPadding),
                  ],
                )
              : Plants(
                  search: textSearchController.text,
                ),
        ],
      ),
    );
  }

  Widget buildSearch(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2.5),
      // It will cover 20% of our total height
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              bottom: 36 + kDefaultPadding,
            ),
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'Hi Uishopy!',
                  style: Theme.of(context).textTheme.headline5.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Image.asset(
                  "assets/images/comelyLogo.png",
                  width: 180,
                  height: 120,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              height: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                        controller: textSearchController,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          // surffix isn't working properly  with SVG
                          // thats why we use row
                          // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                        ),
                        onSubmitted: (text) => setState(() {})),
                  ),
                  search == ''
                      ? GestureDetector(
                          onTap: () {
                            if (textSearchController.text.isNotEmpty)
                              setState(() {});
                          },
                          child: SvgPicture.asset("assets/icons/search.svg"))
                      : IconButton(
                          icon: Icon(
                            Icons.close,
                            color: kPrimaryColor,
                          ),
                          onPressed: () => setState(() {
                                textSearchController.clear();
                              })),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
