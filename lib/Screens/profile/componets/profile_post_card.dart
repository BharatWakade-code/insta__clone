import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/Components/photoview.dart';
import 'package:insta_clone/Screens/home/home_cubit.dart';
import 'package:insta_clone/Screens/home/posts/components/like_animation.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProfileCard extends StatefulWidget {
  final DocumentSnapshot snap;
  const ProfileCard({super.key, required this.snap});

  @override
  State<ProfileCard> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    var snap = widget.snap.data() as Map<String, dynamic>;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          constraints: const BoxConstraints(minHeight: 200, maxHeight: 400),
          width: double.infinity,
          child: CachedNetworkImage(
            fadeInCurve: Easing.standardAccelerate,
            fadeInDuration: Durations.long1,
            imageUrl: snap['posturl'],
            fit: BoxFit.cover,
            progressIndicatorBuilder: (context, url, downloadProgress) {
              return Container(
                constraints:
                    const BoxConstraints(minHeight: 400, maxHeight: 500),
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    color: Colors.black,
                  ),
                ),
              );
            },
            errorWidget: (context, url, error) {
              return Container(
                constraints:
                    const BoxConstraints(minHeight: 400, maxHeight: 500),
                width: double.infinity,
                child: const Center(
                  child: Icon(Icons.error, color: Colors.red),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
