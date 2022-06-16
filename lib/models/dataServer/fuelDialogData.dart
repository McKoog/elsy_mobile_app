import 'dart:convert';

List<FuelDialogData> FuelDialogDataFromJson(String str) => List<FuelDialogData>.from(json.decode(str).map((x) => FuelDialogData.fromJson(x)));

class FuelDialogData {
  List<FPData>? fPData;

  FuelDialogData({this.fPData});

  FuelDialogData.fromJson(Map<String, dynamic> json) {
    if (json['FPData'] != null) {
      fPData = <FPData>[];
      json['FPData'].forEach((v) {
        fPData!.add(new FPData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fPData != null) {
      data['FPData'] = this.fPData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FPData {
  int? id;
  List<FuelsInfo>? fuelsInfo;

  FPData({this.id, this.fuelsInfo});

  FPData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['fuelsInfo'] != null) {
      fuelsInfo = <FuelsInfo>[];
      json['fuelsInfo'].forEach((v) {
        fuelsInfo!.add(new FuelsInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.fuelsInfo != null) {
      data['fuelsInfo'] = this.fuelsInfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FuelsInfo {
  int? fuelId;
  String? fuelName;
  int? priceId;
  double? fuelPrice;

  FuelsInfo({this.fuelId, this.fuelName, this.priceId, this.fuelPrice});

  FuelsInfo.fromJson(Map<String, dynamic> json) {
    fuelId = json['fuelId'];
    fuelName = json['fuelName'];
    priceId = json['priceId'];
    fuelPrice = json['fuelPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fuelId'] = this.fuelId;
    data['fuelName'] = this.fuelName;
    data['priceId'] = this.priceId;
    data['fuelPrice'] = this.fuelPrice;
    return data;
  }
}