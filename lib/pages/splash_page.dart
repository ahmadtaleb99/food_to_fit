import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/blocs/getLanguagesBloc.dart';
import 'package:food_to_fit/models/language.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/pages/log_in.dart';
import 'package:food_to_fit/pages/main_page.dart';
import 'package:food_to_fit/pages/started_page.dart';
import 'package:food_to_fit/widgets/dataNotFoundWidget.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  GetLanguagesBloc bloc = GetLanguagesBloc();

  late Timer _timer;
  late Stopwatch _stopwatch;
  bool _loading = true;
  Duration splashDelay = Duration(seconds: 4);
  final _appPrefs = getIT<AppPreferences>();
  bool _isTimerFinished = false;
  void _startTimer(){
    _stopwatch = Stopwatch()..start();
  }

  void _goNext() {
    if (!_appPrefs.isOnboardingScreenViewed()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => StartedPage()));
    }
    else if (_appPrefs.isAuthenticated()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(isAuthenticated: true)));

    }
    else        Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()));

  }
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    bloc.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(

          image: DecorationImage(
            image: AssetImage("assets/images/green_background.png"),
            fit: BoxFit.fill  ,
          ),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
            children: [
              if(_loading) Loading(
                  message: 'loading'.tr()
              ),

              StreamBuilder<ApiResponse<CommonResponse>>(
                stream: bloc.getLanguagesResponseStream,
                builder: (context, snapshot) {



                  if (snapshot.hasData) {

                    switch (snapshot.data!.status) {


                      case Status.COMPLETED_WITH_TRUE:

                        List<Language> languages = List.from(snapshot.data!.data!.data);
                        print('COMPLETED_WITH_TRUE');
                        print(snapshot.data!.data!.data);
                        String appLanguage  = _chooseLanguage(languages);
                        _setAppLanguage(appLanguage);
                        if(_stopwatch.elapsed.inSeconds < splashDelay.inSeconds) {
                          int remainingSeconds =   splashDelay.inSeconds - _stopwatch.elapsed.inSeconds ;
                          log('is active $remainingSeconds');

                          _timer = Timer(Duration(seconds: remainingSeconds), () { _goNext();});
                        }
                        else {
                          log('is not active');
                      _goNext();
                        }



                        break;
                      case Status.ERROR:
                     Future.delayed(Duration.zero,() =>    setState(() {
                       _loading = false;
                     }));
                        print('error');
                        return CustomErrorWidget(
                          errorMessage: snapshot.data!.message,
                          onRetryPressed: () => bloc.fetchResponse(),
                        );
                        break;
                      case Status.COMPLETED_WITH_FALSE:
                        print('COMPLETED_WITH_FALSE');
                        if(snapshot.data!.data!.message == "You don't have any notification yet"){
                          return DataNotFound(errorMessage: snapshot.data!.data!.message);
                        }
                        break;

                      case Status.COMPLETED_WITH_INTERNAL_ERROR:
                        // TODO: Handle this case.
                        break; case Status.LOADING:
                      Future.delayed(Duration.zero,() =>    setState(() {
                        _loading = true;
                      }));
                        // TODO: Handle this case.
                        break;
                    }
                  }
                  return Container();
                },
              )

            ],
          ),
        ),
      ),
    )   ;
  }

  _setAppLanguage (String language) async{
   await  _appPrefs.changeAppLanguage(context, language);

   log(_appPrefs.getAppLanguage().toString());
  }

  _chooseLanguage(List<Language> languages){
    String? currentAppLanguage = _appPrefs.getAppLanguage();

    if(currentAppLanguage != null) {
      if(_isLanguageSupported(currentAppLanguage, languages))
        return currentAppLanguage;
      else return languages.firstWhere((language) => language.isDefault == true).code;

    }

      else
      currentAppLanguage =  languages.firstWhere((language) => language.isDefault == true).code;

    return currentAppLanguage;
  }


  bool _isLanguageSupported(String language,List<Language> languages){
    for(var lang in languages){
      if(lang.code == language)
        return true;
    }

    return false;
  }
}
