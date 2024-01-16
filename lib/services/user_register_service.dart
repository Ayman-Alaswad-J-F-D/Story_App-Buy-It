import '../app/constants/constants.dart';
import '../helper/remote/user_api.dart';
import '../models/user_model.dart';
import 'endpoints/user_endpoints.dart';

class UserRegisterService {
  static Future<UserModel> sendUserInformation({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    final dynamic data = await UserApi.post(
      url: REGISTER,
      token: token,
      body: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
      },
    );
    final UserModel userModel = UserModel.fromJson(data);

    return userModel;
  }
}
