import 'package:req_sys_finale/features/documents/pages/add_document.dart';
import 'package:req_sys_finale/features/home/model/requisition.dart';
import 'package:req_sys_finale/features/auth/handlers/auth_handler.dart';
import 'package:req_sys_finale/features/auth/pages/email_verification.dart';
import 'package:req_sys_finale/features/auth/pages/forgot_password.dart';
import 'package:req_sys_finale/features/home/pages/admin_home_screen.dart';
import 'package:req_sys_finale/features/home/pages/user_home_screen.dart';
import 'package:req_sys_finale/features/manage_profile/pages/manage_profile_screen.dart';
import 'package:req_sys_finale/features/requisition_details/pages/requisition_details.dart';
import 'package:req_sys_finale/features/shift/pages/add_user_shift.dart';
import 'package:req_sys_finale/features/shift/pages/edit_shift.dart';
import 'package:req_sys_finale/features/welcome/pages/onboard.dart';
import 'package:req_sys_finale/features/welcome/pages/splash.dart';
import 'package:req_sys_finale/features/workers/pages/add_user.dart';
import 'package:req_sys_finale/features/workers/pages/view_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../features/auth/pages/email_verification_success.dart';
import '../../features/auth/pages/login_page.dart';
import '../../features/auth/pages/resend_reset_email_screen.dart';
import '../../features/manage_profile/pages/edit_profile.dart';
import '../../features/manage_profile/pages/update_password.dart';
import '../../features/notes/pages/add_notes.dart';
import '../../features/manage_profile/models/user_profile.dart';

class RoutesHelper {
  static String welcomeScreen = '/welcome';
  static String initialScreen = "/";
  static String splashScreen = "/splash";
  static String emailVerificationScreen = "/verifyEmail";
  static String successfulVerificationScreen = "/verified";
  static String loginScreen = '/login';
  static String forgotPasswordScreen = '/forgotPassword';
  static String resendVerificationEmailScreen = '/resendVerificationEmail';
  static String adminHomeScreen = '/adminHome';
  static String userHomeScreen = '/userHome';
  static String adminStaffStatsScreen = '/adminStaffStats';
  static String adminShiftStatsScreen = '/adminShiftStats';
  static String adminAddUserScreen = '/addUser';
  static String viewUserScreen = '/viewUsers';
  static String userProfileScreen = '/profile';
  static String editUserProfileScreen = '/editProfile';
  static String updatePasswordScreen = '/editProfile';
  static String addHoursWorkedScreen = '/addHoursWorkedScreen';
  static String addDocumentsScreen = '/addDocumentsScreen';
  static String addNotesScreen = '/addNotesScreen';
  static String editShiftScreen = '/editShift';
  static String addRequisitionScreen = '/addRequisition';
  static String addUserFeedbackScreen = '/addFeedback';
  static String seeUserFeedbackScreen = '/seeUserFeedback';
  static String requisitionDetailsScreen = '/requsitionDetails';

  static List<GetPage> routes = [
    GetPage(name: welcomeScreen, page: () => WelcomePage()),
    GetPage(name: initialScreen, page: () => const AuthHandler()),
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(
        name: emailVerificationScreen,
        page: () {
          final user = Get.arguments as User;

          return EmailVerificationScreen(user: user);
        }),
    GetPage(
        name: resendVerificationEmailScreen,
        page: () {
          final String email = Get.arguments as String;

          return ResendResetEmailScreen(email: email);
        }),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(
        name: updatePasswordScreen, page: () => const UpdatePasswordScreen()),
    GetPage(name: adminHomeScreen, page: () => const AdminHomeScreen()),
    GetPage(
        name: userProfileScreen,
        page: () {
          final String email = Get.arguments as String;

          return UserProfileScreen(profileEmail: email);
        }),
    GetPage(
        name: editUserProfileScreen,
        page: () {
          final UserProfile userProfile = Get.arguments as UserProfile;

          return EditUserProfileScreen(userProfile: userProfile);
        }
        ),
    GetPage(name: adminAddUserScreen, page: () => const AdminAddUser()),

    GetPage(
        name: addDocumentsScreen,
        page: () {
          final args = Get.arguments as List;
          final UserProfile selectedUser = args[0] as UserProfile;

          return AddDocumentScreen(selectedUser: selectedUser);
        }),
    GetPage(
        name: addNotesScreen,
        page: () {
          final args = Get.arguments as List;
          final UserProfile selectedUser = args[0] as UserProfile;

          return AddNotesScreen(selectedUser: selectedUser);
        }),
    GetPage(
        name: requisitionDetailsScreen,
        page: () {
          final args = Get.arguments as List;
          final Requisition selectedRequisition = args[0] as Requisition;
          final UserProfile currentUser = args[1] as UserProfile;

          return RequisitionDetailsScreen(requisition: selectedRequisition, userProfile: currentUser,);
        }),
    GetPage(
        name: editShiftScreen,
        page: () {
          final args = Get.arguments as List;
          final UserProfile selectedUser = args[0] as UserProfile;
          final Requisition req = args[1] as Requisition;

          return EditUserRequisition(selectedUser: selectedUser, requisition: req);
        }),
    GetPage(
        name: addRequisitionScreen,
        page: () {
          final args = Get.arguments as List;
          final UserProfile selectedUser = args[0] as UserProfile;
          return AddRequisition(selectedUser: selectedUser,);
        }),
    GetPage(name: viewUserScreen, page: () => const AdminViewUsers()),
    GetPage(name: userHomeScreen, page: () => const UserHomeScreen()),
    GetPage(
        name: successfulVerificationScreen,
        page: () => const AccountVerificationSuccessful()),
    GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen()),

  ];
}
