class ProductModel {
  final String masp;
  final String maloai;
  final String tensp;
  final String giamgia;
  final double gia;
  final String anh;
  final int soluonghienco;
  final String mota;
  final String tenloai;
  final String ngaygiao;

  ProductModel({
    required this.masp,
    required this.maloai,
    required this.tensp,
    required this.giamgia,
    required this.gia,
    required this.anh,
    required this.soluonghienco,
    required this.mota,
    required this.tenloai,
    required this.ngaygiao,
  });

  Map<String, dynamic> toMap() {
    return {
      'masp': masp,
      'maloai': maloai,
      'tensp': tensp,
      'giamgia': giamgia,
      'gia': gia,
      'anh': anh,
      'soluonghienco': soluonghienco,
      'mota': mota,
      'tenloai' : tenloai,
      'ngaygiao' : ngaygiao,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> json) {
    return ProductModel(
      masp: json['masp'],
      maloai: json['maloai'],
      tensp: json['tensp'],
      giamgia: json['giamgia'],
      gia: json['gia'],
      anh: json['anh'],
      soluonghienco: json['soluonghienco'],
      mota: json['mota'],
      tenloai: json['tenloai'],
      ngaygiao: json['ngaygiao'],
    );
  }
}