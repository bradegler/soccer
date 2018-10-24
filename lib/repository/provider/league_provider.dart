
import 'package:soccer/model/league.dart';
import 'package:soccer/repository/provider/database_provider.dart';
import 'package:soccer/repository/provider/relational_model_provider.dart';

class LeagueProvider extends RelationalModelProvider<League> {
  LeagueProvider(DatabaseProvider provider) : super(provider, LeagueTable());
}