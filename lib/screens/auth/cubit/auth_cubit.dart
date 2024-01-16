import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/functions/check_connection_function.dart';
import '../../../app/user_data/class_user_data.dart';
import '../../../helper/local/cache_helper.dart';
import '../../../models/user_model.dart';
import '../../../services/update_user_profile_image_service.dart';
import '../../../services/user_login_service.dart';
import '../../../services/user_profile_service.dart';
import '../../../services/user_register_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  //* Showing and hiding the field password text
  bool isPassword = true;
  final IconData _visibilityOn = Icons.visibility_outlined;
  final IconData _visibilityOff = Icons.visibility_off_outlined;
  late IconData suffix = _visibilityOn;

  //* To save the user password from the password field
  //* because the API does not support returning the password user response, and
  //? I need the user password to be sent in the request body
  //? when uploading the user profile image in case it has been updated by the user
  String? userPassword;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? _visibilityOn : _visibilityOff;
    emit(ChangePasswordVisibilityState());
  }

  static const UserData _userData = UserData.instance;

  void authantication() {
    if (_userData.getUserData == null) _checkTheUserDataFromTheCache();
  }

  void _checkTheUserDataFromTheCache() {
    try {
      userPassword = CacheHelper.getData(key: "Password") ?? "";
      log("$userPassword", name: "Password");

      final String cacheUserData = CacheHelper.getData(key: "UserData") ?? "";
      log(cacheUserData, name: "Cached User Data");
      if (cacheUserData.isNotEmpty) {
        _userData.setUserData = UserModel.fromJson(jsonDecode(cacheUserData));
      } else {
        _fetchUserProfile();
      }
    } catch (e) {
      log("when check User Data from the cache $e", name: "Error");
    }
  }

  void _saveUserDataInCache(UserModel? userModel) {
    if (userModel?.data == null) return;
    log("${userModel?.data.toString()}", name: "Save user data in cache");
    CacheHelper.saveData(
      key: "UserData",
      //? Take a look at [toString()] function in class UserModel.
      //? Convert [Map<String:dynamic>] to [string].
      value: userModel?.toString(),
    );
  }

  //* Function for user Login [POST user data to API]
  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    userPassword = password;
    CacheHelper.saveData(key: "Password", value: userPassword);
    emit(AuthLoadingState());
    if (!await hasConnection()) return emit(CheckConnectionState());
    await UserLoginService.fetchUserInformation(
      email: email,
      password: password,
    ).then((userInformation) {
      _userData.setUserData = userInformation;
      final userData = _userData.getUserData;
      _saveUserDataInCache(userData!);
      emit(LoginSuccessState(userModel: userData));
      log('Login Done');
    }).catchError((error) {
      log('Login Error');
      debugPrint(error);
      emit(AuthErrorState(error.toString()));
    });
  }

  //* Function for user Register [POST user data to API]
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    userPassword = password;
    CacheHelper.saveData(key: "Password", value: userPassword);
    emit(AuthLoadingState());
    if (!await hasConnection()) return emit(CheckConnectionState());
    await UserRegisterService.sendUserInformation(
      name: name,
      email: email,
      password: password,
      phone: phone,
    ).then((userInformation) {
      _userData.setUserData = userInformation;
      final userData = _userData.getUserData;
      _saveUserDataInCache(userData!);
      emit(RegisterSuccessState(userModel: userData));
      log('Register Done');
    }).catchError((error) {
      log('Register Error');
      debugPrint(error);
      emit(AuthErrorState(error.toString()));
    });
  }

  //* Fetch user authentication data
  void _fetchUserProfile() async {
    if (!await hasConnection()) return emit(CheckConnectionState());
    await UserProfileService.getUserProfileInformation()
        .then((userInformation) {
      _userData.setUserData = userInformation;
      final userData = _userData.getUserData;
      _saveUserDataInCache(userData!);
      log("status is ${userData.status}", name: "Fetch User Profile");
      log(userData.toString(), name: "Remote User Data");
    }).catchError((error) {
      log(error.toString());
      emit(ErrorUserDataState());
    });
  }

  //* Function for Pick photo from device
  File photoFromGallery = File("");
  Future pickPhoto({ImageSource imageSource = ImageSource.gallery}) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      photoFromGallery = File(image.path);
      log(photoFromGallery.toString());
      emit(ImagePickerState());
      final String imageBase64 = base64Encode(
        photoFromGallery.readAsBytesSync(),
      );
      //* Set user photo
      _updateUserProfileImageInServer(imageBase64);
    } catch (e) {
      log("$e", name: "Failed to pick image");
    }
  }

  //* PUT picked photo to API
  void _updateUserProfileImageInServer(String imageBase64) {
    final userData = _userData.getUserData;
    updateUserImage(
      name: userData!.data!.name,
      email: userData.data!.email,
      phone: userData.data!.phone,
      password: userPassword ?? "",
      newImageProfile: imageBase64,
    );
  }

  //* Function for Update user profila image [PUT user data to API]
  void updateUserImage({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String newImageProfile,
  }) async {
    if (!await hasConnection()) return emit(CheckConnectionState());
    await UpdateUserProfileImageService.updateUserProfileImage(
      name: name,
      email: email,
      password: password,
      phone: phone,
      image: newImageProfile,
    ).then(
      (userProfileData) {
        _userData.setUserData = userProfileData;
        final userData = _userData.getUserData;
        _saveUserDataInCache(userData!);
        emit(AuthSuccessState(userModel: userData));
        log("Update user photo successfully");
      },
    ).catchError((error) {
      log("Update user photo failed", name: "Error");
      debugPrint(error);
      emit(AuthErrorState(error.toString()));
    });
  }
}
