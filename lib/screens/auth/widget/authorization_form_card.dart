import 'package:flutter/material.dart';

import '../../../app/extensions.dart';
import '../../../theme/styles.dart';
import '../login_screen/components/login_another_account.dart';
import '../register_screen/register_screen.dart';

class AuthorizationFormCard extends StatelessWidget {
  const AuthorizationFormCard({
    Key? key,
    required this.formTitle,
    required this.formKey,
    required this.formCardInput,
    required this.formButton,
    this.spaceBottom = 20,
    this.spaceTop = 60,
    this.isLoginScreen = true,
  }) : super(key: key);

  final String formTitle;
  final GlobalKey<FormState> formKey;
  final Widget formCardInput;
  final Widget formButton;
  final double spaceBottom;
  final double spaceTop;
  final bool isLoginScreen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: spaceTop),
        Text(
          formTitle,
          style: TextStyles.pacifico55WhiteRegular,
        ),
        const SizedBox(height: 60),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Text(
                    '$formTitle now to browse our hot offers',
                    style: TextStyles.pacifico15LightPrimaryRegular,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: formCardInput,
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    child: formButton,
                  ),
                  SizedBox(height: spaceBottom),
                  if (isLoginScreen)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Flexible(
                              child: Text(
                                'Don\'t have an accuont ?',
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Flexible(
                              child: TextButton(
                                onPressed: () => context.toScreen(
                                  screen: const RegisterScreen(),
                                ),
                                child: const Text(
                                  'Register',
                                  style: TextStyles
                                      .font14SecondPrimaryRegularUnderline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Divider(
                                indent: 15,
                                endIndent: 20,
                                color: Colors.black38,
                              ),
                            ),
                            Text('or'),
                            Expanded(
                              child: Divider(
                                indent: 20,
                                endIndent: 15,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
                        const LoginAnotherAccount(),
                        const SizedBox(height: 10),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
