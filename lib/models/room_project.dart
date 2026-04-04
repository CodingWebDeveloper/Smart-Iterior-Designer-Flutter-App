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

  FurnitureItem({
    required this.id,
    required this.name,
    required this.store,
    required this.price,
    this.imageUrl,
  });
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
