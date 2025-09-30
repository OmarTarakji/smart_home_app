import 'package:flutter/material.dart';
import '../widgets/room_screen/room_components.dart';
import '../widgets/room_screen/room_header.dart';
import '../widgets/room_screen/room_image.dart';

class RoomScreen extends StatelessWidget {
  final int roomId;

  const RoomScreen({required this.roomId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
            child: Column(
              spacing: 20,
              children: [
                RoomImage(roomId: roomId),
                RoomHeader(roomId: roomId),
                RoomComponents(roomId: roomId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
