import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/room_provider.dart';
import 'catalog_list_screen.dart';
import 'my_rooms_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  void _showAddRoomDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    XFile? pickedImage;
    bool isValid = false;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add New Room'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter room name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isValid = value.trim().isNotEmpty;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery,
                        );
                        setState(() {
                          pickedImage = image;
                        });
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: pickedImage == null
                            ? const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo, color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text('Add a photo (optional)'),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: _buildRoomImage(
                                  pickedImage!.path,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isValid
                      ? () {
                          final roomProvider = Provider.of<RoomProvider>(
                            dialogContext,
                            listen: false,
                          );
                          roomProvider.addRoom(
                            controller.text.trim(),
                            imagePath: pickedImage?.path,
                          );
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(dialogContext).showSnackBar(
                            const SnackBar(
                              content: Text('Room added!'),
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('AI Interior Decorator'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'My Rooms', icon: Icon(Icons.home)),
              Tab(text: 'Catalogs', icon: Icon(Icons.collections)),
            ],
          ),
        ),
        body: const TabBarView(children: [MyRoomsView(), CatalogListScreen()]),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showAddRoomDialog(context),
          tooltip: 'Add Room',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
