import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  locatorSetupName: 'bugsscannerDependencyInit',
  locatorName: 'bsLocator',
  routes: [],
  dependencies: [
    LazySingleton(
      classType: NavigationService,
    )
  ],
)
class App {}
