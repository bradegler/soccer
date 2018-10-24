
import 'package:soccer/model/player.dart';
import 'package:soccer/repository/provider/database_provider.dart';
import 'package:soccer/repository/provider/relational_model_provider.dart';

class PlayerProvider extends RelationalModelProvider<Player> {
  PlayerProvider(DatabaseProvider provider) : super(provider, PlayerTable());
}