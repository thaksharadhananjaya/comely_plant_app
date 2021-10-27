import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:plant_app/bloc/plants/plant_bloc.dart';
import 'package:plant_app/screens/details/details_screen.dart';

import '../../../constants.dart';

class FeaturedPlants extends StatefulWidget {
  FeaturedPlants({Key key}) : super(key: key);

  @override
  _FeaturedPlantsState createState() => _FeaturedPlantsState();
}

class _FeaturedPlantsState extends State<FeaturedPlants> {
  PlantBloc plantBloc;

  @override
  void initState() {
    super.initState();
    plantBloc = PlantBloc(true, null);
    plantBloc.add(FetchPlant());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder(
        bloc: plantBloc,
        builder: (context, state) {
          if (state is LoadedPlant) {
            return Container(
              height: height * 0.311,
              padding: EdgeInsets.fromLTRB(kDefaultPadding, 0, 2, 0),
              child: LazyLoadScrollView(
                onEndOfPage: () {},
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.plantList.length,
                    itemBuilder: (context, index) {
                      return FeaturedPlantCard(
                        image: state.plantList[index].imageLink,
                        title: state.plantList[index].name,
                        city: state.plantList[index].city,
                        price: state.plantList[index].price,
                        press: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              image1: state.plantList[index].imageLink,
                              image2: state.plantList[index].imageLink2,
                              title: state.plantList[index].name,
                              city: state.plantList[index].city,
                              price: state.plantList[index].price,
                              category:state.plantList[index].category ,
                                discription: state.plantList[index].discription,
                                date: state.plantList[index].date,
                                phone:state.plantList[index].phone ,
                                wapp: state.plantList[index].wapp,
                                email: state.plantList[index].email,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            );
          } else if (state is PlantErrorState) {
            return Flushbar(
              icon: Icon(
                Icons.info,
                color: Colors.red,
              ),
              title: "Oops, Something went wrong",
              message: "But not sure what",
              backgroundColor: kPrimaryColor,
              duration: Duration(seconds: 3),
            )..show(context);
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

class FeaturedPlantCard extends StatelessWidget {
  const FeaturedPlantCard({
    Key key,
    this.image,
    this.title,
    this.city,
    this.price,
    this.press,
  }) : super(key: key);

  final String image, title, city, price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
          right: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5,
        ),
        width: size.width * 0.6,
        child: Column(
          children: <Widget>[
            Container(
              width: size.width * 0.6,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(image),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
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
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "$city".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Rs. $price',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
