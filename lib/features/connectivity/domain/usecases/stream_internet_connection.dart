import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/stream_usecase.dart';
import 'package:qatjobs/features/connectivity/domain/entities/connectivity.codegen.dart';
import 'package:qatjobs/features/connectivity/domain/repositories/connectivity_repository.dart';

@injectable
class StreamInternetConnection
    extends StreamUseCaseNoParams<InternetConnection> {
  const StreamInternetConnection(this._connectivityRepository);
  final ConnectivityRepository _connectivityRepository;

  @override
  Stream<InternetConnection> call() async* {
    yield* _connectivityRepository.streamGetInternetConnectionStatus();
  }
}
