import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/room_provider.dart';
import '../widgets/add_furniture_dialog.dart';
import '../widgets/empty_furniture_state.dart';
import '../widgets/furniture_list_item.dart';
import '../widgets/room_header.dart';

class DetailsScreen extends StatelessWidget {
  final String roomId;

  const DetailsScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return Consumer<RoomProvider>(
      builder: (context, provider, child) {
        final room = provider.getRoomById(roomId);

        return Scaffold(
          appBar: AppBar(
            title: Text(room.title),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              IconButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    Provider.of<RoomProvider>(
                      context,
                      listen: false,
                    ).updateRoomImage(roomId, image.path);
                  }
                },
                icon: const Icon(Icons.add_photo_alternate),
                tooltip: 'Change room image',
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoomHeader(room: room),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.view_in_ar),
                    label: const Text('Generate room view'),
                  ),
                ),
              ),
              Expanded(
                child: room.furniture.isEmpty
                    ? const EmptyFurnitureState()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
                        itemCount: room.furniture.length,
                        itemBuilder: (context, index) {
                          final item = room.furniture[index];
                          return FurnitureListItem(
                            item: item,
                            onDismissed: (_) {
                              provider.removeFurniture(
                                roomId: roomId,
                                furnitureId: item.id,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${item.name} removed'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            onToggleBought: () {
                              provider.toggleFurnitureBought(
                                roomId: roomId,
                                furnitureId: item.id,
                              );
                            },
                            onEdit: () {
                              AddFurnitureDialog.show(
                                context,
                                roomId: roomId,
                                item: item,
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => AddFurnitureDialog.show(
              context,
              roomId: roomId,
            ),
            tooltip: 'Add Furniture',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
