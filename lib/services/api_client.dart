import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "https://signin-signup-userregistration.herokuapp.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  static ApiClient getServices() {
    final dio = Dio();
    dio.options = BaseOptions(
      connectTimeout: 15000,
    );
    return ApiClient(dio);
  }

  @POST('signup')
  Future<String> requestSignUp(@Body() String map);

  @POST('login')
  Future<String> requestLogIn(@Body() String map);
}
