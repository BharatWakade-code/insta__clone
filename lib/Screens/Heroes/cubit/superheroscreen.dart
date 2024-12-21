import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:insta_clone/Components/search.dart';
import 'package:insta_clone/Screens/Heroes/cubit/superhero_cubit.dart';

class SuperHeroScreen extends StatefulWidget {
  const SuperHeroScreen({super.key});

  @override
  State<SuperHeroScreen> createState() => _SuperHeroScreenState();
}

class _SuperHeroScreenState extends State<SuperHeroScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SuperheroCubit>().getSuperHeroes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          } else if (state is SuperHeroSuccesful) {
            final cubit = context.read<SuperheroCubit>().allSuperHeroes;
            if (cubit == null || cubit.isEmpty) {
              return const Center(
                child: Text("No superheroes found."),
              );
            }

            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Search(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 9,
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: cubit.length,
                    itemBuilder: (context, index) {
                      final hero = cubit[index];
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: hero.images?.sm ?? '',
                                placeholder: (context, url) => const Center(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hero.name ?? 'Unknown Hero',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    hero.biography?.firstAppearance ??
                                        'Unknown Appearance',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8,
                                    runSpacing: 4,
                                    children: [
                                      _buildChip("Intelligence",
                                          hero.powerstats?.intelligence),
                                      _buildChip("Strength",
                                          hero.powerstats?.strength),
                                      _buildChip(
                                          "Speed", hero.powerstats?.speed),
                                      _buildChip("Durability",
                                          hero.powerstats?.durability),
                                      _buildChip(
                                          "Power", hero.powerstats?.power),
                                      _buildChip(
                                          "Combat", hero.powerstats?.combat),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is SuperHeroError) {
            return Center(
              child: Text(state.msg),
            );
          } else {
            return const Center(
              child: Text("Unexpected state."),
            );
          }
        },
      ),
    );
  }

  Widget _buildChip(String label, int? value) {
    return Chip(
      label: Text(
        "$label: ${value ?? 'N/A'}",
        style: const TextStyle(fontSize: 12),
      ),
      backgroundColor: Colors.deepPurple.withOpacity(0.1),
      side: const BorderSide(color: Colors.deepPurple),
    );
  }
}
