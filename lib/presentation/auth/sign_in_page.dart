import 'package:cash_box/localizations/app_localizations.dart';
import 'package:cash_box/presentation/auth/sign_in_widget.dart';
import 'package:cash_box/presentation/base/screen_type_layout.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ScreenTypeLayout(
          mobile: _buildMobile(),
          desktop: _buildDesktop(context),
          tablet: _buildDesktop(context),
        ),
      ),
    );
  }

  Widget _buildMobile() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: _buildLogoImage(),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SignInInputWidget(),
          ),
        )
      ],
    );
  }

  Widget _buildDesktop(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 32.0, top: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: _buildLogoImage(),
                constraints: BoxConstraints(
                  maxWidth: 200
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: _buildBackButton(context),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: _buildDesktopSignInWidget(),
          ),
        )
      ],
    );
  }

  Widget _buildDesktopSignInWidget() {
    return Container(
      child: SignInInputWidget(),
      constraints: BoxConstraints(maxWidth: 500),
    );
  }

  Widget _buildLogoImage() {
    return Image(
      image: AssetImage("res/imgs/logo.png"),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    final text = AppLocalizations.translateOf(context, "sign_in_page_btn_home");
    return MaterialButton(
      onPressed: () {
        //js.context.callMethod("open", ["https://eliasdolinsek.com"]);
      },
      child: Text(text),
    );
  }
}
