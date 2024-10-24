abstract class AppCubitStates{}


class AppInitialState extends AppCubitStates{}

class AppChangeBottomNavState extends AppCubitStates{}

class AppLoginLoadingState extends AppCubitStates{}

class AppLoginSuccessState extends AppCubitStates{}

class AppLoginErrorState extends AppCubitStates{
  final String error;
  AppLoginErrorState(this.error);
}

class AppForgetPasswordLoadingState extends AppCubitStates{}

class AppForgetPasswordSuccessState extends AppCubitStates{}

class AppForgetPasswordErrorState extends AppCubitStates{
  final String error;
  AppForgetPasswordErrorState(this.error);
}

class AppGetCarByNumberLoadingState extends AppCubitStates{}

class AppGetCarByNumberSuccessState extends AppCubitStates{}

class AppGetCarByNumberErrorState extends AppCubitStates{
  final String error;
  AppGetCarByNumberErrorState(this.error);
}

class AppGetCarServicesByNumberLoadingState extends AppCubitStates{}

class AppGetCarServicesByNumberSuccessState extends AppCubitStates{}

class AppGetCarServicesByNumberErrorState extends AppCubitStates{
  final String error;
  AppGetCarServicesByNumberErrorState(this.error);
}


class AppGetHomePramsLoadingState extends AppCubitStates{}

class AppGetHomePramsSuccessState extends AppCubitStates{}

class AppGetHomePramsErrorState extends AppCubitStates{
  final String error;
  AppGetHomePramsErrorState(this.error);
}

class UpdateLungState extends AppCubitStates{}