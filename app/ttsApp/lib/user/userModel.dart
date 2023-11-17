//TODO : 1번 싱글톤 패턴 방법
// 싱글톤 패턴으로 앱 전체에서 하나의 인스턴스만 유지하도록
//사용자 정보가 앱전체에서 일관되게 유지되어야 할 때 유용
/*
Factory 생성자 추가: User() 팩토리 생성자를 통해 싱글톤 인스턴스에 접근할 수 있습니다.
fromJson 메서드 수정: JSON 객체로부터 User 인스턴스를 생성할 때,
 DateTime.parse()를 사용하여 문자열을 DateTime 객체로 변환합니다.
updateUser 메서드: 이 메서드는 새로운 User 객체로부터 정보를 받아 현재 싱글톤 인스턴스의 정보를 업데이트합니다.
이 클래스를 사용하여 앱 전체에서 사용자 정보를 일관되게 유지하고 관리할 수 있습니다.
사용자가 로그인할 때 updateUser 메서드를 호출하여 사용자 정보를 업데이트하고,
 로그아웃할 때는 필드를 초기화하거나 적절한 처리를 할 수 있습니다.
 */
class UserMem {
  static final UserMem _singleton = UserMem._internal(email: '',
      pwd: '',
      name: '',
      phone: '',
      joinDate: DateTime.now(),
      type: '',
      adminYn: '');

  String email;
  String pwd;
  String name;
  String phone;
  DateTime joinDate;
  String type;
  String adminYn;

  /*
  Flutter에서 Dart 2.12 이상의 버전부터 Null Safety가 도입되었습니다.
   Null Safety는 변수가 명시적으로 null을 허용하지 않는 경우,
    해당 변수에 기본값을 제공하거나 required 키워드를 사용하여 반드시 값을 전달해야 함을 나타냅니다.
   */
  // 싱글톤 패턴의 private 생성자
  UserMem._internal({required this.email,
    required this.pwd,
    required this.name,
    required this.phone,
    required this.joinDate,
    required this.type,
    required this.adminYn});

  // 싱글톤 인스턴스에 접근하기 위한 factory 생성자
  factory UserMem() {
    return _singleton;
  }

  // JSON 데이터로부터 User 객체를 생성하는 factory 메서드
  factory UserMem.fromJson(Map<String, dynamic> json) {
    return UserMem._internal(
      email: json['mem_email'] as String,
      pwd: json['mem_pwd'] as String,
      name: json['mem_name'] as String,
      phone: json['mem_phone'] as String,
      joinDate: DateTime.tryParse(json['joinDate']) ?? DateTime.now(), // 올바른 날짜 형식이 아닌 경우 현재 날짜 사용
      type: json['mem_login_type'] as String,
      adminYn: json['adminYn'] as String,
    );
  }

  // 현재 User 인스턴스 업데이트
  void updateUser(UserMem newUser) {
    email = newUser.email;
    pwd = newUser.pwd;
    name = newUser.name;
    phone = newUser.phone;
    joinDate = newUser.joinDate;
    type = newUser.type;
    adminYn = newUser.adminYn;
  }
}


