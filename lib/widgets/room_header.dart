import 'package:flutter/material.dart';

import '../models/room_project.dart';
import 'room_image.dart';

class RoomHeader extends StatelessWidget {
  final RoomProject room;

  const RoomHeader({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    if (room.roomImagePath != null) {
      return RoomImage(
        path: room.roomImagePath!,
        height: 250,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }

    final isFurnished = room.isFurnished;
    final theme = Theme.of(context);
    final statusColor = isFurnished ? Colors.green : Colors.red;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isFurnished ? Colors.green.withAlpha(26) : Colors.red.withAlpha(26),
        border: Border(
          bottom: BorderSide(
            color: statusColor,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            isFurnished ? Icons.weekend : Icons.format_paint,
            color: statusColor,
            size: 40,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                room.title,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                isFurnished ? 'Status: Furnished' : 'Status: Planning',
                style: TextStyle(
                  fontSize: 16,
                  color: isFurnished ? Colors.green[700] : Colors.red[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
