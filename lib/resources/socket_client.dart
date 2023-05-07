import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  //'http://192.168.1.168:3000'
  //https://server98v1.azurewebsites.net
  SocketClient._internal() {
    socket = IO.io('https://server98v1.azurewebsites.net', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
