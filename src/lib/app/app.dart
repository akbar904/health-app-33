import 'package:my_app/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:my_app/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:my_app/features/home/home_view.dart';
import 'package:my_app/features/startup/startup_view.dart';
import 'package:my_app/features/auth/login_view.dart';
import 'package:my_app/features/auth/register_view.dart';
import 'package:my_app/features/patient/patient_list_view.dart';
import 'package:my_app/features/patient/patient_details_view.dart';
import 'package:my_app/features/patient/add_patient_view.dart';
import 'package:my_app/features/diagnosis/diagnosis_list_view.dart';
import 'package:my_app/features/diagnosis/diagnosis_details_view.dart';
import 'package:my_app/features/diagnosis/add_diagnosis_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/services/auth_service.dart';
import 'package:my_app/services/patient_service.dart';
import 'package:my_app/services/diagnosis_service.dart';
import 'package:my_app/services/appwrite_service.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: PatientListView),
    MaterialRoute(page: PatientDetailsView),
    MaterialRoute(page: AddPatientView),
    MaterialRoute(page: DiagnosisListView),
    MaterialRoute(page: DiagnosisDetailsView),
    MaterialRoute(page: AddDiagnosisView),
  ],
  dependencies: [
    InitializableSingleton(classType: AppwriteService),
    InitializableSingleton(classType: AuthService),
    InitializableSingleton(classType: PatientService),
    InitializableSingleton(classType: DiagnosisService),
    InitializableSingleton(classType: NavigationService),
    InitializableSingleton(classType: DialogService),
    InitializableSingleton(classType: BottomSheetService),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
  ],
)
class App {}
