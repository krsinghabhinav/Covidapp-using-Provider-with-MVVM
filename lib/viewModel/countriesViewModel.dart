import 'package:covidapp/Apiresponse/ApiResponse.dart';
import 'package:covidapp/model/CountryModel.dart';
import 'package:covidapp/repository/countryRepo.dart';
import 'package:covidapp/utilies/toastMess.dart';
import 'package:flutter/material.dart';

class CountryProvider with ChangeNotifier {
  final CountriesRepository _countriesRepo = CountriesRepository();
  bool isLoading = false;
  ApiResponse<List<CountriesModel>> countryModelVM = ApiResponse.loading();
  void setcountryListVM(ApiResponse<List<CountriesModel>> response) {
    countryModelVM = response;
    notifyListeners();
  }

  Future<void> countryVm() async {
    setcountryListVM(ApiResponse.loading());
    isLoading = true;
    notifyListeners();
    try {
      await _countriesRepo.countryRepo().then((value) {
        setcountryListVM(ApiResponse.completed(value));
        print("print view modal...........................$value");
        isLoading = false;
        notifyListeners();
      });
    } catch (e) {
      setcountryListVM(ApiResponse.error(e.toString()));
      toastMessage("API request failed: ${e.toString()}");
      isLoading = false;
      notifyListeners();
    }
  }
}
