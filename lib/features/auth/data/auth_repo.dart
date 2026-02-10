import 'package:tgbc_app/core/utils/typedefs.dart';
import 'package:tgbc_app/features/auth/model/logged_in_user.dart';


abstract interface class AuthRepo {
  Future<bool> isLoggedIn();
  AsyncValueOf<LoggedInUser> logIn(String username,String pswd);
  AsyncValueOf<LoggedInUser> getPersistedUser();
  AsyncValueOf<bool> signOut();
}
