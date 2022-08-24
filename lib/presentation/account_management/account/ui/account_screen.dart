import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../generated/l10n.dart';
import '../../../common/method/common_show_dialog.dart';
import '../../../common/widget/loading_widget.dart';
import '../bloc/account_bloc.dart';
import 'widget/account_login_widget.dart';
import 'widget/account_not_login_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User? _user;

  onRefresh(userCred) {
    setState(() {
      _user = userCred;
    });
  }

  final RefreshController _refreshController = RefreshController();

  Future<void> _pullToRefresh(BuildContext context) async {
    context.read<AccountBloc>().add(AccountLoadEvent());
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) => Scaffold(
        body: _user != null
            ? BlocConsumer<AccountBloc, AccountState>(
                listener: (_, state) {
                  if (state is AccountFailureState) {
                    showConfirmDialog(
                      context,
                      title: "ERROR",
                      subTitle: S.current.fail(state.message),
                      textButton: S.current.reload,
                      onPressed: () {
                        Navigator.pop(context);

                        context.read<AccountBloc>().add(
                              AccountLoadEvent(),
                            );
                      },
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AccountLoadingState) {
                    return const Loading();
                  } else if (state is AccountLoadedState) {
                    return SmartRefresher(
                      child: AccountLoginWidget(state: state, context: context),
                      controller: _refreshController,
                      onRefresh: () {
                        _pullToRefresh(context);
                      },
                    );
                  }
                  return const Loading();
                },
              )
            : const AccountNotLoginWidget(),
      );
}
