part of 'data_cubit.dart';

abstract class DataState extends Equatable {
  final User user;
  const DataState(this.user);
}

class DataInitial extends DataState {
  const DataInitial(super.user);

  @override
  List<Object> get props => [user];
}

class DataAuth extends DataState {
  const DataAuth(super.user);

  @override
  List<Object> get props => [user];
}
