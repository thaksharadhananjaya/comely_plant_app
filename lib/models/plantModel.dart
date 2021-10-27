class Plant {
  int plantID;
  String category;
  String name;
  String price;
  String imageLink, imageLink2;
  String city;
  int phone;
  int wapp;
  String email;
  String discription;
  String date;

  Plant(
      {this.plantID,
      this.category,
      this.price,
      this.name,
      this.imageLink,
      this.imageLink2,
      this.discription,
      this.phone,
      this.wapp,
      this.email,
      this.city,
      this.date});

  Plant.fromJson(Map<String, dynamic> json) {
    plantID = int.parse(json['plantID']);
    category = json['category'];
    price = json['price'];
    name = json['name'];
    imageLink = json['imgLink'];
    city = json['city'];
    imageLink2 = json['imgLink2'];
    date = json['date'];
    discription = json['discription'];
    phone = int.parse(json['phone']);
    wapp = int.parse(json['wapp']);
    email = json['email'];
  }
}
