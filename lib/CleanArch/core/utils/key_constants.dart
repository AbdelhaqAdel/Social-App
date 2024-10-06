import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/features/auth/data/models/sign_up_model.dart';
import 'package:newapp/CleanArch/features/profile/data/models/user_model.dart';

String KLogo='assets/images/kLogo.png';
const String KMessagesCollection='messages';
const String KcreatedAt='createdAt';

const String kUsers='users';
const String kChatWith='chatwith';
const String kAllChats='allChats';








String uid='';
RegisterModel? userModel;
String userImage='';

UserModel? userData;

String? fcmToken;

late final GlobalKey<NavigatorState> navigatorKey;

  GlobalKey? scaffoldKey;

