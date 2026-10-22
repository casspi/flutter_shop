class UserInfo {
  String account;
  String avatar;
  String birthday;
  String cityCode;
  String gender;
  String id;
  String mobile;
  String nickname;
  String profession;
  String provinceCode;
  String token;

  UserInfo({
    required this.account,
    required this.avatar,
    required this.birthday,
    required this.cityCode,
    required this.gender,
    required this.id,
    required this.mobile,
    required this.nickname,
    required this.profession,
    required this.provinceCode,
    required this.token,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    account: json['account']?.toString() ?? '',
    avatar: json['avatar']?.toString() ?? '',
    birthday: json['birthday']?.toString() ?? '',
    cityCode: json['cityCode']?.toString() ?? '',
    gender: json['gender']?.toString() ?? '',
    id: json['id']?.toString() ?? '',
    mobile: json['mobile']?.toString() ?? '',
    nickname: json['nickname']?.toString() ?? '',
    profession: json['profession']?.toString() ?? '',
    provinceCode: json['provinceCode']?.toString() ?? '',
    token: json['token']?.toString() ?? '',
  );

  @override
  String toString() =>
      'UserInfo(id: $id, account: $account, nickname: $nickname, mobile: $mobile, token: $token)';
}
