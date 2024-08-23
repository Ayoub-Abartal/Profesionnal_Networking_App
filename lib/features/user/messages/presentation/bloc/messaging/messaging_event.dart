part of 'messaging_bloc.dart';

abstract class MessagingEvent extends Equatable {
  const MessagingEvent();

  @override
  List<Object> get props => [];
}

class LoadContactConversation extends MessagingEvent {
  final ContactProfile profile;
  const LoadContactConversation({required this.profile});

  @override
  List<Object> get props => [profile];
}

class SendMessageToContact extends MessagingEvent {
  final Message message;
  const SendMessageToContact({required this.message});

  @override
  List<Object> get props => [message];
}

/// This event is not gonna be used now until we implement the messaging functionality
/// of the app.
/// This event will handle updating the conversation with the upcoming messages and
/// sending notification to the user.
class ReceiveMessageFromContact extends MessagingEvent {
  final Message message;
  const ReceiveMessageFromContact({required this.message});

  @override
  List<Object> get props => [message];
}
