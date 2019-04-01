import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:soccer/presentation/coach/coach_create.dart';
import 'package:soccer/presentation/league/league_create.dart';
import 'package:soccer/presentation/league/league_display.dart';
import 'package:soccer/presentation/league/leagues_route.dart';
import 'package:soccer/presentation/splash_route.dart';
import 'package:soccer/presentation/team/team_create.dart';
import 'package:soccer/presentation/team/team_display.dart';

/// Master router. Manages the route to handler mapping for
/// all routes. Creates the Fluro router and configures it
/// to be used in the app.
///
/// Usage:
/// ```dart
/// Router router = RouterBuilder().build();
/// ```
///
class RouterBuilder {
  Router build() {
    final Router router = Router();
    final _RouteHandlers handlers = _RouteHandlers();
    final Map<String, Handler> routes = {
      "/": handlers._hSplash(router),
      "/leagues": handlers._hLeaguesRoute(router),
      "/league/create": handlers._hLeagueCreate(router),
      "/league/display/:id": handlers._hLeagueDisplay(router),
      "/team/create": handlers._hTeamCreate(router),
      "/team/display/:id": handlers._hTeamDisplay(router),
      "/team/:id/coach/create": handlers._hCoachCreate(router),
    };

    routes.forEach((key, value) => router.define(key, handler: value));
    return router;
  }
}

class _RouteHandlers {
  Handler _hCoachCreate(Router router) => Handler(handlerFunc: (context, params) {
        return CoachCreate(teamId: int.parse(params["id"].first));
      });
  Handler _hSplash(Router router) => Handler(handlerFunc: (context, params) {
        Future.delayed(Duration(seconds: 4), () {
          router.navigateTo(context, "/leagues", replace: true, transition: TransitionType.fadeIn, transitionDuration: Duration(milliseconds: 750));
        });
        return SplashRoute();
      });

  Handler _hTeamCreate(Router router) => Handler(handlerFunc: (context, params) {
        return TeamCreate();
      });
  Handler _hLeaguesRoute(Router router) => Handler(handlerFunc: (context, params) {
        return LeaguesRoute();
      });
  Handler _hLeagueCreate(Router router) => Handler(handlerFunc: (context, params) {
        return LeagueCreate();
      });

  Handler _hLeagueDisplay(Router router) => Handler(handlerFunc: (context, params) {
        return LeagueDisplay(leagueId: int.parse(params["id"].first));
      });

  Handler _hTeamDisplay(Router router) => Handler(handlerFunc: (context, params) {
        return TeamDisplay(teamId: int.parse(params["id"].first));
      });
}
