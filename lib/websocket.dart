import 'dart:async';

class FailedConnectionException implements Exception {
  String toString() => "FailedConnectionException";
}

abstract class KyWebSocket {
  StreamController<Null> onCloseController = StreamController();
  StreamController onErrorController = StreamController();
  StreamController<dynamic> onMessageController = StreamController();

  Stream get onClose => onCloseController.stream;
  Stream get onError => onErrorController.stream;
  Stream get onMessage => onMessageController.stream;

  void send(dynamic data);
  void close();
}

