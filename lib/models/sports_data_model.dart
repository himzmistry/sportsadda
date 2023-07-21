class SportsDataModel {
  final List<Teams>? teams;

  SportsDataModel({
    this.teams,
  });

  SportsDataModel.fromJson(Map<String, dynamic> json)
      : teams = (json['Teams'].values.toList() as List?)?.map((dynamic e) => Teams.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'Teams' : teams?.map((e) => e.toJson()).toList()
  };
}

class Teams {
  final String? nameFull;
  final String? nameShort;
  final List<Players>? players;

  Teams({
    this.nameFull,
    this.nameShort,
    this.players,
  });

  Teams.fromJson(Map<String, dynamic> json)
      : nameFull = json['Name_Full'] as String?,
        nameShort = json['Name_Short'] as String?,
        players = (json['Players'].values.toList() as List?)?.map((dynamic e) => Players.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'Name_Full' : nameFull,
    'Name_Short' : nameShort,
    'Players' : players?.map((e) => e.toJson()).toList()
  };
}

class Players {
  final String? position;
  final String? nameFull;
  final Batting? batting;
  final Bowling? bowling;
  final bool? isKeeper;

  Players({
    this.position,
    this.nameFull,
    this.batting,
    this.bowling,
    this.isKeeper
  });

  Players.fromJson(Map<String, dynamic> json)
      : position = json['Position'] as String?,
        isKeeper = json['Iskeeper'],
        nameFull = json['Name_Full'] as String?,
        batting = (json['Batting'] as Map<String,dynamic>?) != null ? Batting.fromJson(json['Batting'] as Map<String,dynamic>) : null,
        bowling = (json['Bowling'] as Map<String,dynamic>?) != null ? Bowling.fromJson(json['Bowling'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'Position' : position,
    'Name_Full' : nameFull,
    'Batting' : batting?.toJson(),
    'Bowling' : bowling?.toJson()
  };
}

class Batting {
  final String? style;
  final String? average;
  final String? strikerate;
  final String? runs;

  Batting({
    this.style,
    this.average,
    this.strikerate,
    this.runs,
  });

  Batting.fromJson(Map<String, dynamic> json)
      : style = json['Style'] as String?,
        average = json['Average'] as String?,
        strikerate = json['Strikerate'] as String?,
        runs = json['Runs'] as String?;

  Map<String, dynamic> toJson() => {
    'Style' : style,
    'Average' : average,
    'Strikerate' : strikerate,
    'Runs' : runs
  };
}

class Bowling {
  final String? style;
  final String? average;
  final String? economyrate;
  final String? wickets;

  Bowling({
    this.style,
    this.average,
    this.economyrate,
    this.wickets,
  });

  Bowling.fromJson(Map<String, dynamic> json)
      : style = json['Style'] as String?,
        average = json['Average'] as String?,
        economyrate = json['Economyrate'] as String?,
        wickets = json['Wickets'] as String?;

  Map<String, dynamic> toJson() => {
    'Style' : style,
    'Average' : average,
    'Economyrate' : economyrate,
    'Wickets' : wickets
  };
}