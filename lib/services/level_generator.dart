import 'dart:math';
import 'package:flutter/material.dart';
import '../models/game_models.dart';

class LevelGenerator {
  static const Map<String, List<String>> categories = {
    'ANIMALS': [
      'ANT',
      'BAT',
      'BEE',
      'CAT',
      'COW',
      'DOG',
      'ELK',
      'FOX',
      'OWL',
      'PIG',
      'RAM',
      'YAK',
      'BEAR',
      'BIRD',
      'DEER',
      'DUCK',
      'FROG',
      'GOAT',
      'HARE',
      'LION',
      'MOLE',
      'SEAL',
      'SWAN',
      'WOLF',
      'CAMEL',
      'EAGLE',
      'HORSE',
      'KOALA',
      'LEMUR',
      'MOOSE',
      'OTTER',
      'PANDA',
      'SHEEP',
      'TIGER',
      'ZEBRA',
      'BADGER',
      'BEAVER',
      'FALCON',
      'FERRET',
      'MONKEY',
      'RABBIT',
      'TURTLE',
      'WALRUS',
      'CHEETAH',
      'DOLPHIN',
      'GIRAFFE',
      'HAMSTER',
      'LEOPARD',
      'PENGUIN',
      'ELEPHANT',
      'FLAMINGO',
      'HEDGEHOG',
      'KANGAROO',
      'ALLIGATOR',
      'CHAMELEON',
      'CROCODILE',
    ],
    'FOOD_DRINK': [
      'EGG',
      'FIG',
      'HAM',
      'JAM',
      'NUT',
      'OAT',
      'PIE',
      'TEA',
      'BEEF',
      'CAKE',
      'CORN',
      'LIME',
      'MEAT',
      'MILK',
      'PEAR',
      'PLUM',
      'PORK',
      'RICE',
      'SOUP',
      'TACO',
      'APPLE',
      'BACON',
      'BERRY',
      'BREAD',
      'CANDY',
      'CHILI',
      'CREAM',
      'GRAPE',
      'LEMON',
      'MANGO',
      'MELON',
      'ONION',
      'PASTA',
      'PEACH',
      'PIZZA',
      'SALAD',
      'STEAK',
      'SUSHI',
      'BANANA',
      'BURGER',
      'CARROT',
      'CHEESE',
      'COOKIE',
      'MUFFIN',
      'ORANGE',
      'PAPAYA',
      'POTATO',
      'TOMATO',
      'WAFFLE',
      'AVOCADO',
      'BISCUIT',
      'CHICKEN',
      'NOODLES',
      'PANCAKE',
      'POPCORN',
      'SAUSAGE',
      'BROCCOLI',
      'CINNAMON',
      'MUSHROOM',
      'SANDWICH',
      'BLUEBERRY',
      'CHOCOLATE',
      'PINEAPPLE',
      'SPAGHETTI',
    ],
    'NATURE_PLANTS': [
      'ASH',
      'BAY',
      'ELM',
      'FOG',
      'ICE',
      'MUD',
      'OAK',
      'SEA',
      'SKY',
      'SUN',
      'BUSH',
      'CLAY',
      'DIRT',
      'HILL',
      'LAKE',
      'LEAF',
      'POND',
      'RAIN',
      'ROOT',
      'ROSE',
      'SAND',
      'SNOW',
      'TREE',
      'WAVE',
      'WIND',
      'BEACH',
      'CLIFF',
      'CLOUD',
      'DAISY',
      'EARTH',
      'FLORA',
      'GRASS',
      'GROVE',
      'OASIS',
      'PLANT',
      'RIVER',
      'STORM',
      'WOODS',
      'BAMBOO',
      'BRANCH',
      'CANYON',
      'DESERT',
      'FOREST',
      'GARDEN',
      'ISLAND',
      'JUNGLE',
      'MEADOW',
      'VALLEY',
      'BLOSSOM',
      'CACTUS',
      'GLACIER',
      'VOLCANO',
      'MOUNTAIN',
      'SUNFLOWER',
      'WATERFALL',
    ],
    'SPACE_UNIVERSE': [
      'RAY',
      'SKY',
      'SUN',
      'DARK',
      'MARS',
      'MOON',
      'NOVA',
      'STAR',
      'COMET',
      'EARTH',
      'ORBIT',
      'PLUTO',
      'SOLAR',
      'SPACE',
      'VENUS',
      'AURORA',
      'CRATER',
      'GALAXY',
      'METEOR',
      'NEBULA',
      'PLANET',
      'ROCKET',
      'SATURN',
      'SPHERE',
      'COSMOS',
      'GRAVITY',
      'JUPITER',
      'NEPTUNE',
      'URANUS',
      'ASTEROID',
      'ECLIPSE',
      'SATELLITE',
      'UNIVERSE',
      'ASTRONAUT',
      'SUPERNOVA',
      'TELESCOPE',
    ],
    'OCEAN_MARINE': [
      'BAY',
      'EEL',
      'FIN',
      'NET',
      'SEA',
      'CRAB',
      'DEEP',
      'FISH',
      'GULL',
      'KELP',
      'REEF',
      'SAND',
      'SURF',
      'TIDE',
      'WAVE',
      'CORAL',
      'DIVER',
      'OCEAN',
      'OTTER',
      'SHARK',
      'SHELL',
      'SQUID',
      'WHALE',
      'ANEMONE',
      'ISLAND',
      'MARINA',
      'SALMON',
      'TURTLE',
      'URCHIN',
      'WALRUS',
      'CURRENT',
      'DOLPHIN',
      'LOBSTER',
      'OCTOPUS',
      'PENGUIN',
      'SEAHORSE',
      'BARNACLE',
      'JELLYFISH',
      'STARFISH',
      'SUBMARINE',
    ],
    'SPORTS_GAMES': [
      'BOW',
      'CUP',
      'FAN',
      'RUN',
      'SKI',
      'TAG',
      'WIN',
      'BALL',
      'BASE',
      'CLUB',
      'DART',
      'GOAL',
      'GOLF',
      'HOOP',
      'JUMP',
      'RACE',
      'SURF',
      'SWIM',
      'TEAM',
      'ARENA',
      'CHESS',
      'COACH',
      'DERBY',
      'MEDAL',
      'PITCH',
      'RUGBY',
      'SCORE',
      'SKATE',
      'TRACK',
      'BOXING',
      'CRICKET',
      'HOCKEY',
      'KARATE',
      'ROWING',
      'RUNNER',
      'SOCCER',
      'TENNIS',
      'ARCHERY',
      'BOWLING',
      'FITNESS',
      'STADIUM',
      'SURFING',
      'BASEBALL',
      'FOOTBALL',
      'SWIMMING',
      'ATHLETICS',
      'BADMINTON',
    ],
    'COLORS_GEMS': [
      'RED',
      'TAN',
      'BLUE',
      'CYAN',
      'GOLD',
      'GRAY',
      'JADE',
      'LIME',
      'NAVY',
      'ONYX',
      'OPAL',
      'PINK',
      'ROSE',
      'RUBY',
      'RUST',
      'TEAL',
      'AMBER',
      'BLACK',
      'BROWN',
      'CORAL',
      'GREEN',
      'PEARL',
      'TOPAZ',
      'WHITE',
      'BRONZE',
      'COPPER',
      'GARNET',
      'INDIGO',
      'ORANGE',
      'PURPLE',
      'QUARTZ',
      'SILVER',
      'VIOLET',
      'YELLOW',
      'CRIMSON',
      'DIAMOND',
      'EMERALD',
      'MAGENTA',
      'SCARLET',
      'AMETHYST',
      'PLATINUM',
      'SAPPHIRE',
      'TURQUOISE',
    ],
    'HOME_LIVING': [
      'BED',
      'CUP',
      'DEN',
      'FAN',
      'MAT',
      'MUG',
      'PAN',
      'POT',
      'RUG',
      'TUB',
      'BOWL',
      'DESK',
      'DOOR',
      'FORK',
      'HOME',
      'LAMP',
      'LOCK',
      'OVEN',
      'ROOF',
      'ROOM',
      'SEAT',
      'SOFA',
      'WALL',
      'YARD',
      'BENCH',
      'CHAIR',
      'CLOCK',
      'FLOOR',
      'GLASS',
      'HOUSE',
      'KNIFE',
      'PORCH',
      'SHELF',
      'SPOON',
      'STOVE',
      'TABLE',
      'TOWEL',
      'BLANKET',
      'CABINET',
      'CURTAIN',
      'CUSHION',
      'DRAWER',
      'KITCHEN',
      'MIRROR',
      'PILLOW',
      'WINDOW',
      'BALCONY',
      'BEDROOM',
      'CHIMNEY',
      'HALLWAY',
      'ARMCHAIR',
      'BOOKCASE',
      'FIREPLACE',
      'WARDROBE',
    ],
    'CLOTHING_STYLE': [
      'CAP',
      'HAT',
      'TIE',
      'BELT',
      'BOOT',
      'COAT',
      'GLOVE',
      'HOOD',
      'RING',
      'ROBE',
      'SHOE',
      'SOCK',
      'SUIT',
      'VEST',
      'DRESS',
      'JEANS',
      'PANTS',
      'SCARF',
      'SHIRT',
      'SKIRT',
      'WATCH',
      'BLOUSE',
      'BUTTON',
      'CLOAK',
      'COLLAR',
      'FLEECE',
      'JACKET',
      'POCKET',
      'SANDAL',
      'ZIPPER',
      'HOODIE',
      'PAJAMAS',
      'SWEATER',
      'UNIFORM',
      'BRACELET',
      'CARDIGAN',
      'NECKLACE',
      'RAINCOAT',
      'SNEAKERS',
      'TROUSERS',
      'GOGGLES',
    ],
    'TRAVEL_PLACES': [
      'BUS',
      'CAB',
      'MAP',
      'VAN',
      'WAY',
      'BOAT',
      'CITY',
      'LANE',
      'PARK',
      'PATH',
      'PORT',
      'ROAD',
      'SHIP',
      'TOWN',
      'TRAM',
      'BEACH',
      'CABIN',
      'FERRY',
      'HOTEL',
      'METRO',
      'MOTEL',
      'PLAZA',
      'ROUTE',
      'TRAIN',
      'TRUCK',
      'AVENUE',
      'BRIDGE',
      'HARBOR',
      'HIGHWAY',
      'MUSEUM',
      'RESORT',
      'RUNWAY',
      'STREET',
      'TUNNEL',
      'AIRPORT',
      'CAPITAL',
      'JOURNEY',
      'STATION',
      'VILLAGE',
      'AIRPLANE',
      'CRUISING',
      'EXPLORER',
      'MONUMENT',
      'TERMINAL',
      'TRAVELER',
    ],
    'MUSIC_ARTS': [
      'ACT',
      'ART',
      'BOW',
      'BAND',
      'BASS',
      'BEAT',
      'DRUM',
      'DUET',
      'HORN',
      'POEM',
      'SONG',
      'TUNE',
      'CHORD',
      'DANCE',
      'DRAMA',
      'FLUTE',
      'MUSIC',
      'NOVEL',
      'OPERA',
      'PAINT',
      'PIANO',
      'SCALE',
      'STAGE',
      'TEMPO',
      'VOICE',
      'ARTIST',
      'CANVAS',
      'CHORUS',
      'GUITAR',
      'MUSEUM',
      'POETRY',
      'RHYTHM',
      'SINGER',
      'VIOLIN',
      'CONCERT',
      'DRAWING',
      'GALLERY',
      'HARMONY',
      'MELODY',
      'ACCORDION',
      'ORCHESTRA',
      'SAXOPHONE',
      'SCULPTURE',
    ],
    'SCIENCE_TECH': [
      'APP',
      'DOT',
      'NET',
      'WEB',
      'ATOM',
      'BYTE',
      'CELL',
      'CHIP',
      'CODE',
      'DATA',
      'DISK',
      'FILE',
      'ICON',
      'LINK',
      'TECH',
      'USER',
      'ARRAY',
      'AUDIO',
      'CLICK',
      'CLOUD',
      'DRIVE',
      'LASER',
      'LOGIC',
      'MOUSE',
      'PIXEL',
      'RADAR',
      'ROBOT',
      'SCALE',
      'VIDEO',
      'CAMERA',
      'CIRCUIT',
      'DEVICE',
      'ENGINE',
      'LAPTOP',
      'MEMORY',
      'MOBILE',
      'MODEM',
      'ONLINE',
      'ROUTER',
      'SCREEN',
      'SENSOR',
      'SERVER',
      'SYSTEM',
      'BATTERY',
      'BROWSER',
      'DISPLAY',
      'GRAPHIC',
      'KEYBOARD',
      'MONITOR',
      'NETWORK',
      'PROGRAM',
      'SCANNER',
      'WEBSITE',
      'COMPUTER',
      'HARDWARE',
      'INTERNET',
      'SOFTWARE',
    ],
    'WEATHER_NATURE': [
      'FOG',
      'ICE',
      'SUN',
      'COLD',
      'DAMP',
      'GALE',
      'HAIL',
      'HEAT',
      'MIST',
      'RAIN',
      'SNOW',
      'WARM',
      'WIND',
      'CHILL',
      'CLOUD',
      'FROST',
      'HUMID',
      'SHINE',
      'STORM',
      'SUNNY',
      'BREEZE',
      'CLOUDY',
      'DRIZZLE',
      'SHOWER',
      'SPRING',
      'SUMMER',
      'WINTER',
      'AUTUMN',
      'BLIZZARD',
      'CLIMATE',
      'CYCLONE',
      'MONSOON',
      'RAINBOW',
      'SUNSHINE',
      'THUNDER',
      'TORNADO',
      'TYPHOON',
      'DROUGHT',
      'FORECAST',
      'HURRICANE',
      'LIGHTNING',
      'OVERCAST',
    ],
    'BODY_HEALTH': [
      'ARM',
      'EAR',
      'EYE',
      'FIT',
      'GUM',
      'JAW',
      'LEG',
      'LIP',
      'RIB',
      'TOE',
      'BACK',
      'BONE',
      'CHIN',
      'FACE',
      'FOOT',
      'HAIR',
      'HAND',
      'HEAD',
      'KNEE',
      'NECK',
      'NOSE',
      'SKIN',
      'BLOOD',
      'BRAIN',
      'CHEST',
      'ELBOW',
      'HEART',
      'MOUTH',
      'PULSE',
      'SMILE',
      'THUMB',
      'TOOTH',
      'VOICE',
      'WAIST',
      'WRIST',
      'BREATH',
      'FINGER',
      'HEALTH',
      'MUSCLE',
      'TONGUE',
      'SHOULDER',
      'SKELETON',
      'STOMACH',
    ],
  };

