import 'package:equatable/equatable.dart';
import 'package:shop_now/model/user_model.dart';

class AuthState extends Equatable {
  final bool signUpSuccessFull;
  final bool loginSuccessFull;
  final UserModel? userModel;

  const AuthState(
      {this.loginSuccessFull = false, this.signUpSuccessFull = false, this.userModel});

  AuthState copyWith({
    bool? signUpSuccessFull,
    bool? loginSuccessFull,
    UserModel? userModel,
  }) {
    return AuthState(
        signUpSuccessFull: signUpSuccessFull ?? this.signUpSuccessFull,
        loginSuccessFull: loginSuccessFull ?? this.loginSuccessFull,
        userModel: userModel ?? this.userModel,
    );
  }

  @override
  List<Object?> get props => [loginSuccessFull, signUpSuccessFull, userModel];
}
