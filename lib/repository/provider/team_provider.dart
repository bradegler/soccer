import 'package:soccer/model/team.dart';
import 'package:soccer/repository/provider/database_provider.dart';
import 'package:soccer/repository/provider/relational_model_provider.dart';

class TeamProvider extends RelationalModelProvider<Team> {
  TeamProvider(DatabaseProvider provider) : super(provider, TeamTable());
}
