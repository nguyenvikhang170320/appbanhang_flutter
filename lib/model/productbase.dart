class ProductBase {
  final String idProduct;
  final String name;
  final double price;
  final String image;
  final String category;
  final String description;
  final String size;
  final String color;
  int quantity;

  ProductBase(
      {required this.idProduct,
      required this.name,
      required this.price,
      required this.image,
      required this.category,
      required this.description,
      required this.size,
      required this.color,
      required this.quantity});
}

class Products extends ProductBase {

  Products({
    required super.idProduct,
    required super.name,
    required super.category,
    required super.price,
    required super.image,
    required super.description,
    required super.size,
    required super.color,
    required super.quantity,
  });
}

class ProductDetail extends ProductBase {
  final List<ProductBase> detail;

  ProductDetail({
    required super.idProduct,
    required super.name,
    required super.category,
    required super.price,
    required super.image,
    required super.description,
    required super.size,
    required super.color,
    required super.quantity,
    required this.detail,
  });
}
