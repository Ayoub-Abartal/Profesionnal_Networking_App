import 'package:flutter/material.dart';
import 'package:metin/features/swipe/presentation/widgets/profile_card.dart';
import 'package:metin/features/user/messages/presentation/screens/broadcast_screen.dart';
import 'package:metin/features/user/messages/presentation/widgets/message_tile.dart';

// ----------------- Solid gradient colors ------------------

List<LinearGradient> backgrounds = [
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF780206),
      Color(0xFF061161),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFFB3FFAB),
      Color(0xFF12FFF7),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFFAAFFA9),
      Color(0xFF11FFBD),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFFF0C27B),
      Color(0xFF4B1248),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF8EC5FC),
      Color(0xFFE0C3FC),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF485563),
      Color(0xFF29323c),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFFfe8c00),
      Color(0xFFf83600),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF00c6ff),
      Color(0xFF0072ff),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF70e1f5),
      Color(0xFFffd194),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF556270),
      Color(0xFFFF6B6B),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF9D50BB),
      Color(0xFF6E48AA),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFFFF4E50),
      Color(0xFFF9D423),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFFADD100),
      Color(0xFF7B920A),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFFFBD3E9),
      Color(0xFFBB377D),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFFC9FFBF),
      Color(0xFFFFAFBD),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF649173),
      Color(0xFFDBD5A4),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFFB993D6),
      Color(0xFF8CA6DB),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF870000),
      Color(0xFF190A05),
    ],
  ),
  const LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      Color(0xFF00d2ff),
      Color(0xFF3a7bd5),
    ],
  ),
];

// ----------------- Messages and broadcasts -----------------
ContactProfile userProfile = ContactProfile(
    name: "User",
    avatar: "assets/images/onBoarding/1.png",
    conversation: Conversation(messages: []),
    broadcasts: []);
Conversation rarkConvo = Conversation(
  messages: [
    Message(
      content: "Lorem Ipsum is simply dummy text. 8",
      sendTime: DateTime(2018),
      isSender: true,
      isRead: true,
    ),
    Message(
      content: "Lorem Ipsum is simply dummy text. 9",
      sendTime: DateTime(2019),
      isSender: true,
      isRead: true,
    ),
    Message(
      content: "Lorem Ipsum is simply dummy text. 10",
      sendTime: DateTime(2020),
      isSender: true,
      isRead: true,
    ),
    Message(
      content: "Lorem Ipsum is simply dummy text. 8",
      sendTime: DateTime(2018),
      isSender: false,
      isRead: true,
    ),
    Message(
      content: "Lorem Ipsum is simply dummy text. 9",
      sendTime: DateTime(2019),
      isSender: false,
      isRead: true,
    ),
    Message(
      content: "Lorem Ipsum is simply dummy text. 10",
      sendTime: DateTime(2020),
      isSender: false,
      isRead: false,
    ),
  ],
);

Conversation narkConvo = Conversation(
  messages: [
    Message(
      content: "Lorem Ipsum is simply dummy text. 8",
      sendTime: DateTime(2018),
      isSender: true,
      isRead: true,
    ),
    Message(
      content: "Lorem Ipsum is simply dummy text. 9",
      sendTime: DateTime(2019),
      isSender: true,
      isRead: true,
    ),
    Message(
      content: "Lorem Ipsum is simply dummy text. 10",
      sendTime: DateTime(2020),
      isSender: true,
      isRead: true,
    ),
    Message(
      content: "Lorem Ipsum is simply dummy text. 8",
      sendTime: DateTime(2018),
      isSender: false,
      isRead: true,
    ),
    Message(
      content: "Lorem Ipsum is simply dummy text. 9",
      sendTime: DateTime(2020),
      isSender: false,
      isRead: false,
    ),
    Message(
      content: "Lorem Ipsum is simply dummy text. 10",
      sendTime: DateTime(2021),
      isSender: false,
      isRead: false,
    ),
  ],
);

List<Broadcast> broadcasts = [
  Broadcast(
    url:
        'https://images.unsplash.com/photo-1604964432806-254d07c11f32?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80',
    mediaType: MediaType.image,
    duration: const Duration(seconds: 10),
  ),
  Broadcast(
    url:
        'https://static.videezy.com/system/resources/previews/000/005/529/original/Reaviling_Sjusj%C3%B8en_Ski_Senter.mp4',
    mediaType: MediaType.video,
    duration: const Duration(seconds: 0),
  ),
  Broadcast(
    url:
        'https://images.unsplash.com/photo-1522252234503-e356532cafd5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1025&q=80',
    mediaType: MediaType.image,
    duration: const Duration(seconds: 5),
  ),
];
List<ContactProfile> contacts = [
  ContactProfile(
      name: "User",
      avatar: "assets/images/onBoarding/1.png",
      conversation: Conversation(messages: []),
      broadcasts: []),
  ContactProfile(
    name: "Jessica Park",
    avatar: "assets/images/onBoarding/1.png",
    conversation: rarkConvo,
    broadcasts: broadcasts,
  ),
  ContactProfile(
    name: "Jessica CHark",
    avatar: "assets/images/onBoarding/2.png",
    conversation: narkConvo,
    broadcasts: [
      Broadcast(
        url: 'assets/images/onBoarding/3.png',
        mediaType: MediaType.image,
        duration: const Duration(seconds: 5),
      ),
      Broadcast(
        url: 'assets/images/onBoarding/3.png',
        mediaType: MediaType.image,
        duration: const Duration(seconds: 5),
      ),
    ],
  ),
  ContactProfile(
    name: "Jessica Mark",
    avatar: "assets/images/onBoarding/3.png",
    conversation: rarkConvo,
    broadcasts: broadcasts,
  ),
  ContactProfile(
    name: "Jessica Nark",
    avatar: "assets/images/onBoarding/1.png",
    conversation: narkConvo,
    broadcasts: broadcasts,
  ),
  ContactProfile(
    name: "Jessica Rark",
    avatar: "assets/images/onBoarding/2.png",
    conversation: rarkConvo,
    broadcasts: broadcasts,
  ),
];

