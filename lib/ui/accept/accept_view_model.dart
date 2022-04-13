import 'package:bugs_scanner/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AcceptViewModel extends BaseViewModel {
  final NavigationService _navigationService = bsLocator<NavigationService>();

  void cancel() {
    _navigationService.back(result: false);
  }

  void accept() {
    _navigationService.back(result: true);
  }
}
