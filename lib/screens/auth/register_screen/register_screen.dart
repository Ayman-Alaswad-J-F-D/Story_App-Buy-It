import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/extensions.dart';
import '../../../app/functions/auth_alert_function.dart';
import '../../../app/functions/toast_snack_bar.dart';
import '../../../theme/colors.dart';
import '../../../widget/custom_snackbar.dart';
import '../cubit/auth_cubit.dart';
import '../widget/authorization_form_card.dart';
import 'components/register_bottom.dart';
import 'components/register_card_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController phoneController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          authAlertFunction(context: context, userModel: state.userModel);
        } else if (state is AuthErrorState) {
          toastSnackBar(
            context: context,
            text: state.error,
            backgroundColor: ToastStates.ERROR,
          );
        } else if (state is CheckConnectionState) {
          toastSnackBar(
            context: context,
            text: "Please check your conniction ..",
            backgroundColor: ToastStates.NORMAL,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: CircleAvatar(
                      backgroundColor: AppColors.whiteColor,
                      child: IconButton(
                        color: AppColors.primaryColor,
                        icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: () => context.back(),
                      ),
                    ),
                  ),
                ),
                AuthorizationFormCard(
                  formTitle: "Register",
                  isLoginScreen: false,
                  spaceBottom: 50,
                  formKey: formKey,
                  formCardInput: RegisterCardTextFormField(
                    formKey: formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                    nameController: nameController,
                    phoneController: phoneController,
                  ),
                  formButton: RegisterBotton(
                    formKey: formKey,
                    emailController: emailController,
                    passwordController: passwordController,
                    nameController: nameController,
                    phoneController: phoneController,
                    // state: state,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
