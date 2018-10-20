import 'package:soccer/model/team.dart';
import 'package:soccer/repository/provider/database_provider.dart';
import 'package:soccer/repository/provider/simple_model_provider.dart';

class TeamProvider extends SimpleModelProvider<Team> {
  TeamProvider(DatabaseProvider provider) : super(provider, TeamTable());
}
