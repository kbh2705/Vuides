import 'package:firstflutterapp/oauth/social_login.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

class NaverLogin implements SocialLogin{

  @override
  Future<bool> login() async {
    try{
      final NaverLoginResult result = await FlutterNaverLogin.logIn();
      if(result.status == NaverLoginStatus.loggedIn){
        return true;
      }else{
        return false;
      }
    }catch(error) {
      return false;
    }
  }
  @override
  Future<bool> logout() async{
    try{
      await FlutterNaverLogin.logOut();
      return true;
    }catch(error){
      return false;
    }
  }

}