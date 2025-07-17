import 'dart:math';

class UserGenerator {
  static final Random _random = Random();

  // List of sample names for variety
  static const List<String> _firstNames = [
    'Alice',
    'Bob',
    'Charlie',
    'Diana',
    'Eve',
    'Frank',
    'Grace',
    'Henry',
    'Ivy',
    'Jack',
    'Kate',
    'Liam',
    'Mia',
    'Noah',
    'Olivia',
    'Paul',
    'Quinn',
    'Ruby',
    'Sam',
    'Tara',
    'Uma',
    'Victor',
    'Wendy',
    'Xavier',
    'Yara',
    'Zoe',
    'Alex',
    'Jordan',
    'Taylor',
    'Casey',
    'Morgan',
    'Riley',
  ];

  static const List<String> _lastNames = [
    'Smith',
    'Johnson',
    'Williams',
    'Brown',
    'Jones',
    'Garcia',
    'Miller',
    'Davis',
    'Rodriguez',
    'Martinez',
    'Hernandez',
    'Lopez',
    'Gonzalez',
    'Wilson',
    'Anderson',
    'Thomas',
    'Taylor',
    'Moore',
    'Jackson',
    'Martin',
    'Lee',
    'Perez',
    'Thompson',
    'White',
    'Harris',
    'Sanchez',
    'Clark',
    'Ramirez',
    'Lewis',
    'Robinson',
    'Walker',
    'Young',
    'Allen',
    'King',
  ];

  // Generate a random user ID
  static String generateUserId() {
    const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    const int length = 8;

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(_random.nextInt(chars.length)),
      ),
    );
  }

  // Generate a random full name
  static String generateFullName() {
    String firstName = _firstNames[_random.nextInt(_firstNames.length)];
    String lastName = _lastNames[_random.nextInt(_lastNames.length)];

    return '$firstName $lastName';
  }

  // Generate a random display name (first name only)
  static String generateDisplayName() {
    return _firstNames[_random.nextInt(_firstNames.length)];
  }

  // Generate both userId and name together
  static Map<String, String> generateUser() {
    return {'userId': generateUserId(), 'name': generateDisplayName()};
  }

  // Generate a unique user with timestamp
  static Map<String, String> generateUniqueUser() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomId = generateUserId();
    final uniqueId = '${randomId}_$timestamp';

    return {'userId': uniqueId, 'name': generateDisplayName()};
  }

  // Generate a user with custom prefix
  static Map<String, String> generateUserWithPrefix(String prefix) {
    final randomId = generateUserId();
    final prefixedId = '${prefix}_$randomId';

    return {'userId': prefixedId, 'name': generateDisplayName()};
  }
}
