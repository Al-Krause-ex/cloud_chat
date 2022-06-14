part of 'chats_list_cubit.dart';

abstract class ChatsListState extends Equatable {
  final List<Chat> chats;
  final User user;

  const ChatsListState(this.chats, this.user);
}

class ChatsListInitial extends ChatsListState {
  const ChatsListInitial(super.chats, super.user);

  @override
  List<Object> get props => [chats, user];
}

class ChatsListLoading extends ChatsListState {
  const ChatsListLoading(super.chats, super.user);

  @override
  List<Object> get props => [chats, user];
}

class ChatsListLoaded extends ChatsListState {
  const ChatsListLoaded(super.chats, super.user);

  @override
  List<Object> get props => [chats, user];
}
