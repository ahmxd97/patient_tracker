enum Role { admin, doctor }

class User {
  final String email;
  final String password;
  final Role role;

  User({required this.email, required this.password, required this.role});
}
