import '../../app/user_data/class_user_data.dart';
import '../../models/user_model.dart';

class UserDataHelper {
  static UserModel? get _getUserData => UserData.instance.getUserData;

  static String get name => _getUserData?.data?.name ?? "";
  static String get email => _getUserData?.data?.email ?? "";
  static String get image => _getUserData?.data?.image ?? "";
}
