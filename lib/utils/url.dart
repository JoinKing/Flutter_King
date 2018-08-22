class UrlUtils {
  static const String HOST = "http://192.168.200.121:8080"; //内网
//  static const String HOST = "http://192.168.200.203:8084"; //内网
  static const String URI = HOST + "/CDCT_CD_CI"; //前缀
  static const String LOGIN = URI + "/user/login"; //登录
  static const String CODE = URI + "/sms/verify"; //验证码
  static const String FUNCTION_API = URI+"/http/do?token="; //主方法
//    public final static String HOST = "http://test.jlsdyyjkglyxgs.com";
}