class CartModel {
  final String masp;
  final String maloai;
  final String tensp;
  final String tenloai;
  final String giamgia;
  final double gia;
  final String anh;
  final String mota;
  final int soluong;
  final double tongtien;
  final String ngaygiao;
  late final bool valuecheckbox;
  final dynamic createdAt;
  final dynamic updatedAt;

  CartModel({
    required this.masp,
    required this.maloai,
    required this.tensp,
    required this.tenloai,
    required this.giamgia,
    required this.gia,
    required this.anh,
    required this.mota,
    required this.soluong,
    required this.tongtien,
    required this.ngaygiao,
    required this.valuecheckbox,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'masp': masp,
      'maloai': maloai,
      'tensp': tensp,
      'tenloai': tenloai,
      'giamgia': giamgia,
      'gia': gia,
      'anh': anh,
      'mota': mota,
      'soluong': soluong,
      'tongtien': tongtien,
      'ngaygiao' : ngaygiao,
      'valuecheckbox' : valuecheckbox,
      'createdAt' : createdAt,
      'updatedAt' : updatedAt,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> json) {
    return CartModel(
      masp: json['masp'],
      maloai: json['maloai'],
      tensp: json['tensp'],
      tenloai: json['tenloai'],
      giamgia: json['giamgia'],
      gia: json['gia'],
      anh: json['anh'],
      mota: json['mota'],
      soluong: json['soluong'],
      tongtien: json['tongtien'],
      ngaygiao: json['ngaygiao'],
      valuecheckbox: json['valuecheckbox'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}