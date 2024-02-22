import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neko_coffee/common/widgets/failure.widget.dart';
import 'package:neko_coffee/common/widgets/loading.widget.dart';
import 'package:neko_coffee/common/widgets/not_logged.widget.dart';
import 'package:neko_coffee/features/account/bloc/index.dart';
import 'package:neko_coffee/features/login/bloc/index.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final accountBloc = AccountBloc(InitialAccountState());

  @override
  void initState() {
    super.initState();
    accountBloc.add(InitialAccountEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AccountBloc, AccountState>(
        listener: (context, state) {},
        listenWhen: (previous, current) => current is AccountActionState,
        buildWhen: (previous, current) => current is! AccountActionState,
        bloc: accountBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
            case SuccessAccountState:
              state as SuccessAccountState;
              return Column(
                children: [
                  SizedBox(height: 30.h),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 120,
                    child: CircleAvatar(
                      radius: 110,
                      backgroundImage: NetworkImage('${state.user.imgUrl}'),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Fullname',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    subtitle: Text(
                      '${state.user.fullname}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Email',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    subtitle: Text(
                      '${accountBloc.client.auth.currentUser!.email}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Phone',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    subtitle: Text(
                      '${state.user.phone}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Birthday',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    subtitle: Text(
                      '${state.user.birthday}',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ),
                  ListTile(
                    title: Text('Logout'),
                    onTap: () => accountBloc.add(LogoutButtonClickedEvent()),
                  ),
                ],
              );

            case ErrorAccountState:
              state as ErrorAccountState;
              return FailureWidget(error: state.errorMsg);

            case NotLoggedAccountState:
              return NotLoggedWidget(
                  onPress: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => LoginScreen(newBloc: accountBloc))));

            default:
              return const LoadingWidget();
          }
        },
      ),
    );
  }
}
