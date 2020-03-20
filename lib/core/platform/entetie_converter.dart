import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/localizations/app_localizations.dart';

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