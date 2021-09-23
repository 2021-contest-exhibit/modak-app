import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modak/bloc/UserEvent.dart';
import 'package:modak/bloc/UserState.dart';
import 'package:modak/dto/User.dart';
import 'package:modak/repository/DBRepository.dart';
import 'package:modak/repository/UserRepository.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;
  final DBRepository dbRepository;

  UserBloc({required this.userRepository, required this.dbRepository}) : super(Empty());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is SelectUserEvent) {
      yield* _mapSelectUserEvent(event);
    } else if (event is LoginUserEvent) {
      yield* _mapLoginUserEvent(event);
    } else if (event is LogoutUserEvent) {
      yield* _mapLogoutUserEvent(event);
    }
  }

  Stream<UserState> _mapLogoutUserEvent(LogoutUserEvent event) async* {
    yield Loading();

    await this.userRepository.logout();

    yield Loaded();
  }

  Stream<UserState> _mapSelectUserEvent(SelectUserEvent event) async* {
    try {
      yield Loading();

      var lastUser = await this.dbRepository.loadUser();

      if (lastUser == null) {
        yield Error(message: 'last user null');
      }else{
        var user = await this.userRepository.login(lastUser.email, lastUser.password);
        print(user);
        yield Loaded(user: User.fromJson(user));
      }

    } catch (e) {
      yield Error(message: e.toString());
    }
  }

  Stream<UserState> _mapLoginUserEvent(LoginUserEvent event) async* {
    try {
      yield Loading();

      var user = await this.userRepository.login(event.user.email, event.user.password);

      await this.dbRepository.saveUser(event.user);

      if (user["userid"] != "" && user["level"] != "") {
        yield Loaded(user: User.fromJson(user));
      } else {
        yield Error(message: 'login fail');
      }

    } catch (e) {
      yield Error(message: e.toString());
    }
  }

}