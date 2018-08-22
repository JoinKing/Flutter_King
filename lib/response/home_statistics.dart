import 'dart:convert' show json;


class StatisticsModel {

  String code;
  String msg;
  Data data;


  StatisticsModel.fromParams({this.code, this.msg, this.data});

  factory StatisticsModel(jsonStr) => jsonStr is String ? StatisticsModel.fromJson(json.decode(jsonStr)) : StatisticsModel.fromJson(jsonStr);

  StatisticsModel.fromJson(jsonRes) {
    code = jsonRes['code'];
    msg = jsonRes['msg'];
    data = jsonRes['data']==null?null:new Data.fromJson(jsonRes['data']);

  }

  @override
  String toString() {
    return '{"code": ${code != null?'${json.encode(code)}':'null'},"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}



class Data {

  String CYSLX;
  String CYSMC;
  String CYSTX;
  String bgNoticeFlag;
  String doctorGrade;
  String patientCount;
  String urPatientMCount;
  String urWarmingMCount;
  List<ListBean> list;


  Data.fromParams({this.CYSLX, this.CYSMC, this.CYSTX, this.bgNoticeFlag, this.doctorGrade, this.patientCount, this.urPatientMCount, this.urWarmingMCount, this.list});

  Data.fromJson(jsonRes) {
    CYSLX = jsonRes['CYSLX'];
    CYSMC = jsonRes['CYSMC'];
    CYSTX = jsonRes['CYSTX'];
    bgNoticeFlag = jsonRes['bgNoticeFlag'];
    doctorGrade = jsonRes['doctorGrade'];
    patientCount = jsonRes['patientCount'];
    urPatientMCount = jsonRes['urPatientMCount'];
    urWarmingMCount = jsonRes['urWarmingMCount'];
    list = [];

    for (var listItem in jsonRes['list']){

      list.add(new ListBean.fromJson(listItem));
    }


  }

  @override
  String toString() {
    return '{"CYSLX": ${CYSLX != null?'${json.encode(CYSLX)}':'null'},"CYSMC": ${CYSMC != null?'${json.encode(CYSMC)}':'null'},"CYSTX": ${CYSTX != null?'${json.encode(CYSTX)}':'null'},"bgNoticeFlag": ${bgNoticeFlag != null?'${json.encode(bgNoticeFlag)}':'null'},"doctorGrade": ${doctorGrade != null?'${json.encode(doctorGrade)}':'null'},"patientCount": ${patientCount != null?'${json.encode(patientCount)}':'null'},"urPatientMCount": ${urPatientMCount != null?'${json.encode(urPatientMCount)}':'null'},"urWarmingMCount": ${urWarmingMCount != null?'${json.encode(urWarmingMCount)}':'null'},"list": $list}';
  }
}



class ListBean {

  String title;
  String value;


  ListBean.fromParams({this.title, this.value});

  ListBean.fromJson(jsonRes) {
    title = jsonRes['title'];
    value = jsonRes['value'];

  }

  @override
  String toString() {
    return '{"title": ${title != null?'${json.encode(title)}':'null'},"value": ${value != null?'${json.encode(value)}':'null'}}';
  }
}

