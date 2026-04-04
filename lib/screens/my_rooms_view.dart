import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/room_provider.dart';
import 'details_screen.dart';

class MyRoomsView extends StatelessWidget {
  const MyRoomsView({super.key});

  Widget _buildRoomImage(String path, {double? width, double? height, BoxFit fit = BoxFit.cover}) {
    if (kIsWeb) {
      return Image.network(path, width: width, height: height, fit: fit, errorBuilder: (context, error, stackTrace) => const Icon(Icons.error));
    }
    return Image.file(File(path), width: width, height: height, fit: fit);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(
      builder: (context, provider, child) {
        final rooms = provider.filteredRooms;

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Show only planning', style: TextStyle(color: Colors.grey[700])),
                  Switch(
                    value: provider.showOnlyPlanning,
                    onChanged: (value) {
                      provider.toggleFilter();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: rooms.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home_outlined, size: 80, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            provider.showOnlyPlanning ? 'No rooms in planning' : 'No rooms yet',
                            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap + to add a new room',
                            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        final room = rooms[index];
                        return Dismissible(
                          key: Key(room.id),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            child: const Icon(Icons.delete, color: Colors.white),
                          ),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            provider.deleteRoom(room.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${room.title} deleted'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(roomId: room.id),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    room.roomImagePath != null
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: _buildRoomImage(room.roomImagePath!, width: 60, height: 60),
                                          )
                                        : AnimatedSwitcher(
                                            duration: const Duration(milliseconds: 300),
                                            child: Icon(
                                              room.isFurnished ? Icons.weekend : Icons.format_paint,
                                              key: ValueKey(room.isFurnished),
                                              color: room.isFurnished ? Colors.green : Colors.red,
                                              size: 40,
                                            ),
                                          ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(room.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 4),
                                          Text(
                                            room.isFurnished ? 'Furnished' : 'Planning',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: room.isFurnished ? Colors.green[700] : Colors.red[700],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(room.isFurnished ? Icons.check_circle : Icons.radio_button_unchecked, color: room.isFurnished ? Colors.green : Colors.grey),
                                      onPressed: () {
                                        provider.toggleFurnishedStatus(room.id);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    );
  }
}
