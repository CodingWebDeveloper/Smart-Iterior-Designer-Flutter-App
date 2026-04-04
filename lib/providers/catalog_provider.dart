import 'package:flutter/foundation.dart';
import '../models/room_project.dart';

class CatalogProvider with ChangeNotifier {
  final List<FurnitureCatalog> _catalogs = [
    FurnitureCatalog(
      id: 'modern_living',
      name: 'Modern Living Room',
      description: 'Sleek and contemporary furniture for a modern living space',
      imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800',
      items: [
        FurnitureItem(
          id: 'ml_sofa_1',
          name: 'Minimalist Sectional Sofa',
          store: 'IKEA',
          price: '\$899',
          imageUrl: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
        ),
        FurnitureItem(
          id: 'ml_table_1',
          name: 'Glass Coffee Table',
          store: 'West Elm',
          price: '\$349',
          imageUrl: 'https://images.unsplash.com/photo-1532372320572-cda25653a26d?w=400',
        ),
        FurnitureItem(
          id: 'ml_chair_1',
          name: 'Modern Accent Chair',
          store: 'CB2',
          price: '\$499',
          imageUrl: 'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?w=400',
        ),
        FurnitureItem(
          id: 'ml_shelf_1',
          name: 'Floating Wall Shelf',
          store: 'IKEA',
          price: '\$79',
          imageUrl: 'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=400',
        ),
        FurnitureItem(
          id: 'ml_lamp_1',
          name: 'Arc Floor Lamp',
          store: 'Target',
          price: '\$129',
          imageUrl: 'https://images.unsplash.com/photo-1507473885765-e6ed057f782c?w=400',
        ),
      ],
    ),
    FurnitureCatalog(
      id: 'cozy_bedroom',
      name: 'Cozy Bedroom',
      description: 'Warm and inviting furniture for a comfortable bedroom retreat',
      imageUrl: 'https://images.unsplash.com/photo-1616594039964-ae9021a400a0?w=800',
      items: [
        FurnitureItem(
          id: 'cb_bed_1',
          name: 'Upholstered Platform Bed',
          store: 'Wayfair',
          price: '\$699',
          imageUrl: 'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?w=400',
        ),
        FurnitureItem(
          id: 'cb_nightstand_1',
          name: 'Wooden Nightstand',
          store: 'IKEA',
          price: '\$149',
          imageUrl: 'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=400',
        ),
        FurnitureItem(
          id: 'cb_dresser_1',
          name: 'Mid-Century Dresser',
          store: 'West Elm',
          price: '\$799',
          imageUrl: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400',
        ),
        FurnitureItem(
          id: 'cb_mirror_1',
          name: 'Round Wall Mirror',
          store: 'Target',
          price: '\$89',
          imageUrl: 'https://images.unsplash.com/photo-1618220179428-22790b461013?w=400',
        ),
        FurnitureItem(
          id: 'cb_rug_1',
          name: 'Soft Area Rug',
          store: 'HomeGoods',
          price: '\$199',
          imageUrl: 'https://images.unsplash.com/photo-1600166898405-da9535204843?w=400',
        ),
      ],
    ),
    FurnitureCatalog(
      id: 'scandinavian_dining',
      name: 'Scandinavian Dining',
      description: 'Clean lines and natural materials for a Nordic-inspired dining area',
      imageUrl: 'https://images.unsplash.com/photo-1617806118233-18e1de247200?w=800',
      items: [
        FurnitureItem(
          id: 'sd_table_1',
          name: 'Oak Dining Table',
          store: 'IKEA',
          price: '\$599',
          imageUrl: 'https://images.unsplash.com/photo-1615066390971-03e4e1c36ddf?w=400',
        ),
        FurnitureItem(
          id: 'sd_chair_1',
          name: 'Wishbone Dining Chair (Set of 4)',
          store: 'Article',
          price: '\$899',
          imageUrl: 'https://images.unsplash.com/photo-1503602642458-232111445657?w=400',
        ),
        FurnitureItem(
          id: 'sd_sideboard_1',
          name: 'Scandinavian Sideboard',
          store: 'West Elm',
          price: '\$1,299',
          imageUrl: 'https://images.unsplash.com/photo-1565538810643-b5bdb714032a?w=400',
        ),
        FurnitureItem(
          id: 'sd_pendant_1',
          name: 'Pendant Light Fixture',
          store: 'CB2',
          price: '\$249',
          imageUrl: 'https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=400',
        ),
      ],
    ),
    FurnitureCatalog(
      id: 'home_office',
      name: 'Productive Home Office',
      description: 'Functional and stylish furniture for an efficient workspace',
      imageUrl: 'https://images.unsplash.com/photo-1484154218962-a197022b5858?w=800',
      items: [
        FurnitureItem(
          id: 'ho_desk_1',
          name: 'Standing Desk',
          store: 'IKEA',
          price: '\$499',
          imageUrl: 'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=400',
        ),
        FurnitureItem(
          id: 'ho_chair_1',
          name: 'Ergonomic Office Chair',
          store: 'Staples',
          price: '\$349',
          imageUrl: 'https://images.unsplash.com/photo-1580480055273-228ff5388ef8?w=400',
        ),
        FurnitureItem(
          id: 'ho_bookshelf_1',
          name: 'Tall Bookshelf',
          store: 'IKEA',
          price: '\$179',
          imageUrl: 'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=400',
        ),
        FurnitureItem(
          id: 'ho_lamp_1',
          name: 'LED Desk Lamp',
          store: 'Amazon',
          price: '\$59',
          imageUrl: 'https://images.unsplash.com/photo-1565118531796-763e5082d113?w=400',
        ),
        FurnitureItem(
          id: 'ho_storage_1',
          name: 'Filing Cabinet',
          store: 'Staples',
          price: '\$199',
          imageUrl: 'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=400',
        ),
      ],
    ),
    FurnitureCatalog(
      id: 'industrial_loft',
      name: 'Industrial Loft',
      description: 'Raw materials and exposed elements for an urban industrial look',
      imageUrl: 'https://images.unsplash.com/photo-1556912173-46c336c7fd55?w=800',
      items: [
        FurnitureItem(
          id: 'il_sofa_1',
          name: 'Leather Sofa',
          store: 'Restoration Hardware',
          price: '\$2,499',
          imageUrl: 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?w=400',
        ),
        FurnitureItem(
          id: 'il_table_1',
          name: 'Metal & Wood Coffee Table',
          store: 'West Elm',
          price: '\$449',
          imageUrl: 'https://images.unsplash.com/photo-1532372320572-cda25653a26d?w=400',
        ),
        FurnitureItem(
          id: 'il_shelf_1',
          name: 'Industrial Pipe Shelving',
          store: 'Etsy',
          price: '\$299',
          imageUrl: 'https://images.unsplash.com/photo-1594620302200-9a762244a156?w=400',
        ),
        FurnitureItem(
          id: 'il_light_1',
          name: 'Edison Bulb Chandelier',
          store: 'CB2',
          price: '\$399',
          imageUrl: 'https://images.unsplash.com/photo-1513506003901-1e6a229e2d15?w=400',
        ),
      ],
    ),
  ];

  List<FurnitureCatalog> get catalogs => _catalogs;

  FurnitureCatalog getCatalogById(String id) {
    return _catalogs.firstWhere((catalog) => catalog.id == id);
  }
}
