import 'package:firstflutterapp/server/apiserver.dart';

class getMember {
  static String apiserver = ApiServer().getApiServer();
  String url = "$apiserver/getMember";



}