import 'package:flutter/material.dart';

class Withdrawal extends StatefulWidget {
  @override
  _WithdrawalState createState() => _WithdrawalState();
}

class _WithdrawalState extends State<Withdrawal> {
  String? reasonForWithdrawal;
  bool isOtherReason = false;
  TextEditingController otherReasonController = TextEditingController();

  final reasons = [
    "운전은 하지만 앱을 자주 이용하지 않아요.",
    "더 이상 운전을 하지 않아요.",
    "오류가 너무 많아요.",
    "사용 방법이 너무 어려워요.",
    "필요한 기능이 없어요.",
    "기타",
  ];

  @override
  void dispose() {
    otherReasonController.dispose();
    super.dispose();
  }

  void _onReasonChanged(String? value) {
    setState(() {
      reasonForWithdrawal = value;
      isOtherReason = value == reasons.last;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("회원탈퇴"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            "김재영님,\n정말 회원탈퇴 하시겠어요?",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Text(
            "어떤 이유로 저희 앱을 탈퇴하려는지 알려주신다면\n개선될 수 있도록 노력하겠습니다.",
            textAlign: TextAlign.center,
          ),
          ...reasons.map((reason) => RadioListTile<String>(
            value: reason,
            groupValue: reasonForWithdrawal,
            title: Text(reason),
            onChanged: _onReasonChanged,
          )),
          if (isOtherReason) ...[
            TextField(
              controller: otherReasonController,
              decoration: InputDecoration(
                labelText: '다른 이유를 입력해주세요',
                border: OutlineInputBorder(),
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('취소'),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: reasonForWithdrawal != null ? () {
                      // 탈퇴 처리 로직
                    } : null,
                    child: Text('탈퇴'),
                    style: ElevatedButton.styleFrom(
                      primary: reasonForWithdrawal != null ? Color(0xff473E7C) : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
