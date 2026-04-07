import 'package:flutter/material.dart';

import '../models/room_project.dart';

class FurnitureListItem extends StatelessWidget {
  final FurnitureItem item;
  final DismissDirectionCallback onDismissed;
  final VoidCallback onToggleBought;
  final VoidCallback onEdit;

  const FurnitureListItem({
    super.key,
    required this.item,
    required this.onDismissed,
    required this.onToggleBought,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBought = item.isBought;

    final titleStyle = TextStyle(
      fontWeight: FontWeight.bold,
      decoration: isBought ? TextDecoration.lineThrough : null,
      color: isBought
          ? theme.colorScheme.onSurface.withOpacity(0.6)
          : theme.colorScheme.onSurface,
    );

    final subtitleStyle = TextStyle(
      color: isBought
          ? theme.colorScheme.onSurfaceVariant.withOpacity(0.7)
          : theme.colorScheme.onSurfaceVariant,
    );

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
      onDismissed: onDismissed,
      child: Card(
        elevation: isBought ? 0 : 1,
        color: isBought
            ? theme.colorScheme.surfaceVariant.withOpacity(0.4)
            : null,
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          onTap: onEdit,
          leading: _buildLeading(theme, isBought),
          title: Text(item.name, style: titleStyle),
          subtitle: Text(item.store, style: subtitleStyle),
          trailing: _buildTrailing(theme),
        ),
      ),
    );
  }

  Widget _buildLeading(ThemeData theme, bool isBought) {
    if (item.imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(isBought ? 0.2 : 0),
            BlendMode.darken,
          ),
          child: Image.network(
            item.imageUrl!,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => _fallbackAvatar(theme),
          ),
        ),
      );
    }
    return _fallbackAvatar(theme);
  }

  Widget _buildTrailing(ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _priceChip(theme),
        const SizedBox(width: 8), 
        IconButton(
          onPressed: onToggleBought,
          tooltip: item.isBought ? 'Mark as pending' : 'Mark as bought',
          visualDensity: VisualDensity.compact,
          constraints: const BoxConstraints(minHeight: 36, minWidth: 36),
          icon: Icon(
            item.isBought ? Icons.check_circle : Icons.radio_button_unchecked,
            color: item.isBought
                ? theme.colorScheme.primary
                : theme.colorScheme.outline,
          ),
        ),
      ],
    );
  }

  Widget _priceChip(ThemeData theme) {
    final isBought = item.isBought;
    final Color borderColor =
        isBought ? theme.colorScheme.outlineVariant : Colors.green;
    final Color textColor = isBought
        ? theme.colorScheme.onSurfaceVariant
        : Colors.green[700]!;
    final Color backgroundColor =
        isBought ? theme.colorScheme.surface : Colors.green[50]!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        item.price,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _fallbackAvatar(ThemeData theme) {
    return CircleAvatar(
      backgroundColor: theme.colorScheme.primaryContainer,
      child: Icon(
        Icons.shopping_bag,
        color: theme.colorScheme.primary,
      ),
    );
  }
}