  static PuzzleDifficulty difficultyForLevel(int level) {
    if (level <= 15) return PuzzleDifficulty.easy;
    if (level <= 40) return PuzzleDifficulty.medium;
    if (level <= 70) return PuzzleDifficulty.hard;
    if (level <= 85) return PuzzleDifficulty.expert;
    return PuzzleDifficulty.master;
  }

  static int gridSizeForLevel(int level) {
    if (level <= 5) return 5;
    if (level <= 15) return 6;
    if (level <= 30) return 7;
    if (level <= 50) return 8;
    if (level <= 65) return 9;
    if (level <= 80) return 10;
    if (level <= 90) return 11;
    return 12;
  }

  static int wordCountForLevel(int level) {
    if (level <= 15) return 3;
    if (level <= 30) return 4;
    if (level <= 50) return 5;
    if (level <= 70) return 6;
    if (level <= 85) return 7;
    return 8;
  }

  static int minWordLengthForLevel(int level) {
    if (level <= 50) return 3;
    return 4;
  }

  static int maxWordLengthForLevel(int level, int gridSize) {
    if (level <= 5) return min(4, gridSize);
    if (level <= 15) return min(5, gridSize);
    if (level <= 30) return min(6, gridSize);
    if (level <= 50) return min(7, gridSize);
    if (level <= 70) return min(8, gridSize);
    return min(9, gridSize);
  }

