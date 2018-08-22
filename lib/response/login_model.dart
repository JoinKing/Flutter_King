import 'dart:convert' show json;

class LoginModel {

  String code;
  String msg;
  Datas data;


  LoginModel.fromParams({this.code, this.msg, this.data});

  factory LoginModel(jsonStr) => jsonStr is String ? LoginModel.fromJson(json.decode(jsonStr)) : LoginModel.fromJson(jsonStr);

  LoginModel.fromJson(jsonRes) {
    code = jsonRes['code']==null?null:jsonRes['code'];
    msg = jsonRes['msg']==null?null:jsonRes['msg'];
    data = jsonRes['data']==null?null:new Datas.fromJson(jsonRes['data']);
  }

  @override
  String toString() {
    return '{"code": ${code != null?'${json.encode(code)}':'null'},"msg": ${msg != null?'${json.encode(msg)}':'null'},"data": $data}';
  }
}



class Datas {

  int ILX;
  String CLXDH;
  String CSFZH;
  String CSSKS;
  String CSSYY;
  String CXB;
  String CYSBM;
  String CYSMC;
  String CYSTX;
  String CZXSJ;
  String CZXZ;
  String token;


  Datas.fromParams({this.ILX, this.CLXDH, this.CSFZH, this.CSSKS, this.CSSYY, this.CXB, this.CYSBM, this.CYSMC, this.CYSTX, this.CZXSJ, this.CZXZ, this.token});

  Datas.fromJson(jsonRes) {
    ILX = jsonRes['ILX'];
    CLXDH = jsonRes['CLXDH'];
    CSFZH = jsonRes['CSFZH'];
    CSSKS = jsonRes['CSSKS'];
    CSSYY = jsonRes['CSSYY'];
    CXB = jsonRes['CXB'];
    CYSBM = jsonRes['CYSBM'];
    CYSMC = jsonRes['CYSMC'];
    CYSTX = jsonRes['CYSTX'];
    CZXSJ = jsonRes['CZXSJ'];
    CZXZ = jsonRes['CZXZ'];
    token = jsonRes['token'];

  }

  @override
  String toString() {
    return '{"ILX": $ILX,"CLXDH": ${CLXDH != null?'${json.encode(CLXDH)}':'null'},"CSFZH": ${CSFZH != null?'${json.encode(CSFZH)}':'null'},"CSSKS": ${CSSKS != null?'${json.encode(CSSKS)}':'null'},"CSSYY": ${CSSYY != null?'${json.encode(CSSYY)}':'null'},"CXB": ${CXB != null?'${json.encode(CXB)}':'null'},"CYSBM": ${CYSBM != null?'${json.encode(CYSBM)}':'null'},"CYSMC": ${CYSMC != null?'${json.encode(CYSMC)}':'null'},"CYSTX": ${CYSTX != null?'${json.encode(CYSTX)}':'null'},"CZXSJ": ${CZXSJ != null?'${json.encode(CZXSJ)}':'null'},"CZXZ": ${CZXZ != null?'${json.encode(CZXZ)}':'null'},"token": ${token != null?'${json.encode(token)}':'null'}}';
  }
}

