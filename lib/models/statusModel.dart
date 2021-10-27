class Status {
  int id;
  String caption;
  String imageLink;
  String name;
  int dayDuration;
  String postTime;
  String pofilePhoto;

  Status(
      {this.id,
      this.caption,
      this.name,
      this.imageLink,
      this.dayDuration,
      this.pofilePhoto,
      this.postTime});

  Status.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['status_id']);
    name = json['name'];
    caption = json['caption'];
    imageLink = json['image_link'];
    dayDuration = int.parse(json['day_duration']);
    postTime = json['post_time'];
    pofilePhoto = json['profile_pic_link'];
  }
}
