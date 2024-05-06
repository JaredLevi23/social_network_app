import 'package:bloc/bloc.dart';

class ViewCubit extends Cubit<int> {
  ViewCubit() : super( 0 );
  void changeCurrentView( int value ){
    emit( value );
  }
}
