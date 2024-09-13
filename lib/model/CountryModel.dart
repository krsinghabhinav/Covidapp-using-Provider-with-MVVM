class CountriesModel {
  // int? updated;
  String? country;
  CountryInfo? countryInfo;
  int? cases;
  int? todayCases;
  int? deaths;
  int? todayDeaths;
  int? recovered;
  int? active;
  int? tests;
  int? todayRecovered;
  int? critical;

  CountriesModel({
    // this.updated,
    this.country,
    this.countryInfo,
    this.cases,
    this.todayCases,
    this.deaths,
    this.todayDeaths,
    this.recovered,
    this.active,
    this.todayRecovered,
    this.tests,
    this.critical,
  });

  CountriesModel.fromJson(Map<String, dynamic> json) {
    // updated = json['updated'];
    country = json['country'];
    countryInfo = json['countryInfo'] != null
        ? new CountryInfo.fromJson(json['countryInfo'])
        : null;
    cases = json['cases'];
    recovered = json['recovered'];
    todayCases = json['todayCases'];
    deaths = json['deaths'];
    todayDeaths = json['todayDeaths'];
    active = json['active'];
    tests = json['tests'];
    todayRecovered = json['todayRecovered'];
    critical = json['critical'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['updated'] = this.updated;
    data['country'] = this.country;
    if (this.countryInfo != null) {
      data['countryInfo'] = this.countryInfo!.toJson();
    }
    data['cases'] = this.cases;
    data['todayCases'] = this.todayCases;
    data['deaths'] = this.deaths;
    data['todayDeaths'] = this.todayDeaths;
    data['recovered'] = this.recovered;
    data['active'] = this.active;
    data['tests'] = this.tests;
    data['todayRecovered'] = this.todayRecovered;
    data['critical'] = this.critical;

    return data;
  }
}

class CountryInfo {
  int? iId;
  String? iso2;
  String? iso3;
  // double? lat;
  // double? long;
  String? flag;

  CountryInfo({this.iId, this.iso2, this.iso3, this.flag});

  CountryInfo.fromJson(Map<String, dynamic> json) {
    iId = json['_id'];
    iso2 = json['iso2'];
    iso3 = json['iso3'];
    // lat = json['lat'];
    // long = json['long'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['iso2'] = this.iso2;
    data['iso3'] = this.iso3;
    // data['lat'] = this.lat;
    // data['long'] = this.long;
    data['flag'] = this.flag;
    return data;
  }
}
