import '../app/constants/constants.dart';
import '../helper/remote/user_api.dart';
import '../models/user_model.dart';
import 'endpoints/user_endpoints.dart';

class UserLoginService {
  static Future<UserModel> fetchUserInformation({
    required String email,
    required String password,
  }) async {
    final dynamic data = await UserApi.post(
      url: LOGIN,
      token: token,
      body: {
        "email": email,
        "password": password,
      },
    );
    final UserModel userModel = UserModel.fromJson(data);

    return userModel;
  }
}