  static List<List<int>> directionsForLevel(int level) {
    if (level <= 5) {
      return [
        [0, 1],
      ];
    }
    if (level <= 15) {
      return [
        [0, 1],
        [1, 0],
      ];
    }
    if (level <= 30) {
      return [
        [0, 1],
        [1, 0],
        [1, 1],
      ];
    }
    if (level <= 50) {
      return [
        [0, 1],
        [1, 0],
        [1, 1],
        [0, -1],
      ];
    }
    if (level <= 70) {
      return [
        [0, 1],
        [1, 0],
        [1, 1],
        [0, -1],
        [-1, 0],
        [-1, 1],
      ];
    }
    return [
      [0, 1],
      [1, 0],
      [1, 1],
      [-1, 1],
      [0, -1],
      [-1, 0],
      [-1, -1],
      [1, -1],
    ];
  }

  static List<List<int>> directionsForDifficulty(PuzzleDifficulty diff) {
    if (diff == PuzzleDifficulty.easy) {
      return [
        [0, 1],
        [1, 0],
      ];
    }
    if (diff == PuzzleDifficulty.medium) {
      return [
        [0, 1],
        [1, 0],
        [1, 1],
      ];
    }
    if (diff == PuzzleDifficulty.hard) {
      return [
        [0, 1],
        [1, 0],
        [1, 1],
        [0, -1],
        [-1, 0],
      ];
    }
    return [
      [0, 1],
      [1, 0],
      [1, 1],
      [-1, 1],
      [0, -1],
      [-1, 0],
      [-1, -1],
      [1, -1],
    ];
  }

