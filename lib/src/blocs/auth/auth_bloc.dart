import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:red_social/src/services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthService authService;
  final loginForm = GlobalKey<FormState>();
  final registerForm = GlobalKey<FormState>();
  final restoreForm = GlobalKey<FormState>();

  AuthBloc({ required this.authService }) : super( const AuthState( email: '', password: '', isLoading: false, message: '' )) {

    
    on<ChangeEmailEvent>( _onChangeEmailEvent );
    on<ChangePasswordEvent>( _onChangePasswordEvent );
    on<ResetFieldsEvent>( _onResetFieldsEvent );
    on<ResetMessageEvent>( _onResetMessageEvent );
    on<SubmitFieldsEvent>( _onSubmitFieldsEvent );
    on<CreateUserEvent>( _onCreateUserEvent );
    on<SendEmailResetPasswordEvent>( _onSendEmailResetPasswordEvent );
    on<LoginWithGoogleEvent>( _onLoginWithGoogle );

  }

  FutureOr<void> _onChangeEmailEvent(ChangeEmailEvent event, Emitter<AuthState> emit) {
    emit( state.copyWith( email: event.email ) );
  }

  FutureOr<void> _onChangePasswordEvent(ChangePasswordEvent event, Emitter<AuthState> emit) {
    emit( state.copyWith( password: event.password ) );
  }

  FutureOr<void> _onResetFieldsEvent(ResetFieldsEvent event, Emitter<AuthState> emit) {
    emit( state.copyWith( email: '', password: '' ));
  }

  FutureOr<void> _onSubmitFieldsEvent(SubmitFieldsEvent event, Emitter<AuthState> emit) async {
    if( !loginForm.currentState!.validate() ) return;

    emit( state.copyWith( isLoading: true ) );
    final auth = await authService.loginWithEmailAndPassword( email: state.email, password: state.password );
    emit( state.copyWith( isLoading: false ) );

    if( auth.message != null ){
      emit( state.copyWith( message: auth.message ));
    }else{
      emit( state.copyWith( message: 'Sesion iniciada.'));
    }
  }

  FutureOr<void> _onResetMessageEvent(ResetMessageEvent event, Emitter<AuthState> emit) {
    emit( state.copyWith( message: '' ) );
  }

  FutureOr<void> _onCreateUserEvent(CreateUserEvent event, Emitter<AuthState> emit) async {
    if( !registerForm.currentState!.validate() ) return;

    emit( state.copyWith(  isLoading: true) );
    final auth = await authService.createUserWithEmailAndPassword( email: state.email, password: state.password );
    emit( state.copyWith(  isLoading: false) );

    if( auth.message != null ){
      emit( state.copyWith( message: auth.message ));
    }else{
      emit( state.copyWith( message: 'Cuenta creada.' ));
    }
  }

  FutureOr<void> _onSendEmailResetPasswordEvent(SendEmailResetPasswordEvent event, Emitter<AuthState> emit) async {
    
    if( !restoreForm.currentState!.validate() ) return;
    emit( state.copyWith( isLoading: true ));
    await authService.restoreAccoutnWithEmail(email: state.email );
    emit( state.copyWith( isLoading: false ));
    emit( state.copyWith( message: 'Se ha enviado el correo para restablecer la contraseña' ) );
  }


  FutureOr<void> _onLoginWithGoogle(LoginWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit( state.copyWith( isLoading: true ) );

    final userCredential = await authService.loginWithGoogle();
    emit( state.copyWith( isLoading: false ) );
    if( userCredential.message != null && userCredential.userCredential == null ){
      emit( state.copyWith(
        message: userCredential.message
      ));
    }else{
      emit( state.copyWith( message: 'Sesion iniciada.'));
    }

  }
}
