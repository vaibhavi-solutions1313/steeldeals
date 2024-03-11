class CartReformatModel {
  String? firstProductImage;
  String? allName;
  String? totalPrice;
  String? sellerName;
  List<ProductList>? productList;
  Summary? summary;

  CartReformatModel({this.firstProductImage, this.allName, this.totalPrice, this.sellerName, this.productList, this.summary});

  CartReformatModel.fromJson(Map<String, dynamic> json) {
    firstProductImage = json['firstProductImage'];
    allName = json['allName'];
    totalPrice = json['totalPrice'];
    sellerName = json['sellerName'];
    if (json['productList'] != null) {
      productList = <ProductList>[];
      json['productList'].forEach((v) {
        productList!.add(new ProductList.fromJson(v));
      });
    }
    summary = json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstProductImage'] = this.firstProductImage;
    data['allName'] = this.allName;
    data['totalPrice'] = this.totalPrice;
    data['sellerName'] = this.sellerName;
    if (this.productList != null) {
      data['productList'] = this.productList!.map((v) => v.toJson()).toList();
    }
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    return data;
  }
}

class ProductList {
  String? productId;
  String? productImage;
  String? productName;
  String? size;
  String? quantity;
  String? gst;
  String? amount;

  ProductList({this.productId, this.productImage, this.productName, this.size, this.quantity, this.gst, this.amount});

  ProductList.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    productImage = json['productImage'];
    productName = json['productName'];
    size = json['size'];
    quantity = json['quantity'];
    gst = json['gst'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['productImage'] = this.productImage;
    data['productName'] = this.productName;
    data['size'] = this.size;
    data['quantity'] = this.quantity;
    data['gst'] = this.gst;
    data['amount'] = this.amount;
    return data;
  }
}

class Summary {
  String? igst;
  String? sgst;
  String? cgst;
  String? loadingAmount;
  String? tcs;
  String? insurance;
  String? others;
  String? grandTotal;

  Summary({this.igst, this.sgst, this.cgst, this.loadingAmount, this.tcs, this.insurance, this.others, this.grandTotal});

  Summary.fromJson(Map<String, dynamic> json) {
    igst = json['igst'];
    sgst = json['sgst'];
    cgst = json['cgst'];
    loadingAmount = json['loadingAmount'];
    tcs = json['tcs'];
    insurance = json['insurance'];
    others = json['others'];
    grandTotal = json['grandTotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['igst'] = this.igst;
    data['sgst'] = this.sgst;
    data['cgst'] = this.cgst;
    data['loadingAmount'] = this.loadingAmount;
    data['tcs'] = this.tcs;
    data['insurance'] = this.insurance;
    data['others'] = this.others;
    data['grandTotal'] = this.grandTotal;
    return data;
  }
}
