import '../app/constants/constants.dart';
import '../helper/remote/user_api.dart';
import '../models/user_model.dart';
import 'endpoints/user_endpoints.dart';

class UpdateUserProfileImageService {
  static Future<UserModel> updateUserProfileImage({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String image,
  }) async {
    final dynamic data = await UserApi.put(
      url: UPDATE_PROFILE,
      token: token,
      body: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "image": image,
      },
    );
    final UserModel userModel = UserModel.fromJson(data);

    return userModel;
  }
}
