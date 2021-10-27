import 'package:flutter/material.dart';
import 'package:plant_app/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
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
    return Scaffold(
      body: Body(
        image1: image1,
        image2: image2,
        title: title,
        city: city,
        price: price,
        category: category,
        discription: discription,
        email: email,
        wapp: wapp,
        phone: phone,
      ),
    );
  }
}
