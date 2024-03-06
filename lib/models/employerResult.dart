import 'package:barcodescan/models/employre.dart';

class EmployerR {
  EmployerR({
    required this.employer,
    required this.hier,
    required this.late,
    required this.hourGetIn,
    required this.hourGetOut,
    required this.theDate,
  });
  late final Employer employer;
  late final String hier;
  late final String late;
  late final String hourGetIn;
  late final String hourGetOut;
  late final String theDate;

  EmployerR.fromJson(Map<String, dynamic> json){
    employer = Employer.fromJson(json['employer']);
    hier = json['hier'];
    late = json['late'];
    hourGetIn = json['hourGetIn'];
    hourGetOut = json['hourGetOut'];
    theDate = json['theDate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['employer'] = employer.toJson();
    _data['hier'] = hier;
    _data['late'] = late;
    _data['hourGetIn'] = hourGetIn;
    _data['hourGetOut'] = hourGetOut;
    _data['theDate'] = theDate;
    return _data;
  }
}