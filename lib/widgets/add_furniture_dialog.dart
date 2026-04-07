import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/room_project.dart';
import '../providers/room_provider.dart';

class AddFurnitureDialog extends StatefulWidget {
  final String roomId;
  final FurnitureItem? item;

  const AddFurnitureDialog({
    super.key,
    required this.roomId,
    this.item,
  });

  static Future<void> show(
    BuildContext context, {
    required String roomId,
    FurnitureItem? item,
  }) {
    return showDialog(
      context: context,
      builder: (_) => AddFurnitureDialog(roomId: roomId, item: item),
    );
  }

  @override
  State<AddFurnitureDialog> createState() => _AddFurnitureDialogState();
}

class _AddFurnitureDialogState extends State<AddFurnitureDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _storeController;
  late final TextEditingController _priceController;
  bool _isValid = false;

  bool get _isEditMode => widget.item != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item?.name ?? '');
    _storeController = TextEditingController(text: widget.item?.store ?? '');
    _priceController = TextEditingController(text: widget.item?.price ?? '');
    _validate();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _storeController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _validate() {
    setState(() {
      _isValid = _nameController.text.trim().isNotEmpty &&
          _storeController.text.trim().isNotEmpty &&
          _priceController.text.trim().isNotEmpty;
    });
  }

  void _saveFurniture() {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final provider = Provider.of<RoomProvider>(context, listen: false);

    if (_isEditMode) {
      provider.updateFurniture(
        roomId: widget.roomId,
        furnitureId: widget.item!.id,
        name: _nameController.text.trim(),
        store: _storeController.text.trim(),
        price: _priceController.text.trim(),
        imageUrl: widget.item!.imageUrl,
      );
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Furniture updated!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      provider.addFurniture(
        roomId: widget.roomId,
        name: _nameController.text.trim(),
        store: _storeController.text.trim(),
        price: _priceController.text.trim(),
      );
      navigator.pop();
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Furniture added!'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditMode ? 'Edit Furniture' : 'Add Furniture'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _validate(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _storeController,
              decoration: const InputDecoration(
                labelText: 'Store',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _validate(),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Price (e.g. \$299)',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _validate(),
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
          onPressed: _isValid ? _saveFurniture : null,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
