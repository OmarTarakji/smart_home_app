class Room {
  final String name;
  final String? imageUrl;

  Room({required this.name, this.imageUrl});

  Room.fromJson(Map<String, dynamic> json)
    : name = json['name'],
      imageUrl = json['image_url'];

  Map<String, dynamic> get toJson => {'name': name, 'image_url': imageUrl};

  Room copyWith({String? name, String? imageUrl}) {
    return Room(name: name ?? this.name, imageUrl: imageUrl ?? this.imageUrl);
  }
}
