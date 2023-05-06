import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

import '../errors/exceptions.dart';

class AppExceptionsHandler {
  static void onError(dynamic error, StackTrace stackTrace) {
    if (error is Error) {
      developer.log(
        'AppExceptionsHandler (onError): error ==> $error --||-- stackTrace ==> $stackTrace',
        name: 'AppExceptionsHandler.DART',
      );
    } else if (error is AppNetworkException) {
      developer.log(
        'AppExceptionsHandler (onError): error ==> $error --||-- stackTrace ==> $stackTrace',
        name: 'AppExceptionsHandler.Network',
      );
    } else if (error is AppDatabaseException) {
      developer.log(
        'AppExceptionsHandler (onError): error ==> $error --||-- stackTrace ==> $stackTrace',
        name: 'AppExceptionsHandler.Database',
      );
    } else if (error is AppAuthenticationException) {
      developer.log(
        'AppExceptionsHandler (onError): error ==> $error --||-- stackTrace ==> $stackTrace',
        name: 'AppExceptionsHandler.Authentication',
      );
    } else if (error is AppPlatformException) {
      developer.log(
        'AppExceptionsHandler (onError): error ==> $error --||-- stackTrace ==> $stackTrace',
        name: 'AppExceptionsHandler.Platform',
      );
    } else if (error is AppFileSystemException) {
      developer.log(
        'AppExceptionsHandler (onError): error ==> $error --||-- stackTrace ==> $stackTrace',
        name: 'AppExceptionsHandler.FileSystem',
      );
    } else {
      developer.log(
        'AppExceptionsHandler (onError): error ==> $error --||-- stackTrace ==> $stackTrace',
        name: 'AppExceptionsHandler.Other',
      );
    }
  }

  static void onFlutterError(FlutterErrorDetails details) {
    developer.log(
      'AppExceptionsHandler (onFlutterError): details ==> $details',
      name: 'AppExceptionsHandler.DART',
    );
  }

  static ZoneSpecification get zoneSpecification => ZoneSpecification(
        print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
          if (kReleaseMode) {
            developer.log(
              'AppExceptionsHandler (zoneSpecification): line ==> $line',
              name: 'AppExceptionsHandler.DART',
            );
          } else {
            parent.print(zone, line);
          }
        },
        handleUncaughtError: (
          Zone self,
          ZoneDelegate parent,
          Zone zone,
          Object error,
          StackTrace stackTrace,
        ) {
          developer.log(
            'AppExceptionsHandler (zoneSpecification): error ==> $error --||-- stackTrace ==> $stackTrace',
            name: 'AppExceptionsHandler.DART',
          );
        },
      );
}
