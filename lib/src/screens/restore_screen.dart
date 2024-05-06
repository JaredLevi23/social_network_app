import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../blocs/auth/auth_bloc.dart';
import '../ui/input_decorations.dart';
import '../widgets/widgets.dart';

class RestoreScreen extends StatelessWidget {
const RestoreScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(

      appBar: AppBar(
        title: const Text('Restablecer cuenta'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric( horizontal: 20, vertical: 10 ),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if( state.message.isNotEmpty ){
              final scaffoldMessenger = ScaffoldMessenger.of(context);
              final snackBar = SnackBar(content: Text( state.message ));
              scaffoldMessenger.showSnackBar(snackBar);
              authBloc.add( ResetMessageEvent() );
            }
          },
          child: SafeArea(
            child: Form(
              key: authBloc.restoreForm,
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

                  const Text('Ingresa tu correo electrónico para recuperar tu contraseña.', style: TextStyle( fontSize: 20, fontWeight: FontWeight.w300 ),),
            
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
            
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
            
                  CustomButton(
                    label: 'Restablecer contraseña',
                    background: Colors.indigo.shade900,
                    onPressed: () => authBloc.add( SendEmailResetPasswordEvent())
                  ),
            
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
            
                  CustomButton(
                    label: 'Regresar',
                    onPressed: () => Navigator.pop(context)
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