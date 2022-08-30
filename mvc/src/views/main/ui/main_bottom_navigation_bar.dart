import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/config/app_colors.dart';
import 'package:weather_app/config/app_text_style.dart';
import 'package:weather_app/domain/country/country_domain.dart';
import 'package:weather_app/generated/l10n.dart';
import 'package:weather_app/presentation/account_management/account/bloc/account_bloc.dart';
import 'package:weather_app/presentation/account_management/account/ui/account_screen.dart';
import 'package:weather_app/presentation/main/news/news_list/bloc/news_list_bloc.dart';
import 'package:weather_app/presentation/main/news/news_list/ui/news_list_screen.dart';

import '../../../controller/home/home_bloc.dart';
import '../../../models/firebase/firebase_layer.dart';
import '../../utils/utils_layer.dart';
import '../home/home_screen.dart';
import '../../../controller/search/search_bloc.dart';
import '../search/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ValueNotifier<int> _selectedIndex = ValueNotifier(0);
  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    SearchScreen(),
    NewsListScreen(),
    const AccountScreen(),
  ];

  void _onItemTapped(int index) {
    _selectedIndex.value = index;

    _tabController.animateTo(index);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: _widgetOptions.length);
    _tabController.addListener(() {
      _selectedIndex.value = _tabController.index;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length: _widgetOptions.length,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AccountBloc(
                  services: getIt<UsersDBServices>(),
                )..add(
                    AccountLoadEvent(),
                  ),
              ),
              BlocProvider(
                create: (context) => NewsListBloc(
                  services: getIt<NewsDBServices>(),
                )..add(
                    NewsListLoadEvent(),
                  ),
              ),
              BlocProvider(
                create: (context) => SearchBloc(

                  services: getIt<FavoritesDBServices>(),
                )..add(
                    SearchLoadEvent(),
                  ),
              ),
              BlocProvider(
                create: (context) => HomeBloc(

                )..add(
                    HomeLoadEvent(),
                  ),
              ),
            ],
            child: TabBarView(
              controller: _tabController,
              children: _widgetOptions,
            ),
          )),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _selectedIndex,
        builder: (_, __, ___) => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.home,
              ),
              label: S.current.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.search,
              ),
              label: S.current.search,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.newspaper,
              ),
              label: S.current.news,
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.person,
              ),
              label: S.current.account,
            ),
          ],
          currentIndex: _selectedIndex.value,
          selectedItemColor: AppColors.white,
          backgroundColor: AppColors.primaryColor,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              AppTextStyle.fontSize14.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
