class RoomIdModel {
  int? result;
  Room? room;

  RoomIdModel({this.result, this.room});

  RoomIdModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    return data;
  }
}

class Room {
  String? name;
  String? serviceId;
  String? ownerRef;
  Settings? settings;
  Sip? sip;
  Data? data;
  String? created;
  String? roomId;

  Room(
      {this.name,
        this.serviceId,
        this.ownerRef,
        this.settings,
        this.sip,
        this.data,
        this.created,
        this.roomId});

  Room.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    serviceId = json['service_id'];
    ownerRef = json['owner_ref'];
    settings = json['settings'] != null
        ? new Settings.fromJson(json['settings'])
        : null;
    sip = json['sip'] != null ? new Sip.fromJson(json['sip']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    created = json['created'];
    roomId = json['room_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['service_id'] = this.serviceId;
    data['owner_ref'] = this.ownerRef;
    if (this.settings != null) {
      data['settings'] = this.settings!.toJson();
    }
    if (this.sip != null) {
      data['sip'] = this.sip!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['created'] = this.created;
    data['room_id'] = this.roomId;
    return data;
  }
}

class Settings {
  String? description;
  String? mode;
  bool? scheduled;
  bool? adhoc;
  String? duration;
  String? participants;
  bool? autoRecording;
  bool? screenShare;
  bool? canvas;
  String? mediaConfiguration;
  String? quality;
  String? moderators;
  int? viewers;
  bool? activeTalker;
  bool? encryption;
  bool? watermark;
  bool? singleFileRecording;
  int? maxActiveTalkers;
  String? mediaZone;

  Settings(
      {this.description,
        this.mode,
        this.scheduled,
        this.adhoc,
        this.duration,
        this.participants,
        this.autoRecording,
        this.screenShare,
        this.canvas,
        this.mediaConfiguration,
        this.quality,
        this.moderators,
        this.viewers,
        this.activeTalker,
        this.encryption,
        this.watermark,
        this.singleFileRecording,
        this.maxActiveTalkers,
        this.mediaZone});

  Settings.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    mode = json['mode'];
    scheduled = json['scheduled'];
    adhoc = json['adhoc'];
    duration = json['duration'];
    participants = json['participants'];
    autoRecording = json['auto_recording'];
    screenShare = json['screen_share'];
    canvas = json['canvas'];
    mediaConfiguration = json['media_configuration'];
    quality = json['quality'];
    moderators = json['moderators'];
    viewers = json['viewers'];
    activeTalker = json['active_talker'];
    encryption = json['encryption'];
    watermark = json['watermark'];
    singleFileRecording = json['single_file_recording'];
    maxActiveTalkers = json['max_active_talkers'];
    mediaZone = json['media_zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['mode'] = this.mode;
    data['scheduled'] = this.scheduled;
    data['adhoc'] = this.adhoc;
    data['duration'] = this.duration;
    data['participants'] = this.participants;
    data['auto_recording'] = this.autoRecording;
    data['screen_share'] = this.screenShare;
    data['canvas'] = this.canvas;
    data['media_configuration'] = this.mediaConfiguration;
    data['quality'] = this.quality;
    data['moderators'] = this.moderators;
    data['viewers'] = this.viewers;
    data['active_talker'] = this.activeTalker;
    data['encryption'] = this.encryption;
    data['watermark'] = this.watermark;
    data['single_file_recording'] = this.singleFileRecording;
    data['max_active_talkers'] = this.maxActiveTalkers;
    data['media_zone'] = this.mediaZone;
    return data;
  }
}

class Sip {
  bool? enabled;

  Sip({this.enabled});

  Sip.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enabled'] = this.enabled;
    return data;
  }
}

class Data {
  String? customKey;

  Data({this.customKey});

  Data.fromJson(Map<String, dynamic> json) {
    customKey = json['custom_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['custom_key'] = this.customKey;
    return data;
  }
}

