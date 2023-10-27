class FoodModel {
  int? fmId;
  String? fmDesc;
  String? fmStartDate;
  String? fmEndDate;
  int? fpFId;
  int? fPortion;
  int? fMeal;
  String? fDesc;
  String? fType;

  FoodModel(
      {this.fmId,
      this.fmDesc,
      this.fmStartDate,
      this.fmEndDate,
      this.fpFId,
      this.fPortion,
      this.fMeal,
      this.fDesc,
      this.fType});

  FoodModel.fromJson(Map<String, dynamic> json) {
    fmId = json['fm_id'];
    fmDesc = json['fm_desc'];
    fmStartDate = json['fm_start_date'];
    fmEndDate = json['fm_end_date'];
    fpFId = json['fp_f_id'];
    fPortion = json['f_portion'];
    fMeal = json['f_meal'];
    fDesc = json['f_desc'];
    fType = json['f_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fm_id'] = this.fmId;
    data['fm_desc'] = this.fmDesc;
    data['fm_start_date'] = this.fmStartDate;
    data['fm_end_date'] = this.fmEndDate;
    data['fp_f_id'] = this.fpFId;
    data['f_portion'] = this.fPortion;
    data['f_meal'] = this.fMeal;
    data['f_desc'] = this.fDesc;
    data['f_type'] = this.fType;
    return data;
  }
}
