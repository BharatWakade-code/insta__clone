class Superhero {
  final int id;
  final String name;
  final String slug;
  final Powerstats? powerstats;
  final Appearance? appearance;
  final Biography? biography;
  final Work? work;
  final Connections? connections;
  final Images? images;

  Superhero({
    required this.id,
    required this.name,
    required this.slug,
    this.powerstats,
    this.appearance,
    this.biography,
    this.work,
    this.connections,
    this.images,
  });

  factory Superhero.fromJson(Map<String, dynamic> json) {
    return Superhero(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      slug: json['slug'] ?? 'unknown-slug',
      powerstats: json['powerstats'] != null ? Powerstats.fromJson(json['powerstats']) : null,
      appearance: json['appearance'] != null ? Appearance.fromJson(json['appearance']) : null,
      biography: json['biography'] != null ? Biography.fromJson(json['biography']) : null,
      work: json['work'] != null ? Work.fromJson(json['work']) : null,
      connections: json['connections'] != null ? Connections.fromJson(json['connections']) : null,
      images: json['images'] != null ? Images.fromJson(json['images']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'powerstats': powerstats?.toJson(),
      'appearance': appearance?.toJson(),
      'biography': biography?.toJson(),
      'work': work?.toJson(),
      'connections': connections?.toJson(),
      'images': images?.toJson(),
    };
  }
}

class Powerstats {
  final int intelligence;
  final int strength;
  final int speed;
  final int durability;
  final int power;
  final int combat;

  Powerstats({
    required this.intelligence,
    required this.strength,
    required this.speed,
    required this.durability,
    required this.power,
    required this.combat,
  });

  factory Powerstats.fromJson(Map<String, dynamic> json) {
    return Powerstats(
      intelligence: json['intelligence'] ?? 0,
      strength: json['strength'] ?? 0,
      speed: json['speed'] ?? 0,
      durability: json['durability'] ?? 0,
      power: json['power'] ?? 0,
      combat: json['combat'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'intelligence': intelligence,
      'strength': strength,
      'speed': speed,
      'durability': durability,
      'power': power,
      'combat': combat,
    };
  }
}

class Appearance {
  final String? gender;
  final String? race;
  final List<String>? height;
  final List<String>? weight;
  final String? eyeColor;
  final String? hairColor;

  Appearance({
    this.gender,
    this.race,
    this.height,
    this.weight,
    this.eyeColor,
    this.hairColor,
  });

  factory Appearance.fromJson(Map<String, dynamic> json) {
    return Appearance(
      gender: json['gender'],
      race: json['race'],
      height: (json['height'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      weight: (json['weight'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      eyeColor: json['eyeColor'],
      hairColor: json['hairColor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'race': race,
      'height': height,
      'weight': weight,
      'eyeColor': eyeColor,
      'hairColor': hairColor,
    };
  }
}

class Biography {
  final String? fullName;
  final String? alterEgos;
  final List<String>? aliases;
  final String? placeOfBirth;
  final String? firstAppearance;
  final String? publisher;
  final String? alignment;

  Biography({
    this.fullName,
    this.alterEgos,
    this.aliases,
    this.placeOfBirth,
    this.firstAppearance,
    this.publisher,
    this.alignment,
  });

  factory Biography.fromJson(Map<String, dynamic> json) {
    return Biography(
      fullName: json['fullName'],
      alterEgos: json['alterEgos'],
      aliases: (json['aliases'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      placeOfBirth: json['placeOfBirth'],
      firstAppearance: json['firstAppearance'],
      publisher: json['publisher'],
      alignment: json['alignment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'alterEgos': alterEgos,
      'aliases': aliases,
      'placeOfBirth': placeOfBirth,
      'firstAppearance': firstAppearance,
      'publisher': publisher,
      'alignment': alignment,
    };
  }
}

class Work {
  final String? occupation;
  final String? base;

  Work({
    this.occupation,
    this.base,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      occupation: json['occupation'],
      base: json['base'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'occupation': occupation,
      'base': base,
    };
  }
}

class Connections {
  final String? groupAffiliation;
  final String? relatives;

  Connections({
    this.groupAffiliation,
    this.relatives,
  });

  factory Connections.fromJson(Map<String, dynamic> json) {
    return Connections(
      groupAffiliation: json['groupAffiliation'],
      relatives: json['relatives'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupAffiliation': groupAffiliation,
      'relatives': relatives,
    };
  }
}

class Images {
  final String? xs;
  final String? sm;
  final String? md;
  final String? lg;

  Images({
    this.xs,
    this.sm,
    this.md,
    this.lg,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      xs: json['xs'],
      sm: json['sm'],
      md: json['md'],
      lg: json['lg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'xs': xs,
      'sm': sm,
      'md': md,
      'lg': lg,
    };
  }
}
