// UserProfileService.getUserProfileInformation()
import '../app/constants/constants.dart';
import '../helper/remote/user_api.dart';
import '../models/user_model.dart';
import 'endpoints/user_endpoints.dart';

class UserProfileService {
  static Future<UserModel> getUserProfileInformation() async {
    final dynamic data = await UserApi.get(
      url: PROFILE,
      token: token,
    );
    final UserModel userModel = UserModel.fromJson(data);

    return userModel;
  }
}
