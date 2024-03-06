import 'package:barcodescan/models/employre.dart';

class GetOut {
  GetOut({
    required this.idGetOut,
    required this.hour,
    required this.employerId,
    required this.dateOut,
    required this.employer,
  });
  late final int idGetOut;
  late final String hour;
  late final int employerId;
  late final String dateOut;
  late final Employer employer;

  GetOut.fromJson(Map<String, dynamic> json){
    idGetOut = json['idGetOut'];
    hour = json['hour'];
    employerId = json['employerId'];
    dateOut = json['dateOut'];
    employer = Employer.fromJson(json['employer']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['idGetOut'] = idGetOut;
    _data['hour'] = hour;
    _data['employerId'] = employerId;
    _data['dateOut'] = dateOut;
    _data['employer'] = employer;
    return _data;
  }
}