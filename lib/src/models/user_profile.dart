class UserProfile {
  final String idFirebase;
  final String nama;
  final String password;
  final String noTelepon;
  final String email;
  final String jenisKelamin;
  final String asalKota;

  UserProfile({
    this.idFirebase,
    this.nama,
    this.password,
    this.noTelepon,
    this.email,
    this.jenisKelamin,
    this.asalKota
  });

  // getter

  String get getNama => nama;
  String get getPassword => password;
  String get getNoTelepon => noTelepon;
  String get getIdFirebase => idFirebase;
  String get getEmail => email;
  String get getJenisKelamin => jenisKelamin;
  String get getAsalKota => asalKota;
  //String get getIdDatabase => idDatabase;

  Map<String, dynamic> toJson() {
    return {
      "idFirebase": this.idFirebase,
      "nama": this.nama,
      "password": this.password,
      "noTelepon": this.noTelepon,
      "email": this.email,
      "jenisKelamin": this.jenisKelamin,
      "asalKota": this.asalKota
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> parsedJson) {
    return UserProfile(
      idFirebase: parsedJson['idFirebase'],
      nama: parsedJson['nama'],
      password: parsedJson['password'],
      noTelepon: parsedJson['noTelepon'],
      jenisKelamin: parsedJson['jenisKelamin'],
      email: parsedJson['email'],
      asalKota: parsedJson['asalKota'],
    );
  }
}
