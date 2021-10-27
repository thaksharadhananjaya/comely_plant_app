
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plant_app/bloc/plants/plant_bloc.dart';
import 'package:plant_app/screens/details/details_screen.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../../constants.dart';

class Plants extends StatefulWidget {
  final String search;
  Plants({Key key, this.search}) : super(key: key);

  @override
  _PlantsState createState() => _PlantsState();
}

class _PlantsState extends State<Plants> {
  PlantBloc plantBloc;

  @override
  void initState() {
    super.initState();
    print(widget.search);
    plantBloc = PlantBloc(false, widget.search);
    plantBloc.add(FetchPlant());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: plantBloc,
        builder: (context, state) {
          if (state is LoadedPlant) {
            int length = state.plantList.length;
            return Container(
              height: 250 * length.toDouble(),
              padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
              child: LazyLoadScrollView(
                onEndOfPage: () => plantBloc.add(FetchPlant()),
                child: ListView.builder(
                    itemCount: length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return PlantCard(
                        image: state.plantList[index].imageLink,
                        title: state.plantList[index].name,
                        city: state.plantList[index].city,
                        price: state.plantList[index].price,
                        press: () {
                          Navigator.push(
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
                          );
                        },
                      );
                    }),
              ),
            );
          } else if (state is PlantErrorState) {
            return Center(child:Text(state.message));
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

class PlantCard extends StatelessWidget {
  const PlantCard({
    Key key,
    this.image,
    this.press,
    this.title,
    this.city,
    this.price,
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
          left: kDefaultPadding,
          top: kDefaultPadding + 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.9,
        height: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(image),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(kDefaultPadding / 2),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
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
        ),
      ),
    );
  }
}
