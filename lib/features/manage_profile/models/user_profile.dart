class UserProfile {
  String? name;
  String? email;
  String? phoneNumber;
  String? role;
  String? post;

  UserProfile({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.post,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'role': role,
        'post': post,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phoneNumber: json['phoneNumber'] ?? '',
        role: json['role'] ?? '',
        post: json['post'] ?? '',
      );

  UserProfile copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    String? role,
    String? post,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      post: post ?? this.post,
    );
  }
}
