import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {
	String get errorMessage;
	@override
	List<Object> get props => [errorMessage];
}

class ServerFailure extends Failures {
	final String errorMessage;

	ServerFailure({required this.errorMessage});

	@override
	List<Object> get props => [errorMessage];
}

class DatabaseFailure extends Failures {
	final String errorMessage;

	DatabaseFailure({required this.errorMessage});

	@override
	List<Object> get props => [errorMessage];

}