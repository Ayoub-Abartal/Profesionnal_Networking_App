import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:metin/core/constants.dart';
import 'package:metin/features/user/messages/presentation/widgets/message_tile.dart';

part 'messaging_event.dart';
part 'messaging_state.dart';

class MessagingBloc extends Bloc<MessagingEvent, MessagingState> {
  MessagingBloc()
      : super(
          MessagingState(
            contacts: contacts,
            currentContactProfile: ContactProfile(
              avatar: '',
              broadcasts: [],
              conversation: Conversation(
                messages: [],
              ),
              name: '',
            ),
            currentConversation: const [],
          ),
        ) {
    on<SendMessageToContact>((event, emit) {
      emit(state.copyWith(
          currentConversation: List.of(state.currentConversation.toList())
            ..add(event.message)));
    });

    on<LoadContactConversation>((event, emit) {
      emit(state.copyWith(
          currentContactProfile: event.profile,
          currentConversation: event.profile.conversation.messages));
    });
  }
}
