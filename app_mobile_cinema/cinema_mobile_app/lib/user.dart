class Utilisateur {
  String username;
  String email;
  String password;

  Utilisateur({
    this.username,
    this.email,
    this.password,
  });

  @override
  String toString() =>
      'Utilisateur(username: $username, email: $email, password: $password)';

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}
