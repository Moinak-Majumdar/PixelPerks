import 'package:pixelperks/controller/preview_controller.dart';

class CategoryItem {
  const CategoryItem({
    required this.isSafe,
    required this.category,
    required this.endpoint,
    required this.title,
  });

  final String title, category;
  final Endpoint endpoint;
  final bool isSafe;
}

const List<CategoryItem> categoryItems = [
  CategoryItem(
    isSafe: true,
    category: '4k',
    endpoint: Endpoint.uhd,
    title: '4k',
  ),
  CategoryItem(
    isSafe: true,
    category: 'architecture',
    endpoint: Endpoint.architecture,
    title: 'Architecture',
  ),
  CategoryItem(
    isSafe: true,
    category: 'dark',
    endpoint: Endpoint.dark,
    title: 'Dark',
  ),
  CategoryItem(
    isSafe: false,
    category: 'naked nude',
    endpoint: Endpoint.erotic,
    title: 'Erotic',
  ),
  CategoryItem(
    isSafe: true,
    category: 'fantasy landscape',
    endpoint: Endpoint.fantasy,
    title: 'Fantasy',
  ),
  CategoryItem(
    isSafe: true,
    category: 'fields',
    endpoint: Endpoint.fields,
    title: 'Fields',
  ),
  CategoryItem(
    isSafe: true,
    category: 'flowers',
    endpoint: Endpoint.flowers,
    title: 'Flowers',
  ),
  CategoryItem(
    isSafe: true,
    category: 'food',
    endpoint: Endpoint.food,
    title: 'Foods',
  ),
  CategoryItem(
    isSafe: true,
    category: 'forest',
    endpoint: Endpoint.forest,
    title: 'Forest',
  ),
  CategoryItem(
    isSafe: true,
    category: 'milky way',
    endpoint: Endpoint.galaxy,
    title: 'Galaxy',
  ),
  CategoryItem(
    isSafe: true,
    category: 'hiking',
    endpoint: Endpoint.uhd,
    title: 'Hiking',
  ),
  CategoryItem(
    isSafe: false,
    category: 'lingerie',
    endpoint: Endpoint.lingerie,
    title: 'Lingerie',
  ),
  CategoryItem(
    isSafe: true,
    category: 'love couple',
    endpoint: Endpoint.love,
    title: 'Love',
  ),
  CategoryItem(
    isSafe: false,
    category: 'monochrome',
    endpoint: Endpoint.monochrome,
    title: 'Monochrome',
  ),
  CategoryItem(
    isSafe: true,
    category: 'mountains',
    endpoint: Endpoint.mountains,
    title: 'Mountains',
  ),
  CategoryItem(
    isSafe: true,
    category: 'landscape',
    endpoint: Endpoint.nature,
    title: 'Nature',
  ),
  CategoryItem(
    isSafe: true,
    category: 'ocean waves',
    endpoint: Endpoint.ocean,
    title: 'Ocean',
  ),
  CategoryItem(
    category: 'pets',
    isSafe: true,
    endpoint: Endpoint.animal,
    title: 'Pets',
  ),
  CategoryItem(
    isSafe: true,
    category: 'photography',
    endpoint: Endpoint.photography,
    title: 'Portrait',
  ),
  CategoryItem(
    isSafe: true,
    category: 'rain',
    endpoint: Endpoint.rain,
    title: 'Rain',
  ),
  CategoryItem(
    isSafe: true,
    category: 'river',
    endpoint: Endpoint.river,
    title: 'River',
  ),
  CategoryItem(
    isSafe: true,
    category: 'street',
    endpoint: Endpoint.street,
    title: 'Street',
  ),
  CategoryItem(
    isSafe: false,
    category: 'Topless',
    endpoint: Endpoint.topless,
    title: 'Topless',
  ),
  CategoryItem(
    isSafe: true,
    category: 'village',
    endpoint: Endpoint.village,
    title: 'Village',
  ),
];

final safeCategoryItem =
    categoryItems.where((element) => element.isSafe == true).toList();
