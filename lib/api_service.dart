import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:week_1_assignment/data/user_entity.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST('/register')
  Future<UserEntity> registerUser(@Body() UserEntity user);

  @GET('/users')
  Future<List<UserEntity>> getUsers();

  @GET('/trigger-error')
  Future<void> triggerError();
}