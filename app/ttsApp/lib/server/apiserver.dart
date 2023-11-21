import 'dart:io';

class ApiServer{
  final apiserver = "http://192.168.20.192:5000";


  // final apiserver = "http://ec2-3-36-26-208.ap-northeast-2.computea.amazonaws.com:5000";

  String getApiServer(){
    return apiserver;
  }


}