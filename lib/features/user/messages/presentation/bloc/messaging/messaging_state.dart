part of 'messaging_bloc.dart';

class MessagingState extends Equatable {
  final List<ContactProfile> contacts;
  final ContactProfile currentContactProfile;
  final List<Message> currentConversation;

  const MessagingState({
    required this.contacts,
    required this.currentContactProfile,
    required this.currentConversation,
  });

  MessagingState copyWith({
    List<ContactProfile>? contacts,
    ContactProfile? currentContactProfile,
    List<Message>? currentConversation,
  }) {
    return MessagingState(
      contacts: contacts ?? this.contacts,
      currentContactProfile:
          currentContactProfile ?? this.currentContactProfile,
      currentConversation: currentConversation ?? this.currentConversation,
    );
  }

  @override
  List<Object?> get props =>
      [contacts, currentConversation, currentContactProfile];
}
