// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class KeyValueHiveModelAdapter extends TypeAdapter<KeyValueHiveModel> {
  @override
  final typeId = 0;

  @override
  KeyValueHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KeyValueHiveModel(
      id: fields[0] as String,
      key: fields[1] as String,
      value: fields[2] as String,
      enabled: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, KeyValueHiveModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.key)
      ..writeByte(2)
      ..write(obj.value)
      ..writeByte(3)
      ..write(obj.enabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KeyValueHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AuthHiveModelAdapter extends TypeAdapter<AuthHiveModel> {
  @override
  final typeId = 1;

  @override
  AuthHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AuthHiveModel(
      type: fields[0] as String,
      token: fields[1] as String,
      username: fields[2] as String,
      password: fields[3] as String,
      apiKey: fields[4] as String,
      apiValue: fields[5] as String,
      apiKeyInQuery: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AuthHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.username)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.apiKey)
      ..writeByte(5)
      ..write(obj.apiValue)
      ..writeByte(6)
      ..write(obj.apiKeyInQuery);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RequestHiveModelAdapter extends TypeAdapter<RequestHiveModel> {
  @override
  final typeId = 2;

  @override
  RequestHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RequestHiveModel(
      method: fields[0] as String,
      url: fields[1] as String,
      params: (fields[2] as List).cast<KeyValueHiveModel>(),
      headers: (fields[3] as List).cast<KeyValueHiveModel>(),
      bodyType: fields[4] as String,
      body: fields[5] as String,
      formFields: (fields[6] as List).cast<KeyValueHiveModel>(),
      auth: fields[7] as AuthHiveModel,
    );
  }

  @override
  void write(BinaryWriter writer, RequestHiveModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.method)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.params)
      ..writeByte(3)
      ..write(obj.headers)
      ..writeByte(4)
      ..write(obj.bodyType)
      ..writeByte(5)
      ..write(obj.body)
      ..writeByte(6)
      ..write(obj.formFields)
      ..writeByte(7)
      ..write(obj.auth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ResponseHiveModelAdapter extends TypeAdapter<ResponseHiveModel> {
  @override
  final typeId = 3;

  @override
  ResponseHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResponseHiveModel(
      statusCode: (fields[0] as num).toInt(),
      reasonPhrase: fields[1] as String,
      headers: (fields[2] as Map).cast<String, String>(),
      body: fields[3] as String,
      durationMs: (fields[4] as num).toInt(),
      ttfbMs: (fields[5] as num?)?.toInt(),
      sizeBytes: (fields[6] as num).toInt(),
      bodyTruncated: fields[7] as bool,
      requestUrl: fields[8] as String,
      requestMethod: fields[9] as String,
      requestHeaders: (fields[10] as Map).cast<String, String>(),
      requestBody: fields[11] as String?,
      redirects: (fields[12] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, ResponseHiveModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.statusCode)
      ..writeByte(1)
      ..write(obj.reasonPhrase)
      ..writeByte(2)
      ..write(obj.headers)
      ..writeByte(3)
      ..write(obj.body)
      ..writeByte(4)
      ..write(obj.durationMs)
      ..writeByte(5)
      ..write(obj.ttfbMs)
      ..writeByte(6)
      ..write(obj.sizeBytes)
      ..writeByte(7)
      ..write(obj.bodyTruncated)
      ..writeByte(8)
      ..write(obj.requestUrl)
      ..writeByte(9)
      ..write(obj.requestMethod)
      ..writeByte(10)
      ..write(obj.requestHeaders)
      ..writeByte(11)
      ..write(obj.requestBody)
      ..writeByte(12)
      ..write(obj.redirects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResponseHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HistoryEntryHiveModelAdapter extends TypeAdapter<HistoryEntryHiveModel> {
  @override
  final typeId = 4;

  @override
  HistoryEntryHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryEntryHiveModel(
      id: fields[0] as String,
      request: fields[1] as RequestHiveModel,
      response: fields[2] as ResponseHiveModel?,
      error: fields[3] as String?,
      timestampMs: (fields[4] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, HistoryEntryHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.request)
      ..writeByte(2)
      ..write(obj.response)
      ..writeByte(3)
      ..write(obj.error)
      ..writeByte(4)
      ..write(obj.timestampMs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryEntryHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SavedRequestHiveModelAdapter extends TypeAdapter<SavedRequestHiveModel> {
  @override
  final typeId = 5;

  @override
  SavedRequestHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedRequestHiveModel(
      id: fields[0] as String,
      name: fields[1] as String,
      folder: fields[2] as String,
      request: fields[3] as RequestHiveModel,
      updatedAtMs: (fields[4] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, SavedRequestHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.folder)
      ..writeByte(3)
      ..write(obj.request)
      ..writeByte(4)
      ..write(obj.updatedAtMs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedRequestHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EnvironmentHiveModelAdapter extends TypeAdapter<EnvironmentHiveModel> {
  @override
  final typeId = 6;

  @override
  EnvironmentHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EnvironmentHiveModel(
      id: fields[0] as String,
      name: fields[1] as String,
      variables: (fields[2] as List).cast<KeyValueHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, EnvironmentHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.variables);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnvironmentHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SettingsHiveModelAdapter extends TypeAdapter<SettingsHiveModel> {
  @override
  final typeId = 7;

  @override
  SettingsHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingsHiveModel(
      timeoutSeconds: (fields[0] as num).toInt(),
      followRedirects: fields[1] as bool,
      verifySsl: fields[2] as bool,
      historyLimit: (fields[3] as num).toInt(),
      saveResponseBodies: fields[4] as bool,
      theme: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SettingsHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.timeoutSeconds)
      ..writeByte(1)
      ..write(obj.followRedirects)
      ..writeByte(2)
      ..write(obj.verifySsl)
      ..writeByte(3)
      ..write(obj.historyLimit)
      ..writeByte(4)
      ..write(obj.saveResponseBodies)
      ..writeByte(5)
      ..write(obj.theme);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingsHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
