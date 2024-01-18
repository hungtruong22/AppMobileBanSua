class CategoryModel {
  final String maloai;
  final String anh;
  final String tenloai;

  CategoryModel({
    required this.maloai,
    required this.anh,
    required this.tenloai,
  });

  // Serialize the UserModel instance to a JSON map
  Map<String, dynamic> toMap() {
    return {
      'maloai': maloai,
      'anh': anh,
      'tenloai': tenloai,
    };
  }

  // Create a UserModel instance from a JSON map
  factory CategoryModel.fromMap(Map<String, dynamic> json) {
    return CategoryModel(
      maloai: json['maloai'],
      anh: json['anh'],
      tenloai: json['tenloai'],
    );
  }
}