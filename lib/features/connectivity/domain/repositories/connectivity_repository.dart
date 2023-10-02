import 'package:qatjobs/features/connectivity/domain/entities/connectivity.codegen.dart';

abstract class ConnectivityRepository {
  Stream<InternetConnection> streamGetInternetConnectionStatus();
}
