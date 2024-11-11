import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

//Login Controller
final formKey = new GlobalKey<FormState>();
final formOTKey = new GlobalKey<FormState>();
final formOTKeyShifting = new GlobalKey<FormState>();
final TextEditingController passwordController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController projectController = TextEditingController();

//Keys
final GlobalKey<FormState> formKeys = GlobalKey<FormState>();
final GlobalKey<FormState> formsKeys = GlobalKey<FormState>();
final GlobalKey<FormState> DropDownButtonsKeys = GlobalKey<FormState>();
final GlobalKey<FormState> formKeys_ = GlobalKey<FormState>();
final GlobalKey<FormState> formKeyss_ = GlobalKey<FormState>();

//Paid Leave Controller
final TextEditingController namePaidLeave = TextEditingController();
final TextEditingController projectPaidLeave = TextEditingController();
final TextEditingController positionPaidLeave = TextEditingController();
final TextEditingController departmentPaidLeave = TextEditingController();
final TextEditingController typePaidLeave = TextEditingController();
final TextEditingController reasonPaidLeave = TextEditingController();
final TextEditingController picPaidLeave = TextEditingController();
final TextEditingController phonePaidLeave = TextEditingController();
final TextEditingController shiftPaidLeave = TextEditingController();
final TextEditingController startDatePaidLeave = TextEditingController();
final TextEditingController endDatePaidLeave = TextEditingController();
final TextEditingController onDutyPaidLeave = TextEditingController();
final TextEditingController statusPaidLeave = TextEditingController();
final TextEditingController leave_used = TextEditingController();
final TextEditingController remaining_leave = TextEditingController();
final TextEditingController reason_rejectedController = TextEditingController();

//overtime controller
final TextEditingController nameOTController = TextEditingController();
final TextEditingController locationOTController = TextEditingController();
final TextEditingController projectOTController = TextEditingController();
final TextEditingController positionOTController = TextEditingController();
final TextEditingController departmentOTController = TextEditingController();
final TextEditingController shiftOTController = TextEditingController();
final TextEditingController dateOTController = TextEditingController();
final TextEditingController timeStartOTController = TextEditingController();
final TextEditingController timeEndOTController = TextEditingController();
final TextEditingController activityOTController = TextEditingController();
final TextEditingController statusOTController = TextEditingController();
final TextEditingController reason_OTrejectedController =
    TextEditingController();

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
final UserIdController = TextEditingController();
final FaceImageController = TextEditingController();
final EmbeddingController = TextEditingController();
final IdMemberControllers = TextEditingController();

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
final shiftLocationFieldController = TextEditingController();
final avatarPicUrlController = TextEditingController();
late GoogleMapController mapControllers;
late StreamSubscription<LocationData>? locationSubscriptions;
final Set<Marker> initMarkers = {};
final Set<Marker> initMarkerLocation = {};
final Location locationController = new Location();
LatLng? currentPosition = null;
ValueNotifier<LatLng?> newPositionNotfier = ValueNotifier(null);
CameraPosition? cameraPosition = null;
Set<Circle> circless = {};

//imagePath
Set<NetworkImage> getImagesPaths = {};

//LocationField
final locationFieldController = TextEditingController();
final userNameLocationFieldController = TextEditingController();
final projectLocationFieldController = TextEditingController();
final shiftLOcationFieldController = TextEditingController();
final fullNamesLocationController = TextEditingController();
final noteLocationController = TextEditingController();
final avatarUrlController = TextEditingController();
final historyController = TextEditingController();
String avatarURLs = '';

// clock-in
final locationClockIn = TextEditingController();
final shiftController = TextEditingController();
final notesClockIn = TextEditingController();
final clockInImageController = TextEditingController();
final notesClockInController = TextEditingController();
final shiftClockOutController = TextEditingController();
final clockInController = TextEditingController();
final notesClcokOutController = TextEditingController();
final clockInDateToDayController = TextEditingController();

//clock-out
final clockOutImageController = TextEditingController();
final notesClockOut = TextEditingController();
final locationClockOut = TextEditingController();

//ElapsedTime
final elapsedTimesController = TextEditingController().obs;

//questions
final positionId = TextEditingController();
final questionText = TextEditingController();
final positionName = TextEditingController();
final Map<String, TextEditingController> answerController = {};
List<TextEditingController> selectedQuestionControllers = [];
List<TextEditingController> selectedPlatformControllers = [];
List<TextEditingController> answersControllers = [];

Map<String, TextEditingController> controlersss = {
    "projectController": TextEditingController(),
    "locationController": TextEditingController(),
};

//projectContollersAddLoc
final List<Map<String, TextEditingController>> projectControllerss = [];

//mapsContollersSetting
final GlobalKey<FormState> mapsContollerSettingsKey = GlobalKey<FormState>();

//revampOTPController
final revampOTPControllers = TextEditingController();
final emailValuesControllers = TextEditingController();

final GlobalKey<FormState> questionKey = GlobalKey<FormState>();

//revampOTPKey
final GlobalKey<FormState> revampOTPScreenKey = GlobalKey<FormState>();

//ElapsedTimeKey
final GlobalKey<FormState> gmapsElapsedTimeKey = GlobalKey<FormState>();

//gmapsConfirmKey
final GlobalKey<FormState> gmapsConfirmKey = GlobalKey<FormState>();

//gmaps
final GlobalKey<FormState> GoogleMapsForm = GlobalKey<FormState>();

//gmapsConfirmKey
final GlobalKey<FormState> gmapsClockConfirmKey = GlobalKey<FormState>();

//Key ForgotPassword
final GlobalKey<FormState> formsForgotKeys = GlobalKey<FormState>();

//OTP Key
final GlobalKey<FormState> otpFormsKeys = GlobalKey<FormState>();

//emailOTP
final GlobalKey<FormState> emailFormOtp = GlobalKey<FormState>();
