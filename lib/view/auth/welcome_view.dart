import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:tasks_app/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:tasks_app/core/locator/locator.dart';
import 'package:tasks_app/view/auth/sign_in_view.dart';
import 'package:tasks_app/view/auth/sign_up_view.dart';

import '../../bloc/authentication_bloc/authentication_bloc.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeView>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInBloc>(
          create: (context) => SignInBloc(),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider.value(
          value: getIt<AuthenticationBloc>(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  left: -MediaQuery.of(context).size.width * 0.4,
                  top: -MediaQuery.of(context).size.width * 0.4,
                  child: Container(
                    height: MediaQuery.of(context).size.width * 1.2,
                    width: MediaQuery.of(context).size.width * 1.2,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.tertiary),
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.2,
                  top: -MediaQuery.of(context).size.width * 0.4,
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.8,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                Positioned(
                  right: -MediaQuery.of(context).size.width * 0.4,
                  top: -MediaQuery.of(context).size.width * 0.4,
                  child: Container(
                    height: MediaQuery.of(context).size.width * 1.2,
                    width: MediaQuery.of(context).size.width * 1.2,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  child: Container(),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 120.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipOval(
                              child: Container(
                                width: 120,
                                height: 120,
                                color: Theme.of(context).colorScheme.primary,
                                child: Image.asset(
                                  'assets/images/icon.jpg', // Burada iconunuzun yolunu belirtin
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'WELCOME',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        'Keep track of your tasks!',
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 50.0),
                          child: TabBar(
                            controller: tabController,
                            unselectedLabelColor: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.5),
                            labelColor: Theme.of(context).colorScheme.onSurface,
                            tabs: const [
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: tabController,
                            children: [
                              BlocProvider<SignInBloc>.value(
                                key: const Key('signInBloc'),
                                value: getIt<SignInBloc>(),
                                child: const SignInView(),
                              ),
                              BlocProvider<SignUpBloc>.value(
                                key: const Key('signUpBloc'),
                                value: getIt<SignUpBloc>(),
                                child: const SignUpView(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
