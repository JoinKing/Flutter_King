import 'dart:convert' show json;


class EarlyWarning {

  String code;
  String msg;
  Data data;


  EarlyWarning.fromParams({this.code, this.msg, this.data});

  factory EarlyWarning(jsonStr) => jsonStr is String ? EarlyWarning.fromJson(json.decode(jsonStr)) : EarlyWarning.fromJson(jsonStr);

  EarlyWarning.fromJson(jsonRes) {
    code = jsonRes['code']==null?null:jsonRes['code'];
    msg = jsonRes['msg']==null?null:jsonRes['msg'];
    data = jsonRes['data']==null?null:new Data.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"code": ${code != null?'${json.encode(code)}':'null'},"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}



class Data {

  int pageNum;
  int pageSize;
  List<listBean> list;


  Data.fromParams({this.pageNum, this.pageSize, this.list});

  Data.fromJson(jsonRes) {
    pageNum = jsonRes['pageNum'];
    pageSize = jsonRes['pageSize'];
    list = [];

    for (var listItem in jsonRes['list']){

      list.add(new listBean.fromJson(listItem));
    }


  }

  @override
  String toString() {
    return '{"pageNum": $pageNum,"pageSize": $pageSize,"list": $list}';
  }
}



class listBean {

  Object ITYPE;
  int IZT;
  int RowNumber;
  String CBZBM;
  String CHZTX;
  String CHZXM;
  String CJLBM;
  String CXB;
  String CYJBM;
  String CYJNR;
  String DCSNY;
  String INL;
  String CXL;
  String CSZY;


  listBean.fromParams({this.ITYPE, this.IZT, this.RowNumber, this.CBZBM, this.CHZTX, this.CHZXM, this.CJLBM, this.CXB, this.CYJBM, this.CYJNR, this.DCSNY, this.INL,this.CXL,this.CSZY});

  listBean.fromJson(jsonRes) {
    ITYPE = jsonRes['ITYPE'];
    IZT = jsonRes['IZT'];
    RowNumber = jsonRes['RowNumber'];
    CBZBM = jsonRes['CBZBM'];
    CHZTX = jsonRes['CHZTX'];
    CHZXM = jsonRes['CHZXM'];
    CJLBM = jsonRes['CJLBM'];
    CXB = jsonRes['CXB'];
    CYJBM = jsonRes['CYJBM'];
    CYJNR = jsonRes['CYJNR'];
    DCSNY = jsonRes['DCSNY'];
    CSZY = jsonRes['CSZY'];
    INL = jsonRes['INL'];
    CXL = jsonRes['CXL'];

  }

  @override
  String toString() {
    return '{"ITYPE": $ITYPE,"IZT": $IZT,"RowNumber": $RowNumber,"CBZBM": ${CBZBM != null?'${json.encode(CBZBM)}':'null'},"CHZTX": ${CHZTX != null?'${json.encode(CHZTX)}':'null'},"CHZXM": ${CHZXM != null?'${json.encode(CHZXM)}':'null'},"CJLBM": ${CJLBM != null?'${json.encode(CJLBM)}':'null'},"CXB": ${CXB != null?'${json.encode(CXB)}':'null'},"CYJBM": ${CYJBM != null?'${json.encode(CYJBM)}':'null'},"CYJNR": ${CYJNR != null?'${json.encode(CYJNR)}':'null'},"DCSNY": ${DCSNY != null?'${json.encode(DCSNY)}':'null'},"INL": ${INL != null?'${json.encode(INL)}':'null'}}';
  }
}

