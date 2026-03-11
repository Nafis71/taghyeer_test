import 'package:taghyeer_test/domain/entities/product_entity_e.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    super.availabilityStatus,
    super.brand,
    super.category,
    super.description,
    super.discountPercentage,
    super.id,
    super.images,
    super.minimumOrderQuantity,
    super.price,
    super.rating,
    super.returnPolicy,
    super.shippingInformation,
    super.sku,
    super.stock,
    super.tags,
    super.thumbnail,
    super.title,
    super.warrantyInformation,
    super.weight,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    availabilityStatus: json["availabilityStatus"],
    brand: json["brand"],
    category: json["category"],
    description: json["description"],
    discountPercentage: json["discountPercentage"],
    id: json["id"],
    images: List<String>.from(json["images"].map((x) => x)),
    minimumOrderQuantity: json["minimumOrderQuantity"],
    price: json["price"],
    rating: json["rating"],
    returnPolicy: json["returnPolicy"],
    shippingInformation: json["shippingInformation"],
    sku: json["sku"],
    stock: json["stock"],
    tags: List<String>.from(json["tags"].map((x) => x)),
    thumbnail: json["thumbnail"],
    title: json["title"],
    warrantyInformation: json["warrantyInformation"],
    weight: json["weight"],
  );
}
