import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/app/auth_bloc/auth_state.dart';
import 'package:cash_box/core/errors/failure.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/usecases/get_sign_in_state_use_case.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final GetSignInStateUseCase getSignInStateUseCase;

  @override
  AuthState get initialState => InitialAuthState();

  AuthBloc({@required this.getSignInStateUseCase});

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is LoadAuthStateEvent) {
      yield await _loadAuthState();
    }
  }

  Future<AuthState> _loadAuthState() async {
    final result = await getSignInStateUseCase(NoParams());
    return result.fold((failure){
      if(failure is FirebaseFailure){
        return AuthErrorState(AuthErrorType.firebaseError);
      } else {
        return AuthErrorState(AuthErrorType.other);
      }
    }, (signInState){
      return SignInStateAvailable(signInState);
    });
  }
}
