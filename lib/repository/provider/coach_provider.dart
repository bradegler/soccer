
import 'package:soccer/model/coach.dart';
import 'package:soccer/repository/provider/database_provider.dart';
import 'package:soccer/repository/provider/simple_model_provider.dart';

class CoachProvider extends SimpleModelProvider<Coach> {
  CoachProvider(DatabaseProvider provider) : super(provider, CoachTable());
}