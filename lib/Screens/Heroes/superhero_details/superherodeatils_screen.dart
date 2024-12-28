// ignore_for_file: unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:insta_clone/Screens/Chat/components/nav_bar.dart';
import 'package:insta_clone/models/allsuperheroes.dart';

class SuperHeroDetails extends StatefulWidget {
  final Superhero hero;

  const SuperHeroDetails({Key? key, required this.hero}) : super(key: key);

  @override
  State<SuperHeroDetails> createState() => _SuperHeroDetailsState();
}

class _SuperHeroDetailsState extends State<SuperHeroDetails> {
  @override
  Widget build(BuildContext context) {
    final hero = widget.hero;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NavBar(
        pageName: hero.name,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(hero),
            const SizedBox(height: 20),
            _buildPowerStats(hero),
            const SizedBox(height: 20),
            Section(
              title: "Biography",
              content: _buildBiography(hero),
            ),
            Section(
              title: "Appearance",
              content: _buildAppearance(hero),
            ),
            Section(
              title: "Work & Connections",
              content: _buildWorkAndConnections(hero),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Superhero hero) {
    return Stack(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(hero.images?.lg ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 250,
          color: Colors.black.withOpacity(0.5),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(hero.images?.sm ?? ''),
                onBackgroundImageError: (_, __) => const Icon(Icons.error),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hero.name,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    hero.biography?.aliases?.isNotEmpty == true
                        ? hero.biography!.aliases![0]
                        : 'No Alias',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPowerStats(Superhero hero) {
    return hero.powerstats != null
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: "Powerstats"),
                const SizedBox(height: 10),
                ...hero.powerstats!.toJson().entries.map((entry) {
                  final statLabel = entry.key;
                  final statValue =
                      double.tryParse(entry.value.toString()) ?? 0;

                  return PowerstatBar(
                    label: statLabel,
                    value: statValue,
                  );
                }).toList(),
              ],
            ),
          )
        : const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "No powerstats available.",
              style: TextStyle(color: Colors.grey),
            ),
          );
  }

  Widget _buildBiography(Superhero hero) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Full Name: ${hero.biography?.fullName ?? 'Unknown'}"),
        Text("Place of Birth: ${hero.biography?.placeOfBirth ?? 'Unknown'}"),
        Text(
            "First Appearance: ${hero.biography?.firstAppearance ?? 'Unknown'}"),
        Text("Alignment: ${hero.biography?.alignment ?? 'Unknown'}"),
      ],
    );
  }

  Widget _buildAppearance(Superhero hero) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Gender: ${hero.appearance?.gender ?? 'Unknown'}"),
        Text("Race: ${hero.appearance?.race ?? 'Unknown'}"),
        Text("Height: ${hero.appearance?.height?.join(' / ') ?? 'Unknown'}"),
        Text("Weight: ${hero.appearance?.weight?.join(' / ') ?? 'Unknown'}"),
        Text("Eye Color: ${hero.appearance?.eyeColor ?? 'Unknown'}"),
        Text("Hair Color: ${hero.appearance?.hairColor ?? 'Unknown'}"),
      ],
    );
  }

  Widget _buildWorkAndConnections(Superhero hero) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Occupation: ${hero.work?.occupation ?? 'Unknown'}"),
        Text("Base: ${hero.work?.base ?? 'Unknown'}"),
        Text(
          "Group Affiliations: ${hero.connections?.groupAffiliation ?? 'None'}",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "Relatives: ${hero.connections?.relatives ?? 'None'}",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class Section extends StatelessWidget {
  final String title;
  final Widget content;

  const Section({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionTitle(title: title),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    );
  }
}

class PowerstatBar extends StatelessWidget {
  final String label;
  final double value;

  const PowerstatBar({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          SizedBox(
              width: 80,
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600),
              )),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
              minHeight: 8,
            ),
          ),
          const SizedBox(width: 10),
          Text("${value.toInt()}"),
        ],
      ),
    );
  }
}
