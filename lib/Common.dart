class Common {

  //Local address to connect to WampServer
  // Do "ipconfig" on Windows cmd or
  // "ifconfig" on Linux, check your ipv4 Adress
  // then change this localIpv4 variable value
  static final String localIp = "192.168.1.70";

  //local path to content of "www" folder in WampServer directory
  static final String baseLocalServiceUrl =
      "http://" + localIp + "/TFC-Ubiquous-Quiz-Builder/php/";

  //Remote address to connect to Heroku App and API
  static final String baseRemoteServiceUrl = "https://php-ubiquous-quiz-builder.herokuapp.com/";

  //DON'T FORGET TO CHANGE THIS!
  /********************************* IMPORTANT *********************************
      Change variable URL_BASE_ADDRESS down below if using remote server instead of local

      Local: Common.baseLocalServiceUrlL
      Remote: Common.baseRemoteServiceUrl

      After changing this, run "flutter pub run build_runner build" on terminal
      to re-generate user_service_api.chopper.dart
   ****************************************************************************/
  static final String URL_BASE_ADDRESS = baseRemoteServiceUrl;
  //------

}
