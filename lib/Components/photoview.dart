import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  final String photourl;
  final String discription;
  const PhotoViewPage(
      {super.key, required this.photourl, required this.discription});

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.discription),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(widget.photourl),
        loadingBuilder: (context, event) {
          if (event == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final progress =
              event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1);
          return Center(
            child: SizedBox(
              width: 40.0,
              height: 40.0,
              child: CircularProgressIndicator(
                value: progress,
              ),
            ),
          );
        },
      ),
    );
  }
}
