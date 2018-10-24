import 'package:flutter/material.dart';
import 'package:soccer/model/coach.dart';
import 'package:soccer/state/bloc_provider.dart';
import 'package:soccer/state/coach_state.dart';

class TeamCoachPanel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamCoachPanelState();
}

class _TeamCoachPanelState extends State<TeamCoachPanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle headerStyle =
        textTheme.subhead.copyWith(color: Colors.black87);
    final TextStyle rowDetailStyle =
        textTheme.body1.copyWith(color: Colors.black87);
    final CoachState state = BlocProvider.of(context);

    return ExpansionPanelList(
      expansionCallback: (idx, isExpanded) {
        setState(() => _isExpanded = !isExpanded);
      },
      children: [
        ExpansionPanel(
            isExpanded: _isExpanded,
            headerBuilder: (_, b) => Row(children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: b
                          ? BoxDecoration(
                              border: BorderDirectional(
                                  bottom: BorderSide(color: Colors.black38)))
                          : null,
                      margin: const EdgeInsets.only(left: 24.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Coaches",
                          style: headerStyle,
                        ),
                      ),
                    ),
                  ),
                ]),
            body: StreamBuilder(
                stream: state.coaches,
                builder: (context, snapshot) {
                  List<Coach> coaches = [];
                  if (snapshot.hasData) {
                    coaches = snapshot.data;
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: coaches.length,
                    itemBuilder: (context, index) {
                      return coachDetailRow(rowDetailStyle, coaches[index]);
                    },
                  );
                })),
      ],
    );
  }

  Widget coachDetailRow(TextStyle rowDetailStyle, Coach coach) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      title: Text(
          coach.coachType == CoachType.HeadCoach
              ? "Head Coach"
              : "Assistant Coach",
          style: rowDetailStyle),
      subtitle: Column(
        children: <Widget>[
          Text("${coach.firstName} ${coach.lastName}", style: rowDetailStyle),
          Text("${coach.contactEmail}", style: rowDetailStyle),
          Text("${coach.contactPhone}", style: rowDetailStyle),
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
