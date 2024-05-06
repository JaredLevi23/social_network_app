part of 'auth_bloc.dart';

class AuthState extends Equatable {

  const AuthState({ required this.email, required this.password, required this.isLoading, required this.message });
  final String email;
  final String password;
  final bool isLoading;
  final String message;

  AuthState copyWith({
    bool? isLoading,
    String? message,
    String? email,
    String? password
  }){
    return AuthState(
      email: email ?? this.email, 
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message
    );
  }
  
  @override
  List<Object> get props => [
    email,
    password,
    isLoading,
    message
  ];
}

