import 'package:barcodescan/models/employre.dart';

class GetIn {
  GetIn({
    required this.idGetIn,
    required this.employerId,
    required this.hour,
    required this.dateIn,
    required this.employer,
  });
  late final int idGetIn;
  late final int employerId;
  late final String hour;
  late final String dateIn;
  late final Employer employer;

  GetIn.fromJson(Map<String, dynamic> json){
    idGetIn = json['idGetIn'];
    employerId = json['employerId'];
    hour = json['hour'];
    dateIn = json['dateIn'];
    employer = Employer.fromJson(json['employer']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['idGetIn'] = idGetIn;
    _data['employerId'] = employerId;
    _data['hour'] = hour;
    _data['dateIn'] = dateIn;
    _data['employer'] = employer.toJson();
    return _data;
  }
}