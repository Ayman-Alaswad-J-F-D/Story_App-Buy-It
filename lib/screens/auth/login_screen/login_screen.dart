import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/functions/auth_alert_function.dart';
import '../../../app/functions/toast_snack_bar.dart';
import '../../../theme/colors.dart';
import '../../../widget/custom_snackbar.dart';
import '../cubit/auth_cubit.dart';
import '../widget/authorization_form_card.dart';
import 'components/login_bottom.dart';
import 'components/login_card_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
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
            child: AuthorizationFormCard(
              formTitle: "Login",
              formKey: formKey,
              spaceTop: 30,
              formCardInput: LoginCardTextFormField(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
              ),
              formButton: LoginBotton(
                formKey: formKey,
                emailController: emailController,
                passwordController: passwordController,
                // state: state,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
