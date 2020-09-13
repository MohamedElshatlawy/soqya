class TwsStations {
  String station_id;
  String station_code;
  String station_en_name;
  String station_ar_name;
  String organization_id;
  String branch_id;
  String country_id;
  String state_id;
  String city_id;
  String area_id;
  String en_address;
  String ar_address;
  String tel_no;
  String fax_no;
  String active_ind;
  String created_date;
  String created_by;
  String modified_date;
  String modified_by;
  String station_Unq_Code;

  TwsStations({
    station_id = '',
    station_code = '',
    station_en_name = '',
    station_ar_name = '',
    organization_id = '',
    branch_id = '',
    country_id = '',
    state_id = '',
    city_id = '',
    area_id = '',
    en_address = '',
    ar_address = '',
    tel_no = '',
    fax_no = '',
    active_ind = '',
    created_date = '',
    created_by = '',
    modified_date = '',
    modified_by = '',
    station_Unq_Code = '',
  });

  TwsStations.FromJson(Map<String, dynamic> json) {
    this.station_id = json["station_id"];
    this.station_code = json["station_code"];
    this.station_en_name = json["station_en_name"];
    this.station_ar_name = json["station_ar_name"];
    this.organization_id = json["organization_id"];
    branch_id = json["branch_id"];
    country_id = json["country_id"];
    state_id = json["state_id"];
    city_id = json["city_id"];
    area_id = json["area_id"];
    en_address = json["en_address"];
    ar_address = json["ar_address"];
    tel_no = json["tel_no"];
    fax_no = json["fax_no"];
    active_ind = json["active_ind"];
    created_date = json["created_date"];
    created_by = json["created_by"];
    modified_date = json["modified_date"];
    modified_by = json["modified_by"];
    station_Unq_Code = json["station_Unq_Code"];
  }
}
