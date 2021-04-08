import 'dart:async';
import 'dart:html' as html;
import 'websocket.dart';

Future<KyWebSocket> connect(String url) async {
  return KyWebSocketHtml.connect(url);
}

class KyWebSocketHtml extends KyWebSocket {
  final html.WebSocket rawWebSocket;

  KyWebSocketHtml(this.rawWebSocket) {
    rawWebSocket.onClose.listen((event) {
      print("on close");
      onCloseController.add(null);
    });
    rawWebSocket.onError.listen((e) {
      print("on error");
      onErrorController.add(e);
    });
    rawWebSocket.onMessage.listen((message) {
      print("on message 1${message.data}");
      onErrorController.add(message.data);
      print("on message 2");
    });
  }

  void send(dynamic data) {
    print("send 1 ${data}");
    rawWebSocket.send(data);
    print("send 2 ${data}");
  }

  void close() {
    rawWebSocket.close();
  }

  static Future<KyWebSocketHtml> connect(String url) async {
    Completer<KyWebSocketHtml> completer = Completer();
    try {
      var rawWebSocket = html.WebSocket(url);
      rawWebSocket.onOpen.listen((event) {
        //
        print("onconnect c");
        completer.complete(KyWebSocketHtml(rawWebSocket));
      }, onError: (e) {
        print("on error c");
        completer.completeError(e);
      });
    } catch (e, s) {
      throw FailedConnectionException();
    }
    return completer.future;
  }
}
