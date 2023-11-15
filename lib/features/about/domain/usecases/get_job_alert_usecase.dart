import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/about/domain/repositories/about_repository.dart";
import "package:qatjobs/features/about/data/models/about_model.codegen.dart";

@injectable
class GetAboutUseCase implements UseCase<List<AboutModel>, NoParams> {
  final AboutRepository _aboutRepository;

  GetAboutUseCase({
    required AboutRepository aboutRepository,
  }) : _aboutRepository = aboutRepository;

  @override
  Future<Either<Failures, List<AboutModel>>> call(NoParams params) async {
    return await _aboutRepository.getAbout(params);
  }
}
