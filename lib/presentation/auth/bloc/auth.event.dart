part of "auth.bloc.dart";

@immutable
sealed class AuthEvent {}

final class InitAuthEvent extends AuthEvent {}

final class UpdateCurrentUserEvent extends AuthEvent {
  final UserEntity user;

  UpdateCurrentUserEvent(this.user);
}

final class SignUpWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;
  final String nickname;

  SignUpWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
    required this.nickname,
  });
}

final class SignInWithEmailAndPasswordEvent extends AuthEvent {
  final String email;
  final String password;

  SignInWithEmailAndPasswordEvent({
    required this.email,
    required this.password,
  });
}

final class SignOutEvent extends AuthEvent {}
