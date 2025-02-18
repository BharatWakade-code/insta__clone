import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_clone/Components/photoview.dart';
import 'package:insta_clone/Screens/home/home_cubit.dart';
import 'package:insta_clone/Screens/home/posts/components/like_animation.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatefulWidget {
  final DocumentSnapshot snap;
  const PostCard({super.key, required this.snap});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  void initState() {
    context.read<HomeCubit>().fetchUserDetails();
    super.initState();
  }

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
              Stack(
                alignment: Alignment.center,
                children: [
                  InkWell(
                    onDoubleTap: () {
                      cubit.likePost(snap['postid'], snap['likes']);
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
                    child: CachedNetworkImage(
                      imageUrl: snap['posturl'],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 400,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                    ),
                  ),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: cubit.isLikeAnimating ? 1 : 0,
                    child: LikeAnimation(
                      isAnimating: cubit.isLikeAnimating,
                      duration: const Duration(milliseconds: 400),
                      onEnd: () => cubit.isLikeAnimating = false,
                      child: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: snap['profimage'],
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snap['username'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (snap['location'] != null &&
                            snap['location'].isNotEmpty)
                          Text(
                            snap['location'],
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[600]),
                          ),
                        Text(
                          timeago.format(
                              DateTime.parse(snap['datepublished']).toLocal()),
                          style:
                              TextStyle(fontSize: 10, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        LikeAnimation(
                          isAnimating:
                              snap['likes'].contains(cubit.currentUserUid),
                          smallLike: true,
                          child: IconButton(
                            icon: snap['likes'].contains(cubit.currentUserUid)
                                ? const Icon(Icons.favorite, color: Colors.red)
                                : const Icon(Icons.favorite_border),
                            onPressed: () =>
                                cubit.likePost(snap['postid'], snap['likes']),
                          ),
                        ),
                        Text('${snap['likes'].length} likes',
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[500])),
                        IconButton(
                          icon: const Icon(Icons.chat_bubble_outline_rounded),
                          onPressed: () {

                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.bookmark_border),
                          onPressed: () {},
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
