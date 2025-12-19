import 'package:cei_mobile/common_widgets/app_logo.dart';
import 'package:cei_mobile/common_widgets/scaffold_bg_widget.dart';
import 'package:cei_mobile/core/constants/app_constants.dart';
import 'package:cei_mobile/core/constants/assets_constants.dart';
import 'package:cei_mobile/core/routes/app_router.dart';
import 'package:cei_mobile/core/theme/app_colors.dart';
import 'package:cei_mobile/core/theme/app_text_styles.dart';
import 'package:cei_mobile/core/utils/common.dart' show DigitLengthLimitingTextInputFormatter, IvoryCoastPhoneFormatter;
import 'package:cei_mobile/main.dart';
import 'package:cei_mobile/repository/auth_repository.dart' show registerApi;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nb_utils/nb_utils.dart';

class RegisterStep3Screen extends StatefulWidget {
  final String phoneNumber;
  const RegisterStep3Screen({super.key, required this.phoneNumber});

  @override
  State<RegisterStep3Screen> createState() => _RegisterStep3ScreenState();
}

class _RegisterStep3ScreenState extends State<RegisterStep3Screen> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController lastNameCont = TextEditingController();
  TextEditingController firstNameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController phoneNumberCont = TextEditingController();

  FocusNode lastNameFocus = FocusNode();
  FocusNode firstNameFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode phoneNumberFocus = FocusNode();

  void _register() async {
    try {
      appStore.setLoading(true);
      final data = {
        'email': emailCont.text,
        'plainPassword': passwordCont.text,
        'firstName': firstNameCont.text,
        'lastName': lastNameCont.text,
        'phoneNumber': phoneNumberCont.text.removeAllWhiteSpace(),
        'username': phoneNumberCont.text.removeAllWhiteSpace(),
      };
      final registerResult = await registerApi(data);
      final loginResult = await apiClient.login(phoneNumberCont.text.removeAllWhiteSpace(), passwordCont.text);
      userStore.loadUserFromJson(loginResult['data']);
      await setValue(AppConstants.authTokenKey, tokenManager.token);
      await setValue(AppConstants.refreshTokenKey, tokenManager.refreshToken);
      appStore.setLoggedIn(true);
      context.go(AppRoutes.homePath);
    } catch (e) {
      toast('$e');
    } finally {
      appStore.setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldBgWidget(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        // Use SafeArea to respect system UI
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        30.height, // Reduced from 100 to give more space
                        Image.asset(
                          AssetConstants.logo,
                          height: 80,
                        ),
                        Text("Informations",
                            style: boldTextStyle(
                                size: 36, letterSpacing: 2, color: Colors.black)),
                        Text("Personnelles",
                            style: boldTextStyle(
                              size: 36,
                              letterSpacing: 2,
                              color: Colors.black,
                            )),
                        50.height,
                        const Text(
                          'Nom',
                          style: AppTextStyles.body2,
                        ),
                        AppTextField(
                          controller: lastNameCont,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          textFieldType: TextFieldType.NAME,
                        ),
                        16.height,
                        const Text(
                          'Prénom(s)',
                          style: AppTextStyles.body2,
                        ),
                        AppTextField(
                          controller: firstNameCont,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          textFieldType: TextFieldType.NAME,
                        ),
                        16.height,
                        const Text(
                          'Email',
                          style: AppTextStyles.body2,
                        ),
                        AppTextField(
                          controller: emailCont,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          textFieldType: TextFieldType.EMAIL,
                        ),
                        16.height,
                        const Text(
                          'Contact',
                          style: AppTextStyles.body2,
                        ),
                        IntlPhoneField(
                          languageCode: "fr",
                          decoration: const InputDecoration(
                            hintText: '0102030405',
                            border: OutlineInputBorder(),
                          ),
                          initialCountryCode: 'CI',
                          controller: phoneNumberCont,
                          searchText: 'Rechercher',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),
                        // AppTextField(
                        //   controller: phoneNumberCont,
                        //   decoration: const InputDecoration(
                        //     hintText: '0102030405',
                        //     border: OutlineInputBorder(),
                        //   ),
                        //   inputFormatters: [
                        //     DigitLengthLimitingTextInputFormatter(11),
                        //     IvoryCoastPhoneFormatter()
                        //   ],
                        //   textFieldType: TextFieldType.PHONE,
                        // ),
                        16.height,
                        const Text(
                          'Mot de passe',
                          style: AppTextStyles.body2,
                        ),
                        AppTextField(
                          controller:
                              passwordCont, // Changed from emailCont to passwordCont
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value!.length < 8)  {
                              return 'Le mot de passe doit contenir au moins 8 caractères';
                            } else {
                              return null;
                            }
                          },
                          textFieldType: TextFieldType.PASSWORD,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Vous avez déjà un compte? ',
                            style: boldTextStyle(),
                          ),
                          TextButton(
                            onPressed: () {
                              context.go(AppRoutes.loginPath);
                            },
                            child: Text(
                              "Se connecter",
                              style: boldTextStyle(color: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                      Observer(builder: (builder) {
                        return AppButton(
                          width: context.width(),
                          shapeBorder:
                          RoundedRectangleBorder(borderRadius: radius()),
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              _register();
                            }
                          },
                          elevation: 0.0,
                          color: AppColors.primary,
                          child: appStore.isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                            padding: EdgeInsets.zero,
                          )
                              : Text('Terminer',
                              style: boldTextStyle(color: Colors.white)),
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
