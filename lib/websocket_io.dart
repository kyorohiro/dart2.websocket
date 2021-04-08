import 'dart:async';
import 'dart:io' as io;

import './websocket.dart';

Future<KyWebSocket> connect(String url) async {
  return KyWebSocketIO.connect(url);
}

class KyWebSocketIO extends KyWebSocket {
  final io.WebSocket rawWebSocket;
  KyWebSocketIO(this.rawWebSocket) {
    rawWebSocket.listen((event) {
      onMessageController.add(event);
    }, onDone: () {
      onCloseController.add(null);
    }, onError: (e) {
      onErrorController.add(e);
    });
  }

  void send(dynamic data) {
    rawWebSocket.add(data);
  }

  void close() {
    rawWebSocket.close();
  }

  static Future<KyWebSocketIO> connect(String url) async {
    try {
      return KyWebSocketIO(await io.WebSocket.connect(url));
    } catch (e, s) {
      throw FailedConnectionException();
    }
  }
}
