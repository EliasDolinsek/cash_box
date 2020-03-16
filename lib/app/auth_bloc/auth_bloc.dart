import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cash_box/core/usecases/use_case.dart';
import 'package:cash_box/domain/account/usecases/get_sign_in_state_use_case.dart';
import 'package:cash_box/domain/account/usecases/send_reset_password_email_use_case.dart';
import 'package:cash_box/domain/account/usecases/sign_in_with_email_and_password_use_case.dart';
import 'package:cash_box/domain/account/usecases/sign_out_use_case.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendResetPasswordEmailUseCase sendResetPasswordEmailUseCase;
  final SignInWithEmailAndPasswordUseCase signInWithEmailAndPasswordUseCase;
  final GetSignInStateUseCase getSignInStateUseCase;
  final SignOutUseCase signOutUseCase;

  @override
  AuthState get initialState => InitialAuthState();

  AuthBloc(
      {@required this.sendResetPasswordEmailUseCase,
      @required this.signInWithEmailAndPasswordUseCase,
      @required this.getSignInStateUseCase,
      @required this.signOutUseCase});

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is SendResetPasswordEmailEvent) {
      final params = SendResetPasswordEmailUseCaseParams(event.email);
      await sendResetPasswordEmailUseCase(params);
    } else if (event is SignInWithEmailAndPasswordEvent) {
      final params =
          SignInWithEmailAndPasswordUseCaseParams(event.email, event.password);
      await signInWithEmailAndPasswordUseCase(params);
      dispatch(LoadAuthEvent());
    } else if (event is SignOutEvent) {
      await signOutUseCase(NoParams());
      dispatch(LoadAuthEvent());
    } else if (event is LoadAuthEvent) {
      yield await getSignInState();
    }
  }

  Future<AuthState> getSignInState() async{
    final signInStateEither = await getSignInStateUseCase(NoParams());
    return signInStateEither.fold((l) => AuthErrorState(l.toString()), (signInState){
      return SignInStateAvailable(signInState);
    });
  }
}
