import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageView extends StatelessWidget {
  final List<String> image;
  const ImageView({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Container(
        child: PhotoViewGallery.builder(
      builder: (BuildContext context, int index) {
      
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(image[index]),
          initialScale: PhotoViewComputedScale.contained * 0.8,
        );
      },
      itemCount: 2,
      loadingBuilder: (context, event) => Center(
        child: Container(
          width: 20.0,
          height: 20.0,
          child: CircularProgressIndicator(
            value: event == null
                ? 0
                : event.cumulativeBytesLoaded / event.expectedTotalBytes,
          ),
        ),
      ),
    ));
  }
}
