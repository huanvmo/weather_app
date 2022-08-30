library firebase_layer;

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart' as path;

import '../favorites/favorites_model.dart';
import 'firebase_layer.dart';

export 'models/news/news_model.dart';
export 'models/users/users_model.dart';

part 'cloud_firestore_services/favorites_database_service.dart';

part 'cloud_firestore_services/news_database_service.dart';

part 'cloud_firestore_services/users_database_services.dart';

part 'firebase_auth_service/login_signup_service.dart';
