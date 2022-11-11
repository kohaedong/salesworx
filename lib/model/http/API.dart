import 'package:salesworxm/model/http/http_request.dart';

typedef RequestCallBack<T> = void Function(T value);

class API {
  static const BASE_URL = 'https://mkolonviewdev.kolon.com:8000/SynapDocViewServer/job?fileType=URL&';
  static const ATTACH_URL = 'https://mkolonviewdev.kolon.com:8000/SynapDocViewServer/viewer/doc.html?key=';
      /// https://mkolonviewdev.kolon.com:8000/SynapDocViewServer/viewer/doc.html?key=2c9e17b77ddbd41b017e281b9867008e&contextPath=/SynapDocViewServer
      ///: /SynapDocViewServer/job?fileType=URL&fid=test&filePath=http://ndeviken.kolon.com/data/brochure/KOLON_Brochure_Korean.pdf

  var _request = HttpRequest(API.BASE_URL);
}
