class OrderModel {
  final String masp;
  final String maloai;
  final String tensp;
  final String tenloai;
  final String giamgia;
  final double gia;
  final String anh;
  final String ngaygiao;
  final String mota;
  final dynamic createdAt;
  final dynamic updatedAt;
  final int soluong;
  final double tongtien;
  final String makh;
  final bool trangthai;
  final String hotenkh;
  final String sdtkh;
  final String diachikh;
  // final String customerDeviceToken;

  OrderModel({
    required this.masp,
    required this.maloai,
    required this.tensp,
    required this.tenloai,
    required this.giamgia,
    required this.gia,
    required this.anh,
    required this.ngaygiao,
    required this.mota,
    required this.createdAt,
    required this.updatedAt,
    required this.soluong,
    required this.tongtien,
    required this.makh,
    required this.trangthai,
    required this.hotenkh,
    required this.sdtkh,
    required this.diachikh,
    // required this.customerDeviceToken,
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
      'ngaygiao': ngaygiao,
      'mota': mota,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'soluong': soluong,
      'tongtien': tongtien,
      'makh': makh,
      'trangthai': trangthai,
      'hotenkh': hotenkh,
      'sdtkh': sdtkh,
      'diachikh': diachikh,
      // 'customerDeviceToken': customerDeviceToken,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> json) {
    return OrderModel(
      masp: json['masp'],
      maloai: json['maloai'],
      tensp: json['tensp'],
      tenloai: json['tenloai'],
      giamgia: json['giamgia'],
      gia: json['gia'],
      anh: json['anh'],
      ngaygiao: json['ngaygiao'],
      mota: json['mota'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      soluong: json['soluong'],
      tongtien: json['tongtien'],
      makh: json['makh'],
      trangthai: json['trangthai'],
      hotenkh: json['hotenkh'],
      sdtkh: json['sdtkh'],
      diachikh: json['diachikh'],
      // customerDeviceToken: json['customerDeviceToken'],
    );
  }
}