import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/domain/repositories/job_repository.dart";
import "package:qatjobs/features/job/data/models/job_model.codegen.dart";

@injectable
class GetAJobUseCase implements UseCase<List<JobModel>,NoParams>{
	final JobRepository _jobRepository;

	GetAJobUseCase({
		required JobRepository jobRepository,
}):_jobRepository =jobRepository;

	@override
	Future<Either<Failures,List<JobModel>>> call(NoParams params) async{
		return await _jobRepository.getAJob(params);
	}
}
