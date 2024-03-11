class Size {
  String? price;
  String? widthInMm;
  String? thicknessInMm;
  String? heightInMm;
  String? diameterInMm;
  String? lengthInMm;
  String? description;

  Size({this.price, this.widthInMm, this.thicknessInMm, this.heightInMm, this.diameterInMm, this.lengthInMm,this.description});

  Size.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    widthInMm = json['width_in_mm'];
    thicknessInMm = json['thickness_in_mm'];
    heightInMm = json['height_in_mm'];
    diameterInMm = json['diameter_in_mm'];
    lengthInMm = json['length_in_mm'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['width_in_mm'] = this.widthInMm;
    data['thickness_in_mm'] = this.thicknessInMm;
    data['height_in_mm'] = this.heightInMm;
    data['diameter_in_mm'] = this.diameterInMm;
    data['length_in_mm'] = this.lengthInMm;
    data['description'] = this.description;
    return data;
  }
}
