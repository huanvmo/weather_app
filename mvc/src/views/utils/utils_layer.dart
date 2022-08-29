library utils_layer;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/account_management/account/accout_route.dart';
import '../../presentation/account_management/account_list/account_list_route.dart';
import '../../presentation/account_management/account_update/account_update_route.dart';
import '../../presentation/detail/detail_route.dart';
import '../../presentation/favorites/favorites_list_screen_route.dart';
import '../../presentation/login_and_signup/forgot_password/forgot_password_route.dart';
import '../../presentation/login_and_signup/index/login_signup_index_route.dart';
import '../../presentation/login_and_signup/login_with_email/login_route.dart';
import '../../presentation/login_and_signup/signup_with_email/signup_route.dart';
import '../../presentation/main/home/home_screen_route.dart';
import '../../presentation/main/main_route.dart';
import '../../presentation/main/news/news_add/news_add_route.dart';
import '../../presentation/main/news/news_detail/news_detail_route.dart';
import '../../presentation/main/news/news_list/news_list_route.dart';
import '../../presentation/main/news/news_management/news_management_route.dart';
import '../../presentation/main/news/news_update/news_update_route.dart';
import '../../presentation/main/search/search_route.dart';
import '../../presentation/settings/settings_route.dart';
import '../../presentation/splash/splash_screen_route.dart';

import '../data/country/country_data.dart';
import '../data/firebase/firebase_layer.dart';
import '../data/weather/weather_data.dart';
import '../domain/country/country_domain.dart';
import '../domain/weather/weather_domain.dart';

part 'di/injection.dart';
part 'route/app_routing.dart';
part 'manager/share_pref_manager.dart';
part 'other/session_utils.dart';
