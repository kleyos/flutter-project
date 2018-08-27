class Roleable {
  String role;

  bool get isQS => role == 'qs';
  bool get isContractor => role == 'ctr';
  bool get isAMO => role == 'amo';
}
