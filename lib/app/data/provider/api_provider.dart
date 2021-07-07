import 'package:cool_audio_player/app/data/models/question.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class ApiProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://api-flutter-developer-zrgju.ondigitalocean.app';

    httpClient.addRequestModifier((Request request) {
      request.headers['x-topic-key'] = '408c7c5887a0f3905767754f424989b0089c14ac502d7f851d11b31ea2d1baa6';
      request.headers['x-api-version'] = '2.0';
      request.headers['content-type'] = 'application/json';
      return request;
    });

    httpClient.addResponseModifier((request, response) {
      HttpStatus httpStatus = HttpStatus(response.statusCode);
      if (httpStatus.hasError) {
        Get.snackbar('Error', httpStatus.code.toString());
      }
    });

    httpClient.maxAuthRetries = 3;
  }

  Future<List<String>> getSounds(String languageCode) async {
    List<String> sounds = [];
    Response response = await get('/audios/$languageCode');
    if (response.statusCode == HttpStatus.ok) {
      sounds = List<String>.from(response.body);
    }
    return sounds;
  }

  Future<List<Question>> getQuestions() async {
    List<Question> questions = [];
    Response response = await get('/questions');
    if (response.statusCode == HttpStatus.ok) {
      questions = List<Question>.from(response.body.map((e) => Question.fromJson(e)).toList());
    }
    return questions;
  }
}