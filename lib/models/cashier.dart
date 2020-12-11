import 'package:password/password.dart';
import 'package:encrypt/encrypt.dart';
import 'package:random_string/random_string.dart';

class Cashier {
  int customer_id;
  String customer_name, customer_number,customer_email,customer_address,customer_city;
  Encrypter _encrypter;
  Encrypted _hash;
  String _randomStr;


  set id(int id) {
    customer_id = id;
  }

  set name(String name) {
    customer_name = name;
  }

  set number(String number) {
    customer_number = number;
  }

  set mail(String mail) {
    customer_email = mail;
  }

  set address(String address) {
    customer_address = address;
  }

  set city(String city) {
    customer_city = city;
  }

  set hash(String password) {
    _encrypter =
        Encrypter(Salsa20(Key.fromUtf8('$customer_name$customer_number$customer_email')));
    _hash = _encrypter.encrypt(password, iv: IV.fromUtf8(_randomStr));
  }



  int get id {
    return customer_id;
  }

  String get name {
    return customer_name;
  }

  String get number {
    return customer_number;
  }

  String get email {
    return customer_email;
  }

  String get address {
    return customer_address;
  }

  String get city {
    return customer_city;
  }

  String get randomStr {
    return '$_randomStr';
  }


  String get hashBase64 {
    if (_hash == null)
      return '';
    else
      return '${_hash.base64}';
  }

  Cashier.db(this.customer_id, this.customer_name, this.customer_number, this.customer_email,this.customer_address,this.customer_city,
      this._randomStr, String hash) {
    _encrypter =
        Encrypter(Salsa20(Key.fromUtf8('$customer_name$customer_number$customer_email')));
    _hash = Encrypted.from64(hash);
  }

  Cashier.def() {
    customer_id = -1;
    customer_name = '';
    customer_number = '';
    customer_email = '';
    customer_address='';
    customer_city='';
    _randomStr = randomString(8);
    _encrypter = null;
    _hash = null;

  }

  bool passwordVerify(String newpassword) {
    Encrypted newhash =
    _encrypter.encrypt(newpassword, iv: IV.fromUtf8(_randomStr));
    if (newhash.base64 == hashBase64)
      return true;
    else
      return false;
  }

  toJson() => {
    'customer_id': id,
    'customer_name': name,
    'customer_number': number,
    'customer_email': email,
    'customer_address': address,
    'customer_city': city,
    'randomstr': randomStr,
    'hash': hashBase64,

  };

  factory Cashier.fromJson(Map<String, dynamic> json) {
    var a=new Cashier.db(
        json['customer_id'] as int,
        json['customer_name'] as String,
        json['customer_number'] as String,
        json['customer_email'] as String,
        json['customer_address'] as String,
        json['customer_city'] as String,
        json['randomstr'] as String,
        json['hash'] as String);

    return a;
  }
}
