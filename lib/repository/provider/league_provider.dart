
import 'package:soccer/model/league.dart';
import 'package:soccer/repository/provider/database_provider.dart';
import 'package:soccer/repository/provider/simple_model_provider.dart';

class LeagueProvider extends SimpleModelProvider<League> {
  LeagueProvider(DatabaseProvider provider) : super(provider, LeagueTable());
}