import 'package:supabase_flutter/supabase_flutter.dart';

import '../domain/room.dart';

class RoomsRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<Map<int, Room>> getUserRooms() async {
    final PostgrestList response = await _supabase
        .from('rooms')
        .select('''room_id, name, image_url''')
        .order('created_at', ascending: true);
    final Map<int, Room> rooms = {};
    for (final json in response) {
      rooms[json['room_id']] = Room.fromJson(json);
    }
    return rooms;
  }

  Future<void> deleteRoom(int id) async {
    await _supabase.from('rooms').delete().eq('room_id', id);
  }

  Future<int> addRoom(Room room) async {
    final userId = _supabase.auth.currentUser!.id;
    final response =
        await _supabase
            .from('rooms')
            .insert({...room.toJson, 'owner_id': userId})
            .select('''room_id''')
            .single();
    return response['room_id'];
  }

  Future<void> renameRoom(int roomId, String newName) async {
    await _supabase
        .from('rooms')
        .update({'name': newName})
        .eq('room_id', roomId);
  }

  Future<void> addComponentToRoom(int comId, int? roomId) async {
    await _supabase
        .from('device_components')
        .update({'room_id': roomId})
        .eq('id', comId)
        .select();
    //TODO: Proper error handling
  }
}
