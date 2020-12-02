// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class HeroDB extends DataClass implements Insertable<HeroDB> {
  final String id;
  final String name;
  final String intelligence;
  final String speed;
  final String power;
  final String image;
  HeroDB(
      {@required this.id,
      @required this.name,
      @required this.intelligence,
      @required this.speed,
      @required this.power,
      @required this.image});
  factory HeroDB.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return HeroDB(
      id: stringType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      intelligence: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}intelligence']),
      speed:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}speed']),
      power:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}power']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || intelligence != null) {
      map['intelligence'] = Variable<String>(intelligence);
    }
    if (!nullToAbsent || speed != null) {
      map['speed'] = Variable<String>(speed);
    }
    if (!nullToAbsent || power != null) {
      map['power'] = Variable<String>(power);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    return map;
  }

  HeroesCompanion toCompanion(bool nullToAbsent) {
    return HeroesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      intelligence: intelligence == null && nullToAbsent
          ? const Value.absent()
          : Value(intelligence),
      speed:
          speed == null && nullToAbsent ? const Value.absent() : Value(speed),
      power:
          power == null && nullToAbsent ? const Value.absent() : Value(power),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
    );
  }

  factory HeroDB.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return HeroDB(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      intelligence: serializer.fromJson<String>(json['intelligence']),
      speed: serializer.fromJson<String>(json['speed']),
      power: serializer.fromJson<String>(json['power']),
      image: serializer.fromJson<String>(json['image']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'intelligence': serializer.toJson<String>(intelligence),
      'speed': serializer.toJson<String>(speed),
      'power': serializer.toJson<String>(power),
      'image': serializer.toJson<String>(image),
    };
  }

  HeroDB copyWith(
          {String id,
          String name,
          String intelligence,
          String speed,
          String power,
          String image}) =>
      HeroDB(
        id: id ?? this.id,
        name: name ?? this.name,
        intelligence: intelligence ?? this.intelligence,
        speed: speed ?? this.speed,
        power: power ?? this.power,
        image: image ?? this.image,
      );
  @override
  String toString() {
    return (StringBuffer('HeroDB(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('intelligence: $intelligence, ')
          ..write('speed: $speed, ')
          ..write('power: $power, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          name.hashCode,
          $mrjc(intelligence.hashCode,
              $mrjc(speed.hashCode, $mrjc(power.hashCode, image.hashCode))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is HeroDB &&
          other.id == this.id &&
          other.name == this.name &&
          other.intelligence == this.intelligence &&
          other.speed == this.speed &&
          other.power == this.power &&
          other.image == this.image);
}

class HeroesCompanion extends UpdateCompanion<HeroDB> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> intelligence;
  final Value<String> speed;
  final Value<String> power;
  final Value<String> image;
  const HeroesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.intelligence = const Value.absent(),
    this.speed = const Value.absent(),
    this.power = const Value.absent(),
    this.image = const Value.absent(),
  });
  HeroesCompanion.insert({
    @required String id,
    @required String name,
    @required String intelligence,
    @required String speed,
    @required String power,
    @required String image,
  })  : id = Value(id),
        name = Value(name),
        intelligence = Value(intelligence),
        speed = Value(speed),
        power = Value(power),
        image = Value(image);
  static Insertable<HeroDB> custom({
    Expression<String> id,
    Expression<String> name,
    Expression<String> intelligence,
    Expression<String> speed,
    Expression<String> power,
    Expression<String> image,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (intelligence != null) 'intelligence': intelligence,
      if (speed != null) 'speed': speed,
      if (power != null) 'power': power,
      if (image != null) 'image': image,
    });
  }

  HeroesCompanion copyWith(
      {Value<String> id,
      Value<String> name,
      Value<String> intelligence,
      Value<String> speed,
      Value<String> power,
      Value<String> image}) {
    return HeroesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      intelligence: intelligence ?? this.intelligence,
      speed: speed ?? this.speed,
      power: power ?? this.power,
      image: image ?? this.image,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (intelligence.present) {
      map['intelligence'] = Variable<String>(intelligence.value);
    }
    if (speed.present) {
      map['speed'] = Variable<String>(speed.value);
    }
    if (power.present) {
      map['power'] = Variable<String>(power.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HeroesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('intelligence: $intelligence, ')
          ..write('speed: $speed, ')
          ..write('power: $power, ')
          ..write('image: $image')
          ..write(')'))
        .toString();
  }
}

class $HeroesTable extends Heroes with TableInfo<$HeroesTable, HeroDB> {
  final GeneratedDatabase _db;
  final String _alias;
  $HeroesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedTextColumn _id;
  @override
  GeneratedTextColumn get id => _id ??= _constructId();
  GeneratedTextColumn _constructId() {
    return GeneratedTextColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn(
      'name',
      $tableName,
      false,
    );
  }

  final VerificationMeta _intelligenceMeta =
      const VerificationMeta('intelligence');
  GeneratedTextColumn _intelligence;
  @override
  GeneratedTextColumn get intelligence =>
      _intelligence ??= _constructIntelligence();
  GeneratedTextColumn _constructIntelligence() {
    return GeneratedTextColumn(
      'intelligence',
      $tableName,
      false,
    );
  }

  final VerificationMeta _speedMeta = const VerificationMeta('speed');
  GeneratedTextColumn _speed;
  @override
  GeneratedTextColumn get speed => _speed ??= _constructSpeed();
  GeneratedTextColumn _constructSpeed() {
    return GeneratedTextColumn(
      'speed',
      $tableName,
      false,
    );
  }

  final VerificationMeta _powerMeta = const VerificationMeta('power');
  GeneratedTextColumn _power;
  @override
  GeneratedTextColumn get power => _power ??= _constructPower();
  GeneratedTextColumn _constructPower() {
    return GeneratedTextColumn(
      'power',
      $tableName,
      false,
    );
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, name, intelligence, speed, power, image];
  @override
  $HeroesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'heroes';
  @override
  final String actualTableName = 'heroes';
  @override
  VerificationContext validateIntegrity(Insertable<HeroDB> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('intelligence')) {
      context.handle(
          _intelligenceMeta,
          intelligence.isAcceptableOrUnknown(
              data['intelligence'], _intelligenceMeta));
    } else if (isInserting) {
      context.missing(_intelligenceMeta);
    }
    if (data.containsKey('speed')) {
      context.handle(
          _speedMeta, speed.isAcceptableOrUnknown(data['speed'], _speedMeta));
    } else if (isInserting) {
      context.missing(_speedMeta);
    }
    if (data.containsKey('power')) {
      context.handle(
          _powerMeta, power.isAcceptableOrUnknown(data['power'], _powerMeta));
    } else if (isInserting) {
      context.missing(_powerMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
          _imageMeta, image.isAcceptableOrUnknown(data['image'], _imageMeta));
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HeroDB map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return HeroDB.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $HeroesTable createAlias(String alias) {
    return $HeroesTable(_db, alias);
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $HeroesTable _heroes;
  $HeroesTable get heroes => _heroes ??= $HeroesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [heroes];
}
