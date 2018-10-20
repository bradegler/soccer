
import 'package:soccer/model/player.dart';
import 'package:soccer/repository/provider/database_provider.dart';
import 'package:soccer/repository/provider/simple_model_provider.dart';

class PlayerProvider extends SimpleModelProvider<Player> {
  PlayerProvider(DatabaseProvider provider) : super(provider, PlayerTable());
}