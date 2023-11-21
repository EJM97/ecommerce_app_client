class User {
  final String email;
  final String password;
  final String name;

  User({
    required this.email,
    required this.password,
    this.name = '', // Default to an empty string
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
      name: json['name'] ??
          '', // Set name to an empty string if it's not present in the JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }
}
