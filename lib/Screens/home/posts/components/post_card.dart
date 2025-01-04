import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/Components/photoview.dart';
import 'package:insta_clone/Screens/home/home_cubit.dart';
import 'package:insta_clone/Screens/home/posts/components/like_animation.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatefulWidget {
  final DocumentSnapshot snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    var snap = widget.snap.data() as Map<String, dynamic>;
    final cubit = context.read<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section with Cover Image
              Stack(
                alignment: Alignment.center,
                children: [
                  InkWell(
                    onDoubleTap: () {
                      cubit.likePost(
                          snap['postid'], cubit.currentUserUid, snap['likes']);
                      cubit.togglelikebtn();
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PhotoViewPage(
                            discription: snap['description'],
                            photourl: snap['posturl'],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      constraints:
                          const BoxConstraints(minHeight: 400, maxHeight: 1000),
                      width: double.infinity,
                      child: CachedNetworkImage(
                        fadeInCurve: Easing.standardAccelerate,
                        fadeInDuration: Durations.long1,
                        imageUrl: snap['posturl'],
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                          return Container(
                            constraints: const BoxConstraints(
                                minHeight: 400, maxHeight: 500),
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
                            constraints: const BoxConstraints(
                                minHeight: 400, maxHeight: 500),
                            width: double.infinity,
                            child: const Center(
                              child: Icon(Icons.error, color: Colors.red),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: cubit.isLikeAnimating ? 1 : 0,
                    child: LikeAnimation(
                      isAnimating: cubit.isLikeAnimating,
                      duration: const Duration(
                        milliseconds: 400,
                      ),
                      onEnd: () {
                        setState(() {
                          cubit.isLikeAnimating = false;
                        });
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                  ),
                ],
              ),
              // User Information Section
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    // Profile Image
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: snap['profimage'],
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Username, Location, and Time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              snap['username'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 4),

                            // Caption Section
                            if (snap['description'] != null &&
                                snap['description'].toString().isNotEmpty)
                              Text(
                                snap['description'],
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                        if (snap['location'] != null &&
                            snap['location'].toString().isNotEmpty)
                          Text(
                            snap['location'] ?? '',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        Text(
                          timeago.format(
                            DateTime.parse(snap['datepublished']).toLocal(),
                          ),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Icons (Like and Bookmark)
                    Row(
                      children: [
                        LikeAnimation(
                          isAnimating: widget.snap['likes'].contains(
                            cubit.currentUserUid,
                          ),
                          smallLike: true,
                          child: IconButton(
                            icon: widget.snap['likes'].contains(
                              cubit.currentUserUid,
                            )
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                  ),
                            onPressed: () async {
                              // Handle like action
                              cubit.likePost(snap['postid'],
                                  cubit.currentUserUid, snap['likes']);
                            },
                          ),
                        ),
                        Text(
                          '${widget.snap['likes'].length} likes',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.chat_bubble_outline_rounded,
                            color: Colors.black,
                            size: 22,
                          ),
                          onPressed: () {
                            // Handle comment action
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.bookmark_border,
                            color: Colors.black,
                            size: 22,
                          ),
                          onPressed: () {
                            // Handle bookmark action
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
