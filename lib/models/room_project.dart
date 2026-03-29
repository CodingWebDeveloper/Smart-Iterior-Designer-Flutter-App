class RoomProject {
  final String id;
  String title;
  bool isFurnished;
  final List<FurnitureItem> furniture;

  RoomProject({
    required this.id,
    required this.title,
    this.isFurnished = false,
    List<FurnitureItem>? furniture,
  }) : furniture = furniture ?? [];
}

class FurnitureItem {
  final String id;
  final String name;
  final String store;
  final String price;

  FurnitureItem({
    required this.id,
    required this.name,
    required this.store,
    required this.price,
  });
}
