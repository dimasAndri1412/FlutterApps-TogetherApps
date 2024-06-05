import 'package:flutter/cupertino.dart';

//Login Controller
final formKey = new GlobalKey<FormState>();
final TextEditingController passwordController = TextEditingController();
final TextEditingController emailController = TextEditingController();

//Keys
final GlobalKey<FormState>formKeys = GlobalKey<FormState>();
final GlobalKey<FormState>formsKeys = GlobalKey<FormState>();
final GlobalKey<FormState>DropDownButtonsKeys = GlobalKey<FormState>();

//Controller
final UserNameController = TextEditingController();
final FullNameController = TextEditingController();
final AddressController = TextEditingController();
final PhoneNumbersController = TextEditingController();
final EmailController = TextEditingController();
final OTPController = TextEditingController();
final TextEditingController BirthDateController = TextEditingController();
final RolesController = TextEditingController();
final NewPasswordContorller = TextEditingController();
final NewConfPasswordController = TextEditingController();
final loginFlageController = TextEditingController();
final PassController = TextEditingController();
final IDController = TextEditingController();
final ConfPassController = TextEditingController();
final ProjectController = TextEditingController();

//Key ForgotPassword
final GlobalKey<FormState>formsForgotKeys = GlobalKey<FormState>();

//OTP Key
final GlobalKey<FormState>otpFormsKeys = GlobalKey<FormState>();

//emailOTP
final GlobalKey<FormState>emailFormOtp = GlobalKey<FormState>();