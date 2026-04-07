import 'package:flutter/foundation.dart';
import '../models/room_project.dart';

class RoomProvider with ChangeNotifier {
  final List<RoomProject> _rooms = [];
  bool _showOnlyPlanning = false;

  List<RoomProject> get rooms => _rooms;

  bool get showOnlyPlanning => _showOnlyPlanning;

  List<RoomProject> get filteredRooms {
    if (_showOnlyPlanning) {
      return _rooms.where((room) => !room.isFurnished).toList();
    }
    return _rooms;
  }

  RoomProject getRoomById(String id) {
    return _rooms.firstWhere((room) => room.id == id);
  }

  void addRoom(String title, {String? imagePath}) {
    final newRoom = RoomProject(
      id: DateTime.now().toString(),
      title: title,
      roomImagePath: imagePath,
      furniture: [],
    );
    _rooms.add(newRoom);
    notifyListeners();
  }

  void updateRoomImage(String roomId, String imagePath) {
    final room = getRoomById(roomId);
    room.roomImagePath = imagePath;
    notifyListeners();
  }

  void updateRoom(String roomId, {String? title, String? imagePath, bool clearImage = false}) {
    final room = getRoomById(roomId);
    if (title != null) {
      room.title = title;
    }
    if (clearImage) {
      room.roomImagePath = null;
    } else if (imagePath != null) {
      room.roomImagePath = imagePath;
    }
    notifyListeners();
  }

  void deleteRoom(String id) {
    _rooms.removeWhere((room) => room.id == id);
    notifyListeners();
  }

  void toggleFurnishedStatus(String id) {
    final room = getRoomById(id);
    room.isFurnished = !room.isFurnished;
    notifyListeners();
  }

  void addFurniture({
    required String roomId,
    required String name,
    required String store,
    required String price,
    String? imageUrl,
  }) {
    final room = getRoomById(roomId);
    room.furniture.add(
      FurnitureItem(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        store: store,
        price: price,
        imageUrl: imageUrl,
      ),
    );
    notifyListeners();
  }

  void updateFurniture({
    required String roomId,
    required String furnitureId,
    required String name,
    required String store,
    required String price,
    String? imageUrl,
  }) {
    final room = getRoomById(roomId);
    final index = room.furniture.indexWhere((item) => item.id == furnitureId);
    if (index == -1) {
      return;
    }

    final current = room.furniture[index];
    room.furniture[index] = current.copyWith(
      name: name,
      store: store,
      price: price,
      imageUrl: imageUrl,
    );
    notifyListeners();
  }

  void removeFurniture({required String roomId, required String furnitureId}) {
    final room = getRoomById(roomId);
    room.furniture.removeWhere((item) => item.id == furnitureId);
    notifyListeners();
  }

  void toggleFurnitureBought({
    required String roomId,
    required String furnitureId,
  }) {
    final room = getRoomById(roomId);
    final index = room.furniture.indexWhere((item) => item.id == furnitureId);
    if (index == -1) {
      return;
    }

    final current = room.furniture[index];
    room.furniture[index] = current.copyWith(isBought: !current.isBought);
    notifyListeners();
  }

  void toggleFilter() {
    _showOnlyPlanning = !_showOnlyPlanning;
    notifyListeners();
  }
}
