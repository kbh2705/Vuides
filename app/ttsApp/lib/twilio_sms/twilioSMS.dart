import 'dart:convert' show base64Encode, json, utf8;
import 'dart:math';
import 'package:http/http.dart' as http;

class TwilioSMS {
  String accountSid ="ACc054c20a78fd0de1bf0975bc99f71037";
  String authToken="c97c30ab164b68b8fcbea9670bc681bb";
  String twilioNumber = "+19143152016";


  Future<Map> sendSMS(String toNumber, String messageBody) async {
    final String url = 'https://api.twilio.com/2010-04-01/Accounts/$accountSid/Messages.json';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Basic ' + base64Encode(utf8.encode('$accountSid:$authToken')),
      },
      body: {
        'From': twilioNumber,
        'To': toNumber,
        'Body': messageBody,
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      print(response.statusCode);
      throw Exception('Failed to send SMS');
    }
  }
  String generateRandomCode() {
    var random = Random();
    var code = '';

    for (var i = 0; i < 6; i++) {
      code += random.nextInt(10).toString(); // 0부터 9 사이의 난수 생성
    }

    return code;
  }

}
