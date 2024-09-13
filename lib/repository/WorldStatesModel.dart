import 'package:covidapp/model/worldStateModel.dart';
import 'package:covidapp/services_http/http_Network_helper.dart';
import 'package:covidapp/services_http/urlsUtilies/appUrls.dart';

class WorldstatesmodelRepo {
  final HttpNetworkHelper _httpNetworkHelper = HttpNetworkHelper();

  Future<WorldStateModel> getWorldApi() async {
    try {
      final dynamic response = await _httpNetworkHelper.getApi(
          url: AppUrls.WordStatesUrlApi, isRequireAuthorization: true);
      return WorldStateModel.fromJson(response);
    } catch (e) {
      print('Error fetching posts: $e');
      throw Exception('Failed to load posts');
    }
  }
}
