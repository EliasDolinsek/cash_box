import 'package:cash_box/core/errors/failure.dart';
import 'package:flutter/services.dart';

SignInFailureType fromPlatformException(PlatformException e){
  if(e.code == "ERROR_USER_NOT_FOUND"){
    return SignInFailureType.user_not_found;
  } else if(e.code == "ERROR_WRONG_PASSWORD"){
    return SignInFailureType.wrong_password;
  } else {
    return SignInFailureType.other;
  }
}
