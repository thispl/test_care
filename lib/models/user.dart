class User {
  String email;
  String password;

  User({
    this.email,
    this.password
  });

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    Map json = parsedJson['user'];
    return User(
      email: json['email'],
      password: json['password']
      
    );
  }
}