import 'package:dart_amqp/dart_amqp.dart';
import 'dart:convert';

import 'i_message_broker.dart';

class RabbitMQMessageBroker implements IMessageBroker {
  final String _queueName;
  final ConnectionSettings _settings;
  late Client _client;
  late Channel _channel;
  late Queue _queue;

  RabbitMQMessageBroker(this._queueName, this._settings) {
    _client = Client(settings: _settings);
  }

  @override
  void getQueue() async {
    try {
      _channel = await _client.channel();
      _queue = await _channel.queue(_queueName, durable: true);

      Consumer consumer = await _queue.consume();

      consumer.listen((AmqpMessage message) {
        // Mesajın içeriğini burada işleyin
        print("Received message: ${message.payloadAsString}");
        // Mesajın onaylanması
        message.ack();
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void close() {
    _client.close();
  }

  @override
  Future<void> queueMessageAsync<T>(T messageModel) async {
    try {
      if (_channel == null || _queue == null) {
        await _initializeQueue();
      }
      final jsonString = jsonEncode(messageModel);
      _queue.publish(jsonString);
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void queueMessageSync<T>(T messageModel) {
    try {
      if (_channel == null || _queue == null) {
        _initializeQueue();
      }
      final jsonString = jsonEncode(messageModel);
      _queue.publish(jsonString);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _initializeQueue() async {
    _channel = await _client.channel();
    _queue = await _channel.queue(_queueName, durable: true);
  }
}
