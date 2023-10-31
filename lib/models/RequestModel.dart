class RequestModel {
  int? cusId;
  int? trId;
  DateTime? rqDate;
  int? rqIsDiet;
  int? rqIsWorkout;
  String? rqDesc;
  int? rqStatus;
  int? rqId;

  RequestModel({
    this.rqId,
    this.rqDate,
    this.rqIsDiet,
    this.rqIsWorkout,
    this.rqDesc,
    this.rqStatus,
    this.cusId,
    this.trId,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      rqId: json['rq_id'],
      rqDate: json['rq_date'] != null ? DateTime.parse(json['rq_date']) : null,
      rqIsDiet: json['rq_isdiet'],
      rqIsWorkout: json['rq_isworkout'],
      rqDesc: json['rq_desc'],
      rqStatus: json['rq_Status'],
      cusId: json['cus_id'],
      trId: json['tr_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rq_id'] = rqId;
    data['rq_date'] = rqDate?.toIso8601String();
    data['rq_isdiet'] = rqIsDiet;
    data['rq_isworkout'] = rqIsWorkout;
    data['rq_desc'] = rqDesc;
    data['rq_Status'] = rqStatus;
    data['cus_id'] = cusId;
    data['tr_id'] = trId;
    return data;
  }
}
