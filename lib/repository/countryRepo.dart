import 'package:covidapp/model/CountryModel.dart';
import 'package:covidapp/services_http/http_Network_helper.dart';
import 'package:covidapp/services_http/urlsUtilies/appUrls.dart';

class CountriesRepository {
  HttpNetworkHelper _helper = HttpNetworkHelper();

  Future<List<CountriesModel>> countryRepo() async {
    try {
      final dynamic response = await _helper.getApi(
          url: "https://disease.sh/v3/covid-19/countries",
          isRequireAuthorization: true);
      List<dynamic> data = response as List<dynamic>;
      data.forEach((item) => print("Data Item: $item"));
      return data.map((item) => CountriesModel.fromJson(item)).toList();
    } catch (e) {
      print("Error faching post $e");
      throw Exception('Failed to load posts');
    }
  }
}

// import 'package:covidapp/model/CountryModel.dart';
// import 'package:covidapp/services_http/http_Network_helper.dart';

// class CountriesRepository {
//   final HttpNetworkHelper _helper = HttpNetworkHelper();

//   Future<List<dynamic>> fetchCountries() async {
//     try {
//       final dynamic response = await _helper.getApi(
//         url: "https://disease.sh/v3/covid-19/countries",
//         isRequireAuthorization: true,
//       );
//       return response;
//       // List<dynamic> data = response as List<dynamic>;
//       // print("repo data print........................ $data");
//       // return data.map((item) => CountriesModel.fromJson(item)).toList();
//     } catch (e) {
//       print("Error fetching data: $e");
//       throw Exception('Failed to load countries');
//     }
//   }
// }



// import 'package:covidapp/model/CountryModel.dart';
// import 'package:covidapp/services_http/http_Network_helper.dart';
// import 'package:covidapp/services_http/urlsUtilies/appUrls.dart';

// class CountriesRepository {
//   HttpNetworkHelper _helper = HttpNetworkHelper();

//   Future<List<CountriesModel>> countryRepo() async {
//     try {
//       final dynamic response = await _helper.getApi(
//           url: "https://disease.sh/v3/covid-19/countries",
//           isRequireAuthorization: true);

//       print("API Response: $response"); // Print the raw API response

//       List<dynamic> data = response as List<dynamic>;

//       // Print each item in the data list to debug
//       data.forEach((item) => print("Data Item: $item"));

//       return data.map((item) => CountriesModel.fromJson(item)).toList();
//     } catch (e) {
//       print("Error fetching posts: $e");
//       throw Exception('Failed to load posts');
//     }
//   }
// }
