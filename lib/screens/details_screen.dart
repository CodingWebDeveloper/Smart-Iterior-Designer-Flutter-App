import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/room_provider.dart';

class DetailsScreen extends StatelessWidget {
  final String roomId;

  const DetailsScreen({super.key, required this.roomId});

  Widget _buildRoomImage(
    String path, {
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
  }) {
    if (kIsWeb) {
      return Image.network(
        path,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    }
    return Image.file(File(path), width: width, height: height, fit: fit);
  }

  void _showAddFurnitureDialog(BuildContext context) {
    final nameController = TextEditingController();
    final storeController = TextEditingController();
    final priceController = TextEditingController();

    bool isValid = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            void validate() {
              final name = nameController.text.trim();
              final store = storeController.text.trim();
              final price = priceController.text.trim();
              setState(() {
                isValid =
                    name.isNotEmpty && store.isNotEmpty && price.isNotEmpty;
              });
            }

            return AlertDialog(
              title: const Text('Add Furniture'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => validate(),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: storeController,
                      decoration: const InputDecoration(
                        labelText: 'Store',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => validate(),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price (e.g. \$299)',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => validate(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isValid
                      ? () {
                          Provider.of<RoomProvider>(
                            dialogContext,
                            listen: false,
                          ).addFurniture(
                            roomId: roomId,
                            name: nameController.text.trim(),
                            store: storeController.text.trim(),
                            price: priceController.text.trim(),
                          );
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(dialogContext).showSnackBar(
                            const SnackBar(
                              content: Text('Furniture added!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      : null,
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

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
              IconButton(
                onPressed: () => _showAddFurnitureDialog(context),
                icon: const Icon(Icons.add),
                tooltip: 'Add furniture',
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              room.roomImagePath != null
                  ? _buildRoomImage(
                      room.roomImagePath!,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: room.isFurnished
                            ? Colors.green.withAlpha(26)
                            : Colors.red.withAlpha(26),
                        border: Border(
                          bottom: BorderSide(
                            color: room.isFurnished ? Colors.green : Colors.red,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            room.isFurnished
                                ? Icons.weekend
                                : Icons.format_paint,
                            color: room.isFurnished ? Colors.green : Colors.red,
                            size: 40,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                room.title,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                room.isFurnished
                                    ? 'Status: Furnished'
                                    : 'Status: Planning',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: room.isFurnished
                                      ? Colors.green[700]
                                      : Colors.red[700],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              Expanded(
                child: room.furniture.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.chair_outlined,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No furniture yet',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tap + to add furniture',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: room.furniture.length,
                        itemBuilder: (context, index) {
                          final item = room.furniture[index];
                          return Dismissible(
                            key: Key(item.id),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            direction: DismissDirection.endToStart,
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
                            child: Card(
                              elevation: 1,
                              margin: const EdgeInsets.only(bottom: 8),
                              child: ListTile(
                                leading: item.imageUrl != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          item.imageUrl!,
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return CircleAvatar(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer,
                                                  child: Icon(
                                                    Icons.shopping_bag,
                                                    color: Theme.of(
                                                      context,
                                                    ).colorScheme.primary,
                                                  ),
                                                );
                                              },
                                        ),
                                      )
                                    : CircleAvatar(
                                        backgroundColor: Theme.of(
                                          context,
                                        ).colorScheme.primaryContainer,
                                        child: Icon(
                                          Icons.shopping_bag,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                        ),
                                      ),
                                title: Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(item.store),
                                trailing: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green[50],
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.green),
                                  ),
                                  child: Text(
                                    item.price,
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showAddFurnitureDialog(context),
            tooltip: 'Add Furniture',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
