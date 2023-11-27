import 'package:firstflutterapp/SignUpPage/signupPhone.dart';
import 'package:firstflutterapp/SignUpPage/signupemailPwd.dart';
import 'package:flutter/material.dart';


class SignUp extends StatelessWidget {
  // const SignUp({super.key});
  late final int isSelected;
  SignUp({Key? key, this.isSelected = 0}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hello",
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: DefaultTabController(
        length: 3, // 3개의 탭을 가집니다.
        child: SignuptwoScreen(this.isSelected),
        initialIndex: isSelected,
      ),
    );
  }
}

class SignuptwoScreen extends StatefulWidget {
  final int isSelected;
  SignuptwoScreen(this.isSelected, {Key? key}) : super(key: key);

  @override
  _SignuptwoScreenState createState() => _SignuptwoScreenState();
}
class _SignuptwoScreenState extends State<SignuptwoScreen> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  TextEditingController termsController = TextEditingController();
  TextEditingController privacyController = TextEditingController();
  bool isCheck = true;
  bool termsAgreed = false;
  bool privacyAgreed = false;

  @override
  void initState() {
    super.initState();
    // TabController를 초기화합니다. vsync는 TickerProvider를 필요로 합니다.
    _tabController = TabController(length: 3, vsync: this);
    // TabController의 리스너를 추가합니다.
    _tabController.addListener(() {
      // setState를 호출하여 UI를 다시 빌드합니다.
      setState(() {});
    });
  }

  @override
  void dispose() {
    // 리소스 해제를 위해 TabController를 dispose합니다.
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
<<<<<<< HEAD
        centerTitle: true,
        backgroundColor: Colors.white,
=======
        backgroundColor: Colors.white,
        centerTitle: true,
>>>>>>> origin/main
        // toolbarHeight: 80,
        title: Text('회원가입'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Align(
              alignment: Alignment.center,
              child: TabBar(

                controller: DefaultTabController.of(context),
                onTap: (index) {
                  // 여기서는 아무 동작도 하지 않음으로써 탭을 눌렀을 때의 이동을 막습니다.
                },
                isScrollable: true,
                indicatorColor: Colors.transparent,
                tabs: [
                  Tab(
                    child: TabItemWidget(number: '1', text: '약관동의', isSelected: _tabController.index == 0,),
                  ),
                  Tab(
                    child: TabItemWidget(number: '2', text: '정보입력', isSelected: _tabController.index == 1,),
                  ),
                  Tab(
                    child: TabItemWidget(number: '3', text: '확인 및 조정', isSelected: _tabController.index == 2,),
                  ),
                ],

              ),

            ),
          ),
        ),

      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: [
          ListView(
            children: [
              SizedBox(height: 15),
              Padding(
                padding: EdgeInsets.only(left: 16.0), // 모든 방향에 10픽셀의 패딩을 추가합니다.
                child: Text(
                  '이용약관',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: MediaQuery.of(context).size.height / 4,
                child: SingleChildScrollView(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '제 1장 총칙\n\n',
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 1조 (목적)\n\n',
                          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: '이 약관은 "운전만해"에서 제공하는 "운전만해"의 이용 조건 및 절차에 관한 기본적인 사항을 규정함을 목적으로 합니다.\n\n',
                          style: TextStyle(fontSize: 11.0, color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 2조 (약관의 효력 및 변경)\n\n',
                          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: '''① 이 약관은 서비스 화면이나 기타의 방법으로 이용고객에게 공지함으로써 효력을 발생합니다.\n
② 사이트는 이 약관의 내용을 변경할 수 있으며, 변경된 약관은 제1항과 같은 방법으로 공지 또는 통지함으로써 효력을 발생합니다.\n\n\n''',
                          style: TextStyle(fontSize: 11.0,  color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 3조 (용어의 정의)\n\n',
                          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: '''이 약관에서 사용하는 용어의 정의는 다음과 같습니다.\n① 회원 : 사이트와 서비스 이용계약을 체결하거나 이용자 아이디(ID)를 부여받은 개인 또는 단체를 말합니다.\n② 신청자 : 회원가입을 신청하는 개인 또는 단체를 말합니다.\n③ 아이디(ID) : 회원의 식별과 서비스 이용을 위하여 회원이 정하고 사이트가 승인하는 문자와 숫자의 조합을 말합니다.\n④ 비밀번호 : 회원이 부여 받은 아이디(ID)와 일치된 회원임을 확인하고, 회원 자신의 비밀을 보호하기 위하여 회원이 정한 문자와 숫자의 조합을 말합니다.\n⑤ 해지 : 사이트 또는 회원이 서비스 이용계약을 취소하는 것을 말합니다.\n\n\n''',
                          style: TextStyle(fontSize: 11.0, color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 2장 서비스 이용계약\n\n\n',
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 4조 (이용계약의 성립)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''① 이용약관 하단의 동의 버튼을 누르면 이 약관에 동의하는 것으로 간주됩니다.\n② 이용계약은 서비스 이용희망자의 이용약관 동의 후 이용 신청에 대하여 사이트가 승낙함으로써 성립합니다.\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 5조 (이용신청)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''① 신청자가 본 서비스를 이용하기 위해서는 사이트 소정의 가입신청 양식에서 요구하는 이용자 정보를 기록하여 제출해야 합니다.\n② 가입신청 양식에 기재하는 모든 이용자 정보는 모두 실제 데이터인 것으로 간주됩니다. 실명이나 실제 정보를 입력하지 않은 사용자는 법적인 보호를 받을 수 없으며, 서비스의 제한을 받을 수 있습니다.\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 6조 (이용신청의 승낙)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''① 사이트는 신청자에 대하여 제2항, 제3항의 경우를 예외로 하여 서비스 이용신청을 승낙합니다.\n② 사이트는 다음에 해당하는 경우에 그 신청에 대한 승낙 제한사유가 해소될 때까지 승낙을 유보할 수 있습니다.\n\t\t가. 서비스 관련 설비에 여유가 없는 경우\n\t\t나. 기술상 지장이 있는 경우\n\t\t다. 기타 사이트가 필요하다고 인정되는 경우
③ 사이트는 신청자가 다음에 해당하는 경우에는 승낙을 거부할 수 있습니다.\n\t\t가. 다른 개인(사이트)의 명의를 사용하여 신청한 경우\n\t\t나. 이용자 정보를 허위로 기재하여 신청한 경우\n\t\t다. 사회의 안녕질서 또는 미풍양속을 저해할 목적으로 신청한 경우\n\t\t라. 기타 사이트 소정의 이용신청요건을 충족하지 못하는 경우\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 7조 (이용자정보의 변경)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''회원은 이용 신청시에 기재했던 회원정보가 변경되었을 경우에는, 온라인으로 수정하여야 하며 변경하지 않음으로 인하여 발생되는 모든 문제의 책임은 회원에게 있습니다.\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 8조 (사이트의 의무)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''① 사이트는 회원에게 각 호의 서비스를 제공합니다.\n\t\t가. 신규서비스와 도메인 정보에 대한 뉴스레터 발송\n\t\t나. 추가 도메인 등록시 개인정보 자동 입력\n\t\t다. 도메인 등록, 관리를 위한 각종 부가서비스\n② 사이트는 서비스 제공과 관련하여 취득한 회원의 개인정보를 회원의 동의없이 타인에게 누설, 공개 또는 배포할 수 없으며, 서비스관련 업무 이외의 상업적 목적으로 사용할 수 없습니다. 단, 다음 각 호의 1에 해당하는 경우는 예외입니다.\n\t\t가. 전기통신기본법 등 법률의 규정에 의해 국가기관의 요구가 있는 경우\n\t\t나. 범죄에 대한 수사상의 목적이 있거나 정보통신윤리 위원회의 요청이 있는 경우\n\t\t다. 기타 관계법령에서 정한 절차에 따른 요청이 있는 경우
\n③ 사이트는 이 약관에서 정한 바에 따라 지속적, 안정적으로 서비스를 제공할 의무가 있습니다.\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 9조 (회원의 의무)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''① 회원은 서비스 이용 시 다음 각 호의 행위를 하지 않아야 합니다.\n\t\t가. 다른 회원의 ID를 부정하게 사용하는 행위\n\t\t나. 서비스에서 얻은 정보를 사이트의 사전승낙 없이 회원의 이용 이외의 목적으로 복제하거나 이를 변경, 출판 및 방송 등에 사용하거나 타인에게 제공하는 행위\n\t\t다. 사이트의 저작권, 타인의 저작권 등 기타 권리를 침해하는 행위\n\t\t라. 공공질서 및 미풍양속에 위반되는 내용의 정보, 문장, 도형 등을 타인에게 유포하는 행위\n\t\t마. 범죄와 결부된다고 객관적으로 판단되는 행위\n\t\t바. 기타 관계법령에 위배되는 행위\n② 회원은 관계법령, 이 약관에서 규정하는 사항, 서비스 이용 안내 및 주의 사항을 준수하여야 합니다.\n③ 회원은 내용별로 사이트가 서비스 공지사항에 게시하거나 별도로 공지한 이용 제한 사항을 준수하여야 합니다.\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 4장 서비스 제공 및 이용\n\n\n',
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 10조 (회원 아이디(ID)와 비밀번호 관리에 대한 회원의 의무)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''① 아이디(ID)와 비밀번호에 대한 모든 관리는 회원에게 책임이 있습니다. 회원에게 부여된 아이디(ID)와 비밀번호의 관리소홀, 부정사용에 의하여 발생하는 모든 결과에 대한 전적인 책임은 회원에게 있습니다.\n② 자신의 아이디(ID)가 부정하게 사용된 경우 또는 기타 보안 위반에 대하여, 회원은 반드시 사이트에 그 사실을 통보해야 합니다.\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 11조 (서비스 제한 및 정지)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''① 사이트는 전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우와 전기통신사업법에 의한 기간통신 사업자가 전기통신서비스를 중지하는 등 기타 불가항력적 사유가 있는 경우에는 서비스의 전부 또는 일부를 제한하거나 정지할 수 있습니다.\n② 사이트는 제1항의 규정에 의하여 서비스의 이용을 제한하거나 정지할 때에는 그 사유 및 제한기간 등을 지체없이 회원에게 알려야 합니다.\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 5장 계약사항의 변경, 해지\n\n\n',
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 12조 (정보의 변경)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''회원이 주소, 비밀번호 등 고객정보를 변경하고자 하는 경우에는 홈페이지의 회원정보 변경 서비스를 이용하여 변경할 수 있습니다.\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 13조 (계약사항의 해지)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''회원은 서비스 이용계약을 해지할 수 있으며, 해지할 경우에는 본인이 직접 서비스를 통하거나 전화 또는 온라인 등으로 사이트에 해지신청을 하여야 합니다. 사이트는 해지신청이 접수된 당일부터 해당 회원의 서비스 이용을 제한합니다. 사이트는 회원이 다음 각 항의 1에 해당하여 이용계약을 해지하고자 할 경우에는 해지조치 7일전까지 그 뜻을 이용고객에게 통지하여 소명할 기회를 주어야 합니다.\n① 이용고객이 이용제한 규정을 위반하거나 그 이용제한 기간 내에 제한 사유를 해소하지 않는 경우\n② 정보통신윤리위원회가 이용해지를 요구한 경우\n③ 이용고객이 정당한 사유 없이 의견진술에 응하지 아니한 경우\n④ 타인 명의로 신청을 하였거나 신청서 내용의 허위 기재 또는 허위서류를 첨부하여 이용계약을 체결한 경우 사이트는 상기 규정에 의하여 해지된 이용고객에 대해서는 별도로 정한 기간동안 가입을 제한할 수 있습니다.\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 6장 손해배상\n\n\n',
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 14조 (면책조항)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''① 사이트는 회원이 서비스 제공으로부터 기대되는 이익을 얻지 못하였거나 서비스 자료에 대한 취사선택 또는 이용으로 발생하는 손해 등에 대해서는 책임이 면제됩니다.\n② 사이트는 회원의 귀책사유나 제3자의 고의로 인하여 서비스에 장애가 발생하거나 회원의 데이터가 훼손된 경우에 책임이 면제됩니다.\n③ 사이트는 회원이 게시 또는 전송한 자료의 내용에 대해서는 책임이 면제됩니다.\n④ 상표권이 있는 도메인의 경우, 이로 인해 발생할 수도 있는 손해나 배상에 대한 책임은 구매한 회원 당사자에게 있으며, 사이트는 이에 대한 일체의 책임을 지지 않습니다.\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '제 15조 (관할법원)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '서비스와 관련하여 사이트와 회원간에 분쟁이 발생할 경우 사이트의 본사 소재지를 관할하는 법원을 관할법원으로 합니다.\n\n',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CheckboxListTile(
                title: Text('이용약관에 동의합니다.'),
                value: termsAgreed,
                activeColor: Color(0xff473E7C),
                onChanged: (bool? value) {
                  setState(() {
                    termsAgreed = value ?? false;
                  });
                },
              ),
              SizedBox(height: 13),
              Padding(
                padding: EdgeInsets.only(left: 16.0), // 왼쪽에만 10픽셀의 패딩을 추가합니다.
                child: Text(
                  '개인정보취급방침',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                height: MediaQuery.of(context).size.height / 4,
                child: SingleChildScrollView(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '본 방침은 2023년 12월 4일부터 적용됩니다.\n\n',
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: '1. 개인정보의 수집 및 이용 목적\n\n',
                          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: '''기관은 수집한 개인정보를 다음의 목적을 위해 활용합니다.\n1) 홈페이지 회원 가입 및 관리\n2) 후원자 서비스 제공\n3)  마케팅, 광고에의 활용\n\n''',
                          style: TextStyle(fontSize: 11.0, color: Colors.black),
                        ),
                        TextSpan(
                          text: '2. 개인정보의 보유 및 이용기간\n\n',
                          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: '''1) 계약 또는 청약철회 등에 관한 기록\n\t\t 보존 이유: 전자상거래 등에서의 소비자보호에 관한 법룔 제6조 및 시행령 제6조- 보존 기간: 5년\n2) 대금결제 및 재화 등의 공급에 관한 기록\n\t\t- 보존 이유: 전자상거래 등에서의 소비자보호에 관한 법룔 제6조 및 시행령 제6조- 보존 기간: 5년\n3) 소비자의 불만 또는 분쟁처리에 관한 기록\n\t\t- 보존 이유: 전자상거래 등에서의 소비자보호에 관한 법룔 제6조 및 시행령 제6조- 보존 기간: 3년\n4) 본인확인에 관한 기록\n\t\t- 보존 이유: 정보통신망 이용촉진 및 정보보호에 관한 법률 제 44조의5 및 시행령 제 29조- 보존 기간: 6개월\n5) 접속에 관한 기록\n\t\t- 보존 이유: 통신비밀보호법 제15조의2 및 시행령 제41조- 보존 기간: 3개월\n\n\n''',
                          style: TextStyle(fontSize: 11.0,  color: Colors.black),
                        ),
                        TextSpan(
                          text: '3. 수집하는 개인정보의 항목\n\n',
                          style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        TextSpan(
                          text: '''기관은 회원가입, 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.\n1) 수집항목 \n\t\t필수 입력 : 이름, 로그인ID, 비밀번호, 휴대전화번호, 이메일 \n\t\t선택 입력 :프로필 사진\n\t\t자동 수집항목 :  IP 정보, MAC정보, 이용 기록, 접속 로그, 쿠키, 접속 기록 등\n2) 개인정보 수집방법: 홈페이지(회원 가입)\n\n\n''',
                          style: TextStyle(fontSize: 11.0, color: Colors.black),
                        ),
                        TextSpan(
                          text: '4. 개인정보의 파기절차 및 방법\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''기관은 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에는 해당 정보를 지체 없이 파기합니다.\n파기절차 및 방법은 다음과 같습니다.\n\t\t1) 파기절차\n\t\t2) 파기방법\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '5. 개인정보 제공\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''기관은 이용자의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 아래의 경우에는 예외로 합니다.\n-이용자들이 사전에 동의한 경우- 법령의 규정에 의거하거나, 수사 목적으로 사기관의 요구가 있는 경우\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '6. 이용자 및 법정대리인의 권리와 그 행사방법\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''이용자 및 법정 대리인은 언제든지 등록되어 있는 본인 혹은 당해 만 14세 미만 아동의 개인정보를 조회하거나 수정할 수 있으며 가입 해지를 요청할 수도 있습니다. \n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '7. 개인정보의 안정성 확보조치에 관한 사항\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''1) 개인정보 암호화\n2) 해킹 등에 대비한 대책\n3) 취급 직원의 최소화 및 교육\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '8. 개인정보 관리 책임자 및 담당자)\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''조직내 정보처리 및 정보보안 담당부서와 연락처 기재 \n\t\t-010.0000.0000\n기타 개인정보침해에 대한 신고나 상담이 필요한 경우에는 아래 기관에 문의하시기 바랍니다.\n\t\t- 개인정보침해신고센터 (www.118.or.kr / 118)\n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                        TextSpan(
                          text: '11. 개인정보 취급방침 변경에 관한 사항\n\n',
                          style: TextStyle(fontSize: 11.0,fontWeight:FontWeight.bold,color: Colors.black),
                        ),
                        TextSpan(
                          text: '''이 개인정보 취급방침은 2023년 12월 4일일부터 적용됩니다. \n변경이전의 “정보보안 처리방침”을 과거이력 기록 \n\n''',
                          style: TextStyle(fontSize: 11.0,color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              CheckboxListTile(
                title: Text('개인정보취급방침에 동의합니다.'),
                value: privacyAgreed,
                activeColor: Color(0xff473E7C),
                onChanged: (bool? value) {
                  setState(() {
                    privacyAgreed = value ?? false;
                  });
                },
              ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0), // 양옆에 16픽셀의 마진 추가
            child: ElevatedButton(
              child: Text(
                '다음',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: termsAgreed && privacyAgreed ? Color(0xff473E7C) : Colors.grey, // 색상 변경
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0), // 모양 변경
                ),
              ),
              onPressed: () {
                if (termsAgreed && privacyAgreed) {
                  _tabController.animateTo(1);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('알림'),
                        content: Text('이용약관 및 개인정보취급방침에 모두 동의해주세요.'),
                        actions: <Widget>[
                          ElevatedButton(
                            child: Text('확인'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
      ),



            ],
          ),
          // 두 번째 탭의 내용

          // 세 번째 탭의 내용
          SignupPhone(tabController: _tabController),
          SignupEmailPwd(),
        ],


      ),
    );
  }
}
class TabItemWidget extends StatelessWidget {
  final String number;
  final String text;
  final bool isSelected;

  const TabItemWidget({
    Key? key,
    required this.number,
    required this.text,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 11,
            backgroundColor: isSelected ? Color(0xff473E7C) : Colors.grey.shade300,
            child: Text(
              number,
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
          SizedBox(height: 2),
          Text(text, style: TextStyle(
            fontSize: 10.5
          )),
        ],
      ),
    );
  }
}