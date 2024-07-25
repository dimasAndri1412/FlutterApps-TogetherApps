import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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

//GoogleMapController
final nameLocationController = TextEditingController();
final locationNamesController = TextEditingController();
final historyClockInController = TextEditingController();
final localityLocationController = TextEditingController();
final SubLocalityLocationController = TextEditingController();
final StreetLocationController = TextEditingController();
final SearchLocationController = TextEditingController();
final stateLocationController = TextEditingController();
final subStateLocationController = TextEditingController();
final latitudeLocationController = TextEditingController();
final longtitudeLocationController = TextEditingController();
final postalCodeController = TextEditingController();
final radiusController = TextEditingController();
late GoogleMapController mapControllers;
late StreamSubscription<LocationData>? locationSubscriptions;
final Set<Marker> initMarkers = {};
final Set<Marker> initMarkerLocation = {};
final Location locationController = new Location();
LatLng? currentPosition = null;
CameraPosition? cameraPosition = null;
Set<Circle> circless = {};

//LocationField
final locationFieldController = TextEditingController();
final userNameLocationFieldController = TextEditingController();
final projectLocationFieldController = TextEditingController();
final shiftLOcationFieldController = TextEditingController();
final fullNamesLocationController = TextEditingController();
final noteLocationController = TextEditingController();
final avatarUrlController = TextEditingController();
String avatarURLs = '';

//ElapsedTime
final elapsedTimesController = TextEditingController();


//ElapsedTimeKey
final GlobalKey<FormState> gmapsElapsedTimeKey = GlobalKey<FormState>();

//gmapsConfirmKey
final GlobalKey<FormState>gmapsConfirmKey = GlobalKey<FormState>();

//gmaps
final GlobalKey<FormState>GoogleMapsForm = GlobalKey<FormState>();

//Key ForgotPassword
final GlobalKey<FormState>formsForgotKeys = GlobalKey<FormState>();

//OTP Key
final GlobalKey<FormState>otpFormsKeys = GlobalKey<FormState>();

//emailOTP
final GlobalKey<FormState>emailFormOtp = GlobalKey<FormState>();