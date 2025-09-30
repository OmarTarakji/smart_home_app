class Profile {
  String? avatarUrl;
  String? username;

  Profile({this.avatarUrl, this.username});

  Profile copyWith({String? avatarUrl, String? username}) => Profile(
    avatarUrl: avatarUrl ?? this.avatarUrl,
    username: username ?? this.username,
  );
}
