class WorkoutModel {
  int? wpWId;
  String? wType;
  int? wpSets;
  int? wpReps;
  String? wpDesc;
  int? wpDay;
  int? workoutId;
  int? wpIssuper;
  int? wpId;
  String? wmStartDate;
  String? wmEndDate;
  String? wmDesc;
  String? cusFname;
  String? cusLname;

  WorkoutModel(
      {this.wpWId,
      this.wType,
      this.wpSets,
      this.wpReps,
      this.wpDesc,
      this.wpDay,
      this.workoutId,
      this.wpIssuper,
      this.wpId,
      this.wmStartDate,
      this.wmEndDate,
      this.wmDesc,
      this.cusFname,
      this.cusLname});

  WorkoutModel.fromJson(Map<String, dynamic> json) {
    wpWId = json['wp_w_id'];
    wType = json['w_type'];
    wpSets = json['wp_sets'];
    wpReps = json['wp_reps'];
    wpDesc = json['wp_desc'];
    wpDay = json['wp_day'];
    workoutId = json['workout_id'];
    wpIssuper = json['wp_issuper'];
    wpId = json['wp_id'];
    wmStartDate = json['wm_start_date'];
    wmEndDate = json['wm_end_date'];
    wmDesc = json['wm_desc'];
    cusFname = json['cus_fname'];
    cusLname = json['cus_lname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wp_w_id'] = this.wpWId;
    data['w_type'] = this.wType;
    data['wp_sets'] = this.wpSets;
    data['wp_reps'] = this.wpReps;
    data['wp_desc'] = this.wpDesc;
    data['wp_day'] = this.wpDay;
    data['workout_id'] = this.workoutId;
    data['wp_issuper'] = this.wpIssuper;
    data['wp_id'] = this.wpId;
    data['wm_start_date'] = this.wmStartDate;
    data['wm_end_date'] = this.wmEndDate;
    data['wm_desc'] = this.wmDesc;
    data['cus_fname'] = this.cusFname;
    data['cus_lname'] = this.cusLname;
    return data;
  }
}
