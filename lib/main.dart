import 'package:cash_box/domain/account/enteties/sign_in_state.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/presentation/auth/sign_in_page.dart';
import 'package:cash_box/presentation/buckets_selection_page.dart';
import 'package:cash_box/presentation/navigation/navigation_page.dart';
import 'package:cash_box/presentation/navigation/web_navigation_page.dart';
import 'package:cash_box/presentation/receipts/receipt_details_page.dart';
import 'package:cash_box/presentation/receipts/add_receipt_template_selection_page.dart';
import 'package:cash_box/presentation/settings/contacts/contact_details_page.dart';
import 'package:cash_box/presentation/settings/contacts/contacts_settings_page.dart';
import 'package:cash_box/presentation/settings/receipts/receipt_template_details_page.dart';
import 'package:cash_box/presentation/settings/receipts/receipt_templates_settings_page.dart';
import 'package:cash_box/presentation/settings/tags/tag_details_page.dart';
import 'package:cash_box/presentation/settings/tags/tags_settings_page.dart';
import 'package:cash_box/presentation/static_widgets/failure_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/auth_bloc/auth_bloc.dart';
import 'app/auth_bloc/bloc.dart';
import 'app/injection.dart' as injection;
import 'app/injection.dart';
import 'localizations/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  runApp(CashBoxApp());
}

class CashBoxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CashBox",
      supportedLocales: [
        Locale("en", "EN"),
        Locale("de", "DE"),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocal in supportedLocales) {
          if (supportedLocal.languageCode == locale.languageCode) {
            return supportedLocal;
          }
        }

        return supportedLocales.first;
      },
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => _buildHome(),
        "/contactsSettings": (context) => ContactsSettingsPage(),
        "/tagsSettings": (context) => TagsSettingsPage(),
        "/receiptTemplatesSettings": (context) =>
            ReceiptTemplatesSettingsWidget(),
        "/addReceipt": (context) => AddReceiptTemplateSelectionPage(),
        "/bucketSelection": (context) => BucketSelectionPage(),
        "/tagsSelection": (context) => TagsSelectionPage()
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == "/contactsSettings/contactDetails") {
          final contact = settings.arguments;
          return MaterialPageRoute(builder: (_) => ContactDetailsPage(contact));
        } else if (settings.name == "/tagsSettings/tagDetails") {
          final tag = settings.arguments;
          return MaterialPageRoute(builder: (_) => TagDetailsPage(tag));
        } else if(settings.name == "/receiptTemplatesSettings/templateDetails") {
          final template = settings.arguments;
          return MaterialPageRoute(builder: (_) => ReceiptTemplateDetailsPage(template));
        } else if(settings.name == "/addReceipt/detailsInput") {
          final fields = (settings.arguments as List).cast<Field>();
          return MaterialPageRoute(builder: (_) => AddReceiptPage(fields: fields));
        } else {
          return MaterialPageRoute(
              builder: (_) => FailurePage("main_failure_no_route"));
        }
      },
    );
  }

  Widget _buildHome() {
    final authBloc = sl<AuthBloc>();
    return StreamBuilder(
      stream: authBloc.state,
      builder: (_, AsyncSnapshot<AuthState> snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          if (data is InitialAuthState) {
            authBloc.dispatch(LoadAuthStateEvent());
            return LoadingWidget();
          } else if (data is SignInStateAvailable) {
            return _buildWidgetForSignInState(data.signInState);
          } else {
            return Expanded(child: LoadingWidget());
          }
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget _buildWidgetForSignInState(SignInState state) {
    if (state == SignInState.signedOut) {
      return SignInPage();
    } else {
      return NavigationPage();
    }
  }
}
