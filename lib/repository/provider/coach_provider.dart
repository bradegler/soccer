
import 'package:soccer/model/coach.dart';
import 'package:soccer/repository/provider/database_provider.dart';
import 'package:soccer/repository/provider/relational_model_provider.dart';

class CoachProvider extends RelationalModelProvider<Coach> {
  CoachProvider(DatabaseProvider provider) : super(provider, CoachTable());
}