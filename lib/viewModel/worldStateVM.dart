import 'package:covidapp/Apiresponse/ApiResponse.dart';
import 'package:covidapp/model/worldStateModel.dart';
import 'package:covidapp/repository/WorldStatesModel.dart';
import 'package:covidapp/utilies/toastMess.dart';
import 'package:flutter/material.dart';

class WorldStateProvider with ChangeNotifier {
  final WorldstatesmodelRepo _worldstatesmodel = WorldstatesmodelRepo();
  bool isLoading = false;
  ApiResponse<WorldStateModel> WorldListVM = ApiResponse.loading();

  void setWorldListVM(ApiResponse<WorldStateModel> response) {
    WorldListVM = response;
  }

  Future<void> getworldVM() async {
    setWorldListVM(ApiResponse.loading());
    isLoading = true;

    try {
      final data = await _worldstatesmodel.getWorldApi();
      setWorldListVM(ApiResponse.completed(data));
      isLoading = false;
      notifyListeners();
    } catch (e) {
      setWorldListVM(ApiResponse.error(e.toString()));
      toastMessage("API request failed: ${e.toString()}");
      isLoading = false;
      notifyListeners();
    }
  }
}
