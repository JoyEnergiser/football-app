import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CrestWidget extends StatefulWidget {
  CrestWidget({Key? key, required this.imageurl}) : super(key: key);
  late String imageurl;
  @override
  _CrestWidgetState createState() => _CrestWidgetState();
}

class _CrestWidgetState extends State<CrestWidget> {
  @override
  Widget build(BuildContext context) {
    try {
      if (widget.imageurl.contains('svg')) {
        // throw Exception('New error');
        return Container(
          width: 80.0,
          height: 80.0,
          child: SvgPicture.network(
            widget.imageurl,
            // fit: BoxFit.fill,
            // semanticsLabel: 'A shark?!',
            placeholderBuilder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(30.0),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      } else {
        return Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(widget.imageurl),
            ),
          ),
        );
      }
    } catch (e) {
      return Container(
        width: 80.0,
        height: 80.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider('https://socialistmodernism.com/wp-content/uploads/2017/07/placeholder-image.png'),
          ),
        ),
      );
    }
  }
}
