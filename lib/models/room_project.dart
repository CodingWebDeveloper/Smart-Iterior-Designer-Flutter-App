class RoomProject {
  final String id;
  String title;
  String? roomImagePath;
  bool isFurnished;
  final List<FurnitureItem> furniture;

  RoomProject({
    required this.id,
    required this.title,
    this.roomImagePath,
    this.isFurnished = false,
    List<FurnitureItem>? furniture,
  }) : furniture = furniture ?? [];
}

class FurnitureItem {
  final String id;
  final String name;
  final String store;
  final String price;
  final String? imageUrl;
  final bool? _isBought;

  bool get isBought => _isBought ?? false;

  FurnitureItem({
    required this.id,
    required this.name,
    required this.store,
    required this.price,
    this.imageUrl,
    bool? isBought,
  }) : _isBought = isBought;

  FurnitureItem copyWith({
    String? id,
    String? name,
    String? store,
    String? price,
    String? imageUrl,
    bool? isBought,
  }) {
    return FurnitureItem(
      id: id ?? this.id,
      name: name ?? this.name,
      store: store ?? this.store,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isBought: isBought ?? this.isBought,
    );
  }
}

class FurnitureCatalog {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final List<FurnitureItem> items;

  FurnitureCatalog({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.items,
  });
}
