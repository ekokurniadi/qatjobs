import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/data/models/job_alerts_model.codegen.dart";
import "package:qatjobs/features/job/domain/repositories/job_repository.dart";

@injectable
class GetJobAlertUseCase implements UseCase<JobAlertsModel,NoParams>{
	 final JobRepository _jobRepository;

	const GetJobAlertUseCase(this._jobRepository);

	@override
	Future<Either<Failures,JobAlertsModel>> call(NoParams params) async{
		return await _jobRepository.getJobAlert(params);
	}
}
