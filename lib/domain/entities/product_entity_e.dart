/// Represents a product entity in the domain layer.
///
/// This class encapsulates all product-related data and business logic.
/// It serves as the core business entity for products, independent of
/// any external data sources or frameworks.
///
/// All properties are nullable to handle cases where API responses
/// may not include all fields.
///
/// Example:
/// ```dart
/// final product = ProductEntity(
///   id: 1,
///   title: "Sample Product",
///   price: 99.99,
///   stock: 50,
/// );
/// ```
class ProductEntity {
  /// Unique identifier for the product.
  int? id;

  /// Product title or name.
  String? title;

  /// Detailed product description.
  String? description;

  /// Product category classification.
  String? category;

  /// Product price in the base currency.
  double? price;

  /// Discount percentage applied to the product (0-100).
  double? discountPercentage;

  /// Average customer rating (typically 0-5).
  double? rating;

  /// Current stock quantity available.
  int? stock;

  /// List of tags associated with the product.
  List<String>? tags;

  /// Product brand name.
  String? brand;

  /// Stock Keeping Unit identifier.
  String? sku;

  /// Product weight in grams.
  int? weight;

  /// Warranty information details.
  String? warrantyInformation;

  /// Shipping information and policies.
  String? shippingInformation;

  /// Current availability status (e.g., "in stock", "out of stock").
  String? availabilityStatus;

  /// Return policy information.
  String? returnPolicy;

  /// Minimum order quantity required.
  int? minimumOrderQuantity;

  /// List of product image URLs.
  List<String>? images;

  /// Thumbnail image URL for quick preview.
  String? thumbnail;

  /// Creates a new [ProductEntity] instance.
  ///
  /// All parameters are optional and nullable.
  ///
  /// Parameters:
  /// - [id]: Unique product identifier
  /// - [title]: Product title
  /// - [description]: Product description
  /// - [category]: Product category
  /// - [price]: Product price
  /// - [discountPercentage]: Discount percentage
  /// - [rating]: Product rating
  /// - [stock]: Stock quantity
  /// - [tags]: Product tags
  /// - [brand]: Brand name
  /// - [sku]: SKU identifier
  /// - [weight]: Product weight
  /// - [warrantyInformation]: Warranty details
  /// - [shippingInformation]: Shipping details
  /// - [availabilityStatus]: Availability status
  /// - [returnPolicy]: Return policy
  /// - [minimumOrderQuantity]: Minimum order quantity
  /// - [images]: List of image URLs
  /// - [thumbnail]: Thumbnail URL
  ProductEntity({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.images,
    this.thumbnail,
  });

  /// Creates a [ProductEntity] instance from a JSON map.
  ///
  /// Parses JSON data received from API responses into a [ProductEntity] object.
  /// Handles type conversions and null values gracefully.
  ///
  /// Parameters:
  /// - [json]: Map containing product data in JSON format
  ///
  /// Example:
  /// ```dart
  /// final product = ProductEntity.fromJson({
  ///   'id': 1,
  ///   'title': 'Product Name',
  ///   'price': 99.99,
  /// });
  /// ```
  ProductEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = json['price'];
    discountPercentage = double.parse(json['discountPercentage'].toString());
    rating = json['rating'];
    stock = json['stock'];
    tags = json['tags'].cast<String>();
    brand = json['brand'];
    sku = json['sku'];
    weight = json['weight'];
    warrantyInformation = json['warrantyInformation'];
    shippingInformation = json['shippingInformation'];
    availabilityStatus = json['availabilityStatus'];
    returnPolicy = json['returnPolicy'];
    minimumOrderQuantity = json['minimumOrderQuantity'];
    images = json['images'].cast<String>();
    thumbnail = json['thumbnail'];
  }

  /// Converts the [ProductEntity] instance to a JSON map.
  ///
  /// Serializes the product data into a format suitable for API requests
  /// or local storage.
  ///
  /// Returns a [Map<String, dynamic>] containing all non-null product properties.
  ///
  /// Example:
  /// ```dart
  /// final json = product.toJson();
  /// // Returns: {'id': 1, 'title': 'Product Name', ...}
  /// ```
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['category'] = category;
    data['price'] = price;
    data['discountPercentage'] = discountPercentage;
    data['rating'] = rating;
    data['stock'] = stock;
    data['tags'] = tags;
    data['brand'] = brand;
    data['sku'] = sku;
    data['weight'] = weight;
    data['warrantyInformation'] = warrantyInformation;
    data['shippingInformation'] = shippingInformation;
    data['availabilityStatus'] = availabilityStatus;
    data['returnPolicy'] = returnPolicy;
    data['minimumOrderQuantity'] = minimumOrderQuantity;
    data['images'] = images;
    data['thumbnail'] = thumbnail;
    return data;
  }

  @override
  String toString() {
    return 'ProductEntity{id: $id, title: $title, description: $description, category: $category, price: $price, discountPercentage: $discountPercentage, rating: $rating, stock: $stock, tags: $tags, brand: $brand, sku: $sku, weight: $weight, warrantyInformation: $warrantyInformation, shippingInformation: $shippingInformation, availabilityStatus: $availabilityStatus, returnPolicy: $returnPolicy, minimumOrderQuantity: $minimumOrderQuantity, images: $images, thumbnail: $thumbnail}';
  }
}
