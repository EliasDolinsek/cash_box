import 'package:cash_box/domain/account/enteties/sign_in_state.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/presentation/auth/sign_in_page.dart';
import 'package:cash_box/presentation/buckets/add_receipt_bucket_selection_page.dart';
import 'package:cash_box/presentation/buckets/bucket_receipts_overview_page.dart';
import 'package:cash_box/presentation/buckets/buckets_selection_page.dart';
import 'package:cash_box/presentation/fields/field_details_page.dart';
import 'package:cash_box/presentation/navigation/navigation_page.dart';
import 'package:cash_box/presentation/receipts/receipt_details_page.dart';
import 'package:cash_box/presentation/templates/template_selection_page.dart';
import 'package:cash_box/presentation/search/filter_page.dart';
import 'package:cash_box/presentation/settings/buckets/bucket_details_page.dart';
import 'package:cash_box/presentation/settings/buckets/bucket_settings_page.dart';
import 'package:cash_box/presentation/settings/contacts/contact_details_page.dart';
import 'package:cash_box/presentation/settings/contacts/contacts_settings_page.dart';
import 'package:cash_box/presentation/settings/currency/currency_settings_page.dart';
import 'package:cash_box/presentation/settings/receipts/receipt_template_details_page.dart';
import 'package:cash_box/presentation/settings/receipts/receipt_templates_settings_page.dart';
import 'package:cash_box/presentation/settings/tags/tag_details_page.dart';
import 'package:cash_box/presentation/settings/tags/tags_settings_page.dart';
import 'package:cash_box/presentation/static_widgets/failure_widget.dart';
import 'package:cash_box/presentation/static_widgets/loading_widget.dart';
import 'package:cash_box/presentation/tags/tags_selection_page.dart';
import 'package:cash_box/presentation/tutorial/tutorial_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/auth_bloc/auth_bloc.dart';
import 'app/auth_bloc/bloc.dart';
import 'app/injection.dart' as injection;
import 'app/injection.dart';
import 'localizations/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.start();
  runApp(CashBoxApp());
}

class CashBoxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: TextTheme(
            title: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => _buildHome(),
        "/contactsSettings": (context) => ContactsSettingsPage(),
        "/tagsSettings": (context) => TagsSettingsPage(),
        "/receiptTemplatesSettings": (context) =>
            ReceiptTemplatesSettingsWidget(),
        "/addReceipt": (context) => AddReceiptBucketSelectionPage(),
        "/currencySettings": (context) => CurrencySettingsPage(),
        "/bucketSettings": (context) => BucketsSettingsPage(),
        "/templateSelection": (context) => TemplateSelectionPage()
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == "/contactsSettings/contactDetails") {
          final contact = settings.arguments;
          return MaterialPageRoute(builder: (_) => ContactDetailsPage(contact));
        } else if (settings.name == "/tagsSettings/tagDetails") {
          final tag = settings.arguments;
          return MaterialPageRoute(builder: (_) => TagDetailsPage(tag));
        } else if (settings.name ==
            "/receiptTemplatesSettings/templateDetails") {
          final template = settings.arguments;
          return MaterialPageRoute(
              builder: (_) => ReceiptTemplateDetailsPage(template));
        } else if (settings.name == "/addReceipt/detailsInput") {
          final receipt = settings.arguments as Receipt;
          return MaterialPageRoute(
              builder: (_) => AddReceiptPage(receipt: receipt));
        } else if (settings.name == "/editReceipt") {
          final receiptId = settings.arguments;
          return MaterialPageRoute(
              builder: (_) => EditReceiptPage(receiptId: receiptId));
        } else if (settings.name == "/tagsSelection") {
          final Map params = settings.arguments;
          final initialSelectedTagIds = params["initialSelectedTags"];
          final onChanged = params["onChanged"];
          return MaterialPageRoute(
            builder: (_) => TagsSelectionPage(
              selectedTags: initialSelectedTagIds,
              onChanged: onChanged,
            ),
          );
        } else if (settings.name == "/bucketSelection") {
          final Map params = settings.arguments;
          final initialSelectedBucketId = params["initialSelectedBucketId"];
          final onChanged = params["onChanged"];
          return MaterialPageRoute(
            builder: (_) => BucketSelectionPage(
              initialSelectedBucketId: initialSelectedBucketId,
              onChanged: onChanged,
            ),
          );
        } else if (settings.name == "/filterSelection") {
          final map = settings.arguments as Map;

          final onChanged = map["onChanged"];
          final selectedTagIds = map["selectedTagIds"];
          final selectedReceiptType = map["selectedReceiptType"];

          return MaterialPageRoute(
            builder: (_) => FilterPage(
              onChanged: onChanged,
              selectedTagIds: selectedTagIds,
              selectedReceiptType: selectedReceiptType,
            ),
          );
        } else if (settings.name == "/bucketSettings/bucketDetails") {
          final bucketId = settings.arguments;
          return MaterialPageRoute(
            builder: (context) => BucketDetailsPage(bucket: bucketId),
          );
        } else if (settings.name == "/bucketDetails") {
          final bucket = settings.arguments;
          return MaterialPageRoute(
              builder: (context) => BucketReceiptsOverviewPage(bucket: bucket));
        } else if (settings.name == "/fieldDetails") {
          final map = settings.arguments as Map;
          final field = map["field"];
          final storageOnlySelectable = map["storageOnlySelectable"] ?? true;

          return MaterialPageRoute(
            builder: (context) => FieldDetailsPage(
              field: field,
              storageOnlySelectable: storageOnlySelectable,
            ),
          );
        } else if (settings.name == "/tutorial") {
          final firstName = settings.arguments ?? "";
          return MaterialPageRoute(
            builder: (context) => TutorialPage(name: firstName),
          );
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
            return _buildLoading();
          } else if (data is SignInStateAvailable) {
            return _buildWidgetForSignInState(data.signInState);
          } else {
            return Expanded(child: LoadingWidget());
          }
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _buildLoading() {
    return Scaffold(
      body: LoadingWidget(),
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