// ----------------- enums -----------------

enum Permissions { contacts, notifications, location }

enum StartWeekDay { sunday, monday }

enum CalendarViews { dates, months, year }

enum LoginType { none, email, phone, facebook, google, linkedIn }

List<Profile> swipeProfiles = [
  const Profile(
      name: 'Rohini',
      age: 22,
      title: 'Software developer',
      city: 'Chicago',
      imageAsset: ['assets/images/onBoarding/2.png']),
  const Profile(
      name: 'Rohini',
      age: 22,
      title: 'Software developer',
      city: 'Chicago',
      imageAsset: ['assets/images/onBoarding/1.png']),
  const Profile(
      name: 'Rohini',
      age: 22,
      title: 'Software developer',
      city: 'Chicago',
      imageAsset: ['assets/images/onBoarding/3.png']),
  const Profile(
      name: 'Rohini',
      age: 22,
      title: 'Software developer',
      city: "Chicago",
      imageAsset: ['assets/images/onBoarding/2.png']),
  const Profile(
      name: 'Jessica Parker',
      age: 22,
      title: 'Software developer',
      city: 'Chicago',
      imageAsset: [
        'assets/images/onBoarding/1.png',
        'assets/images/onBoarding/2.png',
        'assets/images/onBoarding/3.png'
      ]),
];

// ----------------- OnBoarding Pages -----------------

const List<List<String>> onBoardingPages = [
  [
    'assets/images/onBoarding/1.png',
    'ALGORITHM',
    'Users going through a vetting process to ensure you never \nmatch with bots.'
  ],
  [
    'assets/images/onBoarding/2.png',
    'MATCHES',
    'We match you with people that have a large array \nof similar interests.'
  ],
  [
    'assets/images/onBoarding/3.png',
    'PREMIUM',
    'Sign up today and enjoy the first month of \npremium benefits on us.'
  ],
];

// ----------------- Metin Calendar -----------------
final List<String> monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

// ----------------- Profile Details -----------------
List<String> languages = [
  "English",
  "Chinese",
  "Spanish",
  "Hindi",
  "Bengali",
  "Portuguese",
  "Russian",
  "French",
  "Polish",
  "Burmese",
  "Moroccan Arabic",
  "Ukrainian",
  "Romanian"
];

const List<String> educationDegrees = [
  "High school",
  "Associate",
  "Licence",
  "Bachelor",
  "Master",
  "Engineer",
  "Doctoral (PHD)",
];

final List<String> interests = [
  'Designer',
  'Hiring people',
  'Marketer',
  'Photographer',
  'Developer',
  'Co-founding',
  'Job',
  'Consulting',
];

List<String> skills = [
  "HTML",
  "FLutter",
  "Java",
  "Python",
  "Web design",
  "PHP",
  "C++",
  "C#",
  "C",
  "System Administration",
  "Film Making"
];

List<String> industries = [
  "Computer science",
  "Software developpement",
  "Graphic design",
  "Sound and music",
  "Game develepment",
  "Tourism",
  "Commercial Real Estate",
  "HR & Recruitment Services"
];

// ----------------- Supported countries -----------------

const supportedLocals = [
  Locale("af"),
  Locale("ma"),
  Locale("am"),
  Locale("ar"),
  Locale("az"),
  Locale("be"),
  Locale("bg"),
  Locale("bn"),
  Locale("bs"),
  Locale("ca"),
  Locale("cs"),
  Locale("da"),
  Locale("de"),
  Locale("el"),
  Locale("en"),
  Locale("es"),
  Locale("et"),
  Locale("fa"),
  Locale("fi"),
  Locale("fr"),
  Locale("gl"),
  Locale("ha"),
  Locale("he"),
  Locale("hi"),
  Locale("hr"),
  Locale("hu"),
  Locale("hy"),
  Locale("id"),
  Locale("is"),
  Locale("it"),
  Locale("ja"),
  Locale("ka"),
  Locale("kk"),
  Locale("km"),
  Locale("ko"),
  Locale("ku"),
  Locale("ky"),
  Locale("lt"),
  Locale("lv"),
  Locale("mk"),
  Locale("ml"),
  Locale("mn"),
  Locale("ms"),
  Locale("nb"),
  Locale("nl"),
  Locale("nn"),
  Locale("no"),
  Locale("pl"),
  Locale("ps"),
  Locale("pt"),
  Locale("ro"),
  Locale("ru"),
  Locale("sd"),
  Locale("sk"),
  Locale("sl"),
  Locale("so"),
  Locale("sq"),
  Locale("sr"),
  Locale("sv"),
  Locale("ta"),
  Locale("tg"),
  Locale("th"),
  Locale("tk"),
  Locale("tr"),
  Locale("tt"),
  Locale("uk"),
  Locale("ug"),
  Locale("ur"),
  Locale("uz"),
  Locale("vi"),
  Locale("zh")
];
