import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:red_social/src/blocs/auth/auth_bloc.dart';
import 'package:red_social/src/screens/screens.dart';
import 'package:red_social/src/ui/input_decorations.dart';
import 'package:validators/validators.dart';

import '../widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
const LoginScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if( state.message.isNotEmpty ){
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              final snackBar = SnackBar(content: Text( state.message ));
              scaffoldMessenger.showSnackBar(snackBar);
              if( state.message == 'Sesion iniciada.' ){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const HomeScreen()), (route) => false);
              }
              authBloc.add( ResetMessageEvent() );

            }
          },
          child: SafeArea(
            child: Form(
              key: authBloc.loginForm,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
            
                  Icon( 
                    Icons.facebook, 
                    size: MediaQuery.of(context).size.width * 0.2,
                    color: Colors.indigo,
                  ),
                  
                  const SizedBox(
                    height: 10,
                  ),
            
                  const Text('Fake Facebook', style: TextStyle( fontSize: 23, fontWeight: FontWeight.w300 ),),
            
                  const SizedBox(
                    height: 10,
                  ),
            
                  const Text('Inicio de Sesión', style: TextStyle( fontSize: 18, fontWeight: FontWeight.bold ),),
            
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
            
                  TextFormField(
                    autocorrect: false,
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

                  const SizedBox(
                    height: 10,
                  ),
            
                  Align(
                    alignment: Alignment.centerRight,
                    child: LabelTap(
                      label: '¿Olvido su contraseña?', 
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RestoreScreen()))
                    )
                  ),
            
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
            
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: ( _, state ) =>  CustomButton(
                      label: state.isLoading
                      ? 'Espere...'
                      : 'Ingresar',
                      onPressed: state.isLoading 
                      ? (){}
                      : () => authBloc.add( SubmitFieldsEvent())
                    ),
                  ),
            
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
            
                  LabelTap(
                    label: '¿No tienes cuenta? Registrate aquí.',
                    fontSize: 17,
                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen()))
                  ),

                  const SizedBox(
                    height: 10,
                  ),
            

                  const Text(
                    'ó continua con',
                    style: TextStyle( 
                      fontSize: 16
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
            

                  IconButton(
                    tooltip: 'Continuar con Google',
                    onPressed: () => authBloc.add( LoginWithGoogleEvent() ), 
                    icon: Image.network( 
                      'https://cdn.iconscout.com/icon/free/png-256/free-google-1772223-1507807.png',
                      width: 40,
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