  static GameState generateLevel(int level) {
    final difficulty = difficultyForLevel(level);
    final seed = level * 7919 + 31;
    return _buildPuzzle(
      level: level,
      isRandom: false,
      difficulty: difficulty,
      seed: seed,
    );
  }

  static GameState generateDifficultyLevel(PuzzleDifficulty difficulty, {int? seed}) {
    final actualSeed = seed ?? Random().nextInt(1000000);
    return _buildPuzzle(
      level: 1,
      isRandom: true,
      difficulty: difficulty,
      seed: actualSeed,
    );
  }

  static GameState _buildPuzzle({
    required int level,
    required bool isRandom,
    required PuzzleDifficulty difficulty,
    required int seed,
  }) {
    final rng = Random(seed);
    final categoryKeys = categories.keys.toList();
    final categoryIndex = rng.nextInt(categoryKeys.length);
    final categoryName = categoryKeys[categoryIndex];
    final wordPool = List<String>.from(categories[categoryName]!)..shuffle(rng);

    final gridSize = isRandom ? difficulty.gridSize : gridSizeForLevel(level);
    final targetWordCount =
        isRandom ? difficulty.wordCount : wordCountForLevel(level);
    final minLen = isRandom
        ? (difficulty.gridSize <= 6 ? 3 : 4)
        : minWordLengthForLevel(level);
    final maxLen = isRandom
        ? min(9, gridSize)
        : maxWordLengthForLevel(level, gridSize);
    final directions =
        isRandom ? directionsForDifficulty(difficulty) : directionsForLevel(level);

    final filteredPool = wordPool.where((w) {
      return w.length >= minLen && w.length <= maxLen;
    }).toList();
    final candidatePool = filteredPool.length >= targetWordCount
        ? filteredPool
        : wordPool.where((w) => w.length <= gridSize).toList();

    final grid = List.generate(
      gridSize,
      (_) => List.generate(gridSize, (_) => ''),
    );

    final placedWords = <WordPlacement>[];
    int colorIdx = 0;

    for (final word in candidatePool) {
      if (placedWords.length >= targetWordCount) break;
      if (word.length > gridSize) continue;

      final placed = _tryPlaceWord(
        word,
        grid,
        gridSize,
        directions,
        rng,
        WordColors.palette[colorIdx % WordColors.palette.length],
      );

      if (placed != null) {
        placedWords.add(placed);
        colorIdx++;
      }
    }

    final targetChars = placedWords
        .map((w) => w.word)
        .join()
        .split('')
        .toSet()
        .toList();

    const allLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final decoyRatio = isRandom
        ? (difficulty == PuzzleDifficulty.hard
            ? 0.30
            : (difficulty == PuzzleDifficulty.expert ||
                    difficulty == PuzzleDifficulty.master
                ? 0.50
                : 0.0))
        : (level <= 25
            ? 0.0
            : (level <= 50 ? 0.25 : (level <= 75 ? 0.40 : 0.55)));

    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (grid[r][c].isEmpty) {
          if (targetChars.isNotEmpty && rng.nextDouble() < decoyRatio) {
            grid[r][c] = targetChars[rng.nextInt(targetChars.length)];
          } else {
            grid[r][c] = allLetters[rng.nextInt(allLetters.length)];
          }
        }
      }
    }

    return GameState(
      level: level,
      isRandom: isRandom,
      difficulty: difficulty,
      seed: seed,
      gridSize: gridSize,
      grid: grid,
      words: placedWords,
      status: GameStatus.playing,
    );
  }

  static WordPlacement? _tryPlaceWord(
    String word,
    List<List<String>> grid,
    int gridSize,
    List<List<int>> directions,
    Random rng,
    Color color,
  ) {
    final possibleDirs = List<List<int>>.from(directions)..shuffle(rng);

    for (final dir in possibleDirs) {
      final dr = dir[0];
      final dc = dir[1];

      final validStarts = <Point<int>>[];

      for (int r = 0; r < gridSize; r++) {
        for (int c = 0; c < gridSize; c++) {
          final endR = r + dr * (word.length - 1);
          final endC = c + dc * (word.length - 1);

          if (endR >= 0 && endR < gridSize && endC >= 0 && endC < gridSize) {
            bool canPlace = true;
            for (int i = 0; i < word.length; i++) {
              final checkR = r + dr * i;
              final checkC = c + dc * i;
              final currentLetter = grid[checkR][checkC];
              if (currentLetter.isNotEmpty && currentLetter != word[i]) {
                canPlace = false;
                break;
              }
            }
            if (canPlace) {
              validStarts.add(Point(r, c));
            }
          }
        }
      }

      if (validStarts.isNotEmpty) {
        final start = validStarts[rng.nextInt(validStarts.length)];
        final coords = <GridCoordinate>[];

        for (int i = 0; i < word.length; i++) {
          final placeR = start.x + dr * i;
          final placeC = start.y + dc * i;
          grid[placeR][placeC] = word[i];
          coords.add(GridCoordinate(placeR, placeC));
        }

        return WordPlacement(
          word: word,
          coordinates: coords,
          color: color,
        );
      }
    }

    return null;
  }
}
