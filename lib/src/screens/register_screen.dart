import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../blocs/auth/auth_bloc.dart';
import '../ui/input_decorations.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
const RegisterScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text('Registro'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if( state.message.isNotEmpty ){
              if( state.message == 'Cuenta creada.' ){
                authBloc.add( ResetFieldsEvent() );
                Navigator.pop(context);
              }

              authBloc.add( ResetMessageEvent() );
            }
          },
          child: SafeArea(
            child: Form(
              key: authBloc.registerForm,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
            
                  Icon( 
                    Icons.facebook, 
                    size: MediaQuery.of(context).size.width * 0.1,
                    color: Colors.indigo,
                  ),
                  
                  const SizedBox(
                    height: 10,
                  ),
            
                  const Text('Facebook', style: TextStyle( fontSize: 23, fontWeight: FontWeight.w300 ),),

                  const SizedBox(
                    height: 10,
                  ),

                  const Text('Ingresa tus datos para crear una nueva cuenta.', style: TextStyle( fontSize: 20, fontWeight: FontWeight.w300 ),),
            
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
            
                  TextFormField(
                    decoration: InputDecorations.textFormFieldDecoration('Correo Electrónico'),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: ( value ) => authBloc.add( ChangeEmailEvent(email: value) ),
                    validator: ( value ){
                      return isEmail( value ?? '' ) ? null : 'El correo no es valido';
                    },
                  ),
            
                  const SizedBox(
                    height: 10,
                  ),
            
                  TextFormField(
                    decoration: InputDecorations.textFormFieldDecoration('Contraseña'),
                    obscureText: true,
                    onChanged: ( value ) => authBloc.add( ChangePasswordEvent( password: value) ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
            
                  BlocBuilder<AuthBloc, AuthState>(
                    builder:(_, state) => CustomButton(
                      label: state.isLoading
                      ? 'Espere...'
                      : 'Crear cuenta',
                      background: Colors.indigo.shade900,
                      onPressed: state.isLoading
                      ? (){}
                      : () => authBloc.add( CreateUserEvent())
                    ),
                  ),
            
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
            
                  BlocBuilder<AuthBloc, AuthState>(
                    builder:(_, state) => CustomButton(
                      label: state.isLoading
                      ? 'Espere...'
                      : 'Regresar',
                      onPressed: () => Navigator.pop(context)
                    ),
                  ),
                  
            
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}