class User {
  final int id;
  final String name;
  final String username;
  final String token;
  final String className;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.token,
    required this.className,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return User(
      id: data['user']['id'] ?? 0,
      name: data['user']['name'] ?? '',
      username: data['user']['username'] ?? '',
      token: data['token'] ?? '',
      className: data['user']['class']?['name'] ?? '',
    );
  }
}