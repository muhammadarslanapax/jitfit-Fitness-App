class Message {
  String? toId;
  String? msg;
  String? read;
  String? fromId;
  String? sent;
  String? duration;
  Type? type;

  Message({
    this.toId,
    this.msg,
    this.read,
    this.fromId,
    this.sent,
    this.duration,
    this.type,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      toId: json['toId'],
      msg: json['msg'],
      read: json['read'],
      fromId: json['fromId'],
      sent: json['sent'],
      duration: json['duration'],
      type:
          _getTypeFromString(json['type']), // Convert type from String to enum
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'toId': toId,
      'msg': msg,
      'read': read,
      'fromId': fromId,
      'sent': sent,
      'duration': duration,
      'type': type.toString().split('.').last, // Convert enum to String
    };
  }

  static Type _getTypeFromString(String typeString) {
    switch (typeString) {
      case 'text':
        return Type.text;
      case 'image':
        return Type.image;
      case 'video':
        return Type.video;
      case 'audio':
        return Type.audio;
      case 'document':
        return Type.document;
      default:
        return Type.text;
    }
  }
}

enum Type { text, image, video, audio, document }
