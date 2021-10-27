import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/screens/details/components/imageViewer.dart';

import '../../../constants.dart';
import 'icon_card.dart';

class ImageAndICons extends StatefulWidget {
  final String image1, image2, discription, category, date, email;
  final int wapp, phone;
  final Size size;
  ImageAndICons(
      {Key key,
      this.image1,
      this.image2,
      this.size,
      this.discription,
      this.email,
      this.wapp,
      this.phone,
      this.category,
      this.date})
      : super(key: key);

  @override
  _ImageAndIConsState createState() => _ImageAndIConsState();
}

class _ImageAndIConsState extends State<ImageAndICons> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
      child: SizedBox(
        height: widget.size.height * 0.7,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 0;
                          });
                        },
                        child: IconCard(icon: "assets/icons/sun.svg")),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 1;
                          });
                        },
                        child: IconCard(icon: "assets/icons/icon_2.svg")),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            index = 2;
                          });
                        },
                        child: IconCard(icon: "assets/icons/icon_3.svg")),
                    SizedBox(height: 50,)
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ImageView(image: [widget.image1, widget.image2]),
                ),
              ),
              child: index == 0 ? buildImage() : (index == 1 ? buildDetails(): buildContact()),
            ),
          ],
        ),
      ),
    );
  }

  Container buildImage() {
    return Container(
      height: widget.size.height * 0.7,
      width: widget.size.width * 0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(63),
          bottomLeft: Radius.circular(63),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 60,
            color: kPrimaryColor.withOpacity(0.29),
          ),
        ],
        image: DecorationImage(
          alignment: Alignment.centerLeft,
          fit: BoxFit.cover,
          image: NetworkImage(widget.image1),
        ),
      ),
    );
  }

  Container buildDetails() {
    return Container(
        height: widget.size.height * 0.7,
        width: widget.size.width * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(63),
            bottomLeft: Radius.circular(63),
          ),
        ),
        child: SafeArea(
            child: Column(
          children: [
            widget.discription != 'Other'
                ? Text(widget.category)
                : Text('Plant'),
            Text(widget.discription),
          ],
        )));
  }

  Container buildContact() {
    return Container(
        height: widget.size.height * 0.7,
        width: widget.size.width * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(63),
            bottomLeft: Radius.circular(63),
          ),
        ),
        child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.phone.toString()),
            Visibility(visible: widget.wapp != 0, child: Text(widget.wapp.toString())),
            Visibility(
                visible: widget.email != null, child: Text(widget.email)),
          ],
        )));
  }
}
