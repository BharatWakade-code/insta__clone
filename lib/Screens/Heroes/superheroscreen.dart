import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:insta_clone/Screens/Heroes/superhero_cubit.dart';
import 'package:insta_clone/Screens/Heroes/superhero_details/superherodeatils_screen.dart';
import 'package:insta_clone/utils/colors.dart';

class SuperHeroScreen extends StatefulWidget {
  const SuperHeroScreen({super.key});

  @override
  State<SuperHeroScreen> createState() => _SuperHeroScreenState();
}

class _SuperHeroScreenState extends State<SuperHeroScreen> {
  TextEditingController searchcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<SuperheroCubit>().getSuperHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<SuperheroCubit, SuperheroState>(
        listener: (context, state) {
          if (state is SuperHeroError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.msg)),
            );
          }
        },
        builder: (context, state) {
          if (state is SuperHeroLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: TextField(
                    controller: searchcontroller,
                    onChanged: (value) {
                      context.read<SuperheroCubit>().searchSuperHeroes(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.blueAccent,
                      ),
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              if (state is SuperHeroLoaded)
                (state.heroesList?.isNotEmpty ?? true)
                    ? Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: state.heroesList?.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final hero = state.heroesList?[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SuperHeroDetails(hero: hero!),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.grey[50],
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(10),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: hero?.images?.sm ?? '',
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error, size: 40),
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            hero?.name ?? 'Unknown Hero',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          // const SizedBox(height: 4),
                                          Text(
                                            hero?.biography?.firstAppearance ??
                                                'Unknown Appearance',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          // const SizedBox(height: 8),
                                          _buildChip("Combat",
                                              hero?.powerstats?.combat),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 80,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Superhero Not Found",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "We couldn't find the superhero you were looking for.\nPlease try searching again.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
            ],
          );
        },
      ),
    );
  }

  Widget _buildChip(String label, int? value) {
    final normalizedValue =
        (value ?? 0) / 100.0; // Normalize value between 0.0 and 1.0
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: normalizedValue.clamp(0.0, 1.0),
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    normalizedValue > 0.5 ? Colors.green : Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${value ?? 0}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
