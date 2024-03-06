import 'package:barcodescan/models/employerResult.dart';
import 'package:barcodescan/models/employre.dart';

class MyResult {
  MyResult({
    required this.listEmpR,
    required this.nbHier,
    required this.nbMissing,
  });
  late final List<EmployerR> listEmpR;
  late final int nbHier;
  late final int nbMissing;

  MyResult.fromJson(Map<dynamic, dynamic> json){
    listEmpR =json['listEmpR']==null?[]: List.from(json['listEmpR']).map((e)=>EmployerR.fromJson(e)).toList();
    nbHier = json['nbHier'];
    nbMissing = json['nbMissing'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['listEmpR'] = listEmpR.map((e)=>e.toJson()).toList();
    _data['nbHier'] = nbHier;
    _data['nbMissing'] = nbMissing;
    return _data;
  }
}