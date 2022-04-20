import 'package:bugs_scanner/services/bugs_pdf_service.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  locatorSetupName: 'bugsscannerDependencyInit',
  locatorName: 'bsLocator',
  routes: [],
  dependencies: [
    LazySingleton(
      classType: NavigationService,
    ),
    LazySingleton(
      classType: BugsPDFService,
    ),
  ],
)
class App {}
