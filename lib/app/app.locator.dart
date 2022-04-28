// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../../../../services/bugs_pdf_service.dart';

final bsLocator = StackedLocator.instance;

void bugsscannerDependencyInit(
    {String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  bsLocator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  bsLocator.registerLazySingleton(() => NavigationService());
  bsLocator.registerLazySingleton(() => BugsPDFService());
}
