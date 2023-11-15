import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/about/data/models/about_model.codegen.dart";

abstract class AboutRemoteDataSource {
	Future<Either<Failures,List<AboutModel>>> getAbout(NoParams params);
}
