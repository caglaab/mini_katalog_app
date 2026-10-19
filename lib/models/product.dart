/// Ürün veri modeli.
/// products.json içindeki her bir ürün bu sınıfa dönüştürülür.
class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String price; // Örn: "$2,499"
  final String currency;
  final String image; // http(s) ile başlıyorsa internetten, değilse asset olarak yüklenir
  final Map<String, String> specs;

  const Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    required this.specs,
  });

  /// JSON (Map) -> Product
  factory Product.fromJson(Map<String, dynamic> json) {
    final rawSpecs = (json['specs'] as Map<String, dynamic>?) ?? <String, dynamic>{};

    return Product(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: json['price'] as String? ?? '\$0',
      currency: json['currency'] as String? ?? 'USD',
      image: json['image'] as String? ?? '',
      specs: rawSpecs.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  /// Product -> JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'tagline': tagline,
      'description': description,
      'price': price,
      'currency': currency,
      'image': image,
      'specs': specs,
    };
  }

  /// "$2,499" gibi bir yazıyı 2499.0 sayısına çevirir (toplam hesabı için).
  double get priceValue {
    final cleaned = price.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned) ?? 0;
  }
}
