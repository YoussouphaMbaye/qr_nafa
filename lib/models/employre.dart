
class Employer {
  Employer({
    required this.idEmp,
    required this.nameEmp,
    required this.emailEmp,
    required this.phoneEmp,
    required this.birthDay,
    required this.status,
    required this.occupation,
    required this.codeEmp,
    required this.urlPicture,
    required this.urlQrcode,
    this.login,
    this.horaire,
    this.horaireId,
  });
  late final int idEmp;
  late final String? nameEmp;
  late final String? emailEmp;
  late final String? phoneEmp;
  late final String? birthDay;
  late final bool status;
  late final String? occupation;
  late final String? codeEmp;
  late final String? urlPicture;
  late final String? urlQrcode;
  late final Null login;
  late final Null horaire;
  late final Null horaireId;

  Employer.fromJson(Map<String, dynamic> json){
    idEmp = json['idEmp'];
    nameEmp = json['nameEmp'];
    emailEmp = json['emailEmp'];
    phoneEmp = json['phoneEmp'];
    birthDay = json['birthDay'];
    status = json['status'];
    occupation = json['occupation'];
    codeEmp = json['codeEmp'];
    urlPicture = json['urlPicture'];
    urlQrcode = json['urlQrcode'];
    login = null;
    horaire = null;
    horaireId = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['idEmp'] = idEmp;
    _data['nameEmp'] = nameEmp;
    _data['emailEmp'] = emailEmp;
    _data['phoneEmp'] = phoneEmp;
    _data['birthDay'] = birthDay;
    _data['status'] = status;
    _data['occupation'] = occupation;
    _data['codeEmp'] = codeEmp;
    _data['urlPicture'] = urlPicture;
    _data['urlQrcode'] = urlQrcode;
    _data['login'] = login;
    _data['horaire'] = horaire;
    _data['horaireId'] = horaireId;
    return _data;
  }
}