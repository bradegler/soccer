import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soccer/model/coach.dart';
import 'package:soccer/presentation/component/block_header.dart';
import 'package:soccer/presentation/component/image_select_field.dart';
import 'package:soccer/presentation/router_provider.dart';
import 'package:soccer/state/bloc_provider.dart';
import 'package:soccer/state/coach_state.dart';

class CoachCreate extends StatefulWidget {
  final int teamId;

  const CoachCreate({Key key, this.teamId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CoachCreateState();
}

class _CoachCreateState extends State<CoachCreate> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  bool canSave = false;
  CoachType _coachType = CoachType.HeadCoach;
  //coachType
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final TextStyle inputTheme =
        textTheme.subhead.copyWith(color: Colors.black87);

    final Widget content = Row(
      children: <Widget>[
        IconButton(
            icon: Icon(FontAwesomeIcons.chevronLeft),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        Text("Add Coach",
            style: textTheme.subhead.copyWith(color: Colors.white)),
        Container(
          height: 64.0,
        )
      ],
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    );
    return Scaffold(
        body: Column(
      children: <Widget>[
        BlockHeader(child: content, color: Colors.blueGrey.shade600),
        Form(
            onChanged: validateSave,
            child: Container(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ImageSelectField(
                            onImageSelect: (file) {},
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.only(left: 12.0),
                            child: Column(children: [
                              Center(
                                  child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: "First Name"),
                                controller: firstNameController,
                                style: inputTheme,
                              )),
                              Center(
                                  child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: "Last Name"),
                                controller: lastNameController,
                                style: inputTheme,
                              )),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Position", style: inputTheme),
                        DropdownButton(
                          style: inputTheme,
                          items: CoachType.values
                              .map((v) => DropdownMenuItem(
                                  value: v,
                                  child: Text(v == CoachType.HeadCoach ? "Head Coach" : "Assistant Coach")))
                              .toList(),
                          value: _coachType,
                          onChanged: onSelectCoachType
                        ),
                      ], mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                        Center(
                            child: TextFormField(
                          decoration:
                              InputDecoration(labelText: "Email Address"),
                          controller: emailController,
                          style: inputTheme,
                          keyboardType: TextInputType.emailAddress,
                        )),
                        Center(
                            child: TextFormField(
                          decoration:
                              InputDecoration(labelText: "Phone Number"),
                          controller: phoneController,
                          style: inputTheme,
                          keyboardType: TextInputType.phone,
                        )),
                                              Center(
                          child: RaisedButton(
                        color: Colors.green,
                        child: Text(
                          "Create",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: Colors.white),
                        ),
                        onPressed: canSave ? onCreate : null,
                      ))
                      ],
                ))),
      ],
    ));
  }

  void onCreate() {
    final CoachState state = BlocProvider.of(context);
    final Router router = RouterProvider.of(context);
    final coach = Coach();
    coach.image = imageController.value.text;
    coach.firstName = firstNameController.value.text;
    coach.lastName = lastNameController.value.text;
    coach.contactEmail = emailController.value.text;
    coach.contactPhone = phoneController.value.text;
    coach.coachType = _coachType;
    coach.teamId = widget.teamId;

    state.insertCoach(coach).then((l) {
      router.navigateTo(context, "/team/display/${l.teamId}",
          replace: true, transition: TransitionType.fadeIn);
    });

  }

  void validateSave() {
    setState(() {
      canSave = firstNameController.text.length > 0 &&
          lastNameController.text.length > 0 &&
          emailController.text.length > 0 &&
          phoneController.text.length > 0;
    });
  }

  void onSelectCoachType(CoachType v) {
    setState(() => _coachType = v);
  }
}
