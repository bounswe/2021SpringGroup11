class LoginResponse {
  final String username;
  final String email;
  final bool isAdmin;
  final int exp;

  LoginResponse({
    required this.username,
    required this.email,
    required this.isAdmin,
    required this.exp
  });

  factory LoginResponse.fromJson(Map<String,dynamic> json) {
    return LoginResponse(username: json['username'], email: json['email'], isAdmin: json['isAdmin'], exp: json['exp']);
  }

}