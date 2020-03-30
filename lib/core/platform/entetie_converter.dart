import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:intl/intl.dart';

String getSubscriptionTypeAsString(SubscriptionType type, AppLocalizations localizations){
  switch(type){
    case SubscriptionType.business_free: return localizations.translate("subscription_type_business_free");
    case SubscriptionType.personal_free: return localizations.translate("subscription_type_personal_free");
    case SubscriptionType.business_pro: return localizations.translate("subscription_type_business_pro");
    case SubscriptionType.personal_pro: return localizations.translate("subscription_type_personal_pro");
    default: throw new Exception("Couldn't resolve SubscriptionType as String $type");
  }
}

String getDataStorageLocationAsString(DataStorageLocation dataStorageLocation, AppLocalizations localizations){
  switch(dataStorageLocation){
    case DataStorageLocation.LOCAL_MOBILE: return localizations.translate("data_storage_location_local_mobile");
    case DataStorageLocation.REMOTE_FIREBASE: return localizations.translate("data_storage_location_remote_firebase");
    default: throw new Exception("Couldn't resolve DataStorageLocation as String $dataStorageLocation");
  }
}

String getFieldTypeAsString(FieldType type, AppLocalizations localizations){
  switch(type){
    case FieldType.text: return localizations.translate("field_type_text");
    case FieldType.file: return localizations.translate("field_type_file");
    case FieldType.amount: return localizations.translate("field_type_amount");
    case FieldType.date: return localizations.translate("field_type_date");
    case FieldType.image: return localizations.translate("field_type_image");
    default: throw Exception("Couldn't resolve string for FieldType $type");
  }
}

String getMonthAsReadableReceiptMonth(DateTime dateTime){
  return DateFormat("MMMM yyyy").format(dateTime);
}