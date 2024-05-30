import 'package:bloc/bloc.dart';
import 'package:fixer_app/cubit/states.dart';
import 'package:fixer_app/models/forget_password_model.dart';
import 'package:fixer_app/models/get_home_prams_model.dart';
import 'package:fixer_app/models/login_by_code_model.dart';
import 'package:fixer_app/network/local/cache_helper.dart';
import 'package:fixer_app/shared/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:http/http.dart';

import '../models/get_services_model.dart';
import '../network/end_points.dart';
import '../network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppCubitStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  LoginByCodeModel? loginByCodeModel=LoginByCodeModel();
  ForgetPasswordModel? forgetPasswordModel=ForgetPasswordModel();
  GetCarByNumberModel? getCarByNumberModel=GetCarByNumberModel();
  GetServicesModel?getServicesModel=GetServicesModel();
  GetHomePramsModel?getHomePramsModel=GetHomePramsModel();


  Future<Null> loginByCode({
    required String carCode,
    required password,
  }) async {
    emit(AppLoginLoadingState());

    loginByCodeModel=LoginByCodeModel();
    forgetPasswordModel=ForgetPasswordModel();
    getCarByNumberModel=GetCarByNumberModel();
    getServicesModel=GetServicesModel();
    getHomePramsModel=GetHomePramsModel();



    return await DioHelper.postDate(
      url: login,
      data: {
        'carCode': carCode,
        'password': password,
      },
    ).then((value) {
      //print(value.data);
      bool oldCode = (CacheHelper.getData('codes').whereType<String>().toList()??<String>[]).contains(carCode);
      if(!oldCode) {
        CacheHelper.putDataInList(key: 'codes', value: carCode, unique: true);
        CacheHelper.putDataInList(key: 'passwords', value: password, unique: false);
        CacheHelper.putDataInList(key: 'carsInfo', value: '${value.data['data']['car']['brand']} ${value.data['data']['car']['category']} ${value.data['data']['car']['model']}', unique: false);
      }

      loginByCodeModel = LoginByCodeModel.fromJson(value.data);


      //print('done');
      //print(value.data);
      //print(loginByCodeModel?.token);
      emit(AppLoginSuccessState());

    }).catchError((error) {
      //print(error);
      emit(AppLoginErrorState(error.toString()));
    });
  }


  void forgotPassword({
    required String carCode,
    required String carNumber,
  }) {
    emit(AppForgetPasswordLoadingState());

    const url =
        'https://fixer-backend-1.onrender.com/api/V1/auth/forgotPassword';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'carCode': int.parse(carCode),
      'carNumber': carNumber,
    });

    post(Uri.parse(url), headers: headers, body: body).then((response) {
      forgetPasswordModel =
          ForgetPasswordModel.fromJson(jsonDecode(response.body));

      if (forgetPasswordModel!.status != 'fail') {
        emit(AppForgetPasswordSuccessState());
        showToast('password sent to your email');
      } else {
        emit(AppForgetPasswordErrorState(forgetPasswordModel?.message ?? ''));
      }
    });
  }


  //not used for now

  void getCarByNumber({
    required String carNumber,
  }) async{
    if (getCarByNumberModel == null)
    {
      emit(AppGetCarByNumberLoadingState());
      String url =
          'https://fixer-backend-1.onrender.com/api/V1/Garage/$carNumber';
      final headers = {'Content-Type': 'application/json'};
      return read(
        Uri.parse(url),
        headers: headers,
      ).then((response) {
        getCarByNumberModel =
            GetCarByNumberModel.fromJson(jsonDecode(response));
        //getCarByNumberModel=null;
//print(getCarByNumberModel?.id);
        if (getCarByNumberModel?.id != null) {
          emit(AppGetCarByNumberSuccessState());
        } else {
          emit(AppGetCarByNumberErrorState(response.toString()));
          showToast('Failed to load, please try to reopen the app');
        }
      });
    }
  }

  void getCarServicesByNumber({
    required String carNumber,
  }) async{

      emit(AppGetCarServicesByNumberLoadingState());
      String url =
          'https://fixer-backend-1.onrender.com/api/V1/repairing/$carNumber';
      final headers = {'Content-Type': 'application/json'};
      return read(
        Uri.parse(url),
        headers: headers,
      ).then((response) {
        getServicesModel =
            GetServicesModel.fromJson(jsonDecode(response));
        if (getServicesModel!.visits.isNotEmpty) {
          //print('daret ya sey3');
          emit(AppGetCarServicesByNumberSuccessState());
        } else {
          emit(AppGetCarServicesByNumberErrorState(response.toString()));
          showToast('Failed to load, please try to reopen the app');
        }
      }).catchError((error)
      {
        emit(AppGetCarServicesByNumberErrorState(error.toString()));
      }
      );
    }


  void getHomePrams({
      required String carNumber,
  }) {
      String url = 'https://fixer-backend-1.onrender.com/api/V1/Home/$carNumber';
      final headers = {'Content-Type': 'application/json'};
       read(
        Uri.parse(url),
        headers: headers,
      ).then((response) {
        //print (response);
        getHomePramsModel =
            GetHomePramsModel.fromJson(jsonDecode(response));
        if (getHomePramsModel !=null) {
          emit(AppGetHomePramsSuccessState());
        } else {
          emit(AppGetHomePramsErrorState(response.toString()));
          showToast('Failed to load, please try to reopen the app');
        }
      }
      );
    }
  }

//94162179
//877E92C741DF

