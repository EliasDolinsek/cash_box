import 'package:cash_box/app/injection.dart';
import 'package:cash_box/core/platform/config.dart';
import 'package:cash_box/domain/account/enteties/subscription.dart';
import 'package:cash_box/domain/core/enteties/fields/field.dart';
import 'package:cash_box/domain/core/enteties/receipts/receipt.dart';
import 'package:cash_box/domain/core/usecases/currency/format_currency_use_case.dart';
import 'package:cash_box/localizations/app_localizations.dart';
import 'package:flutter/cupertino.dart';
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

String getFieldValueFromFieldAsString(Field field, {String currencySymbol}){
  return getFieldValueAsString(field.value, field.type, currencySymbol: currencySymbol);
}

String getFieldValueAsString(dynamic value, FieldType fieldType, {String currencySymbol}){
  switch(fieldType){
    case FieldType.text: return value;
    case FieldType.file: return value.toString();
    case FieldType.date: return getMonthAsReadableReceiptMonth(value);
    case FieldType.amount: return getAmountAsReadableString(value, currencySymbol);
    case FieldType.image: return value.toString();
    default: return value.toString();
  }
}

String getAmountAsReadableString(value, String currencySymbol) {
  final params = FormatCurrencyUseCaseParams(amount: value, symbol: currencySymbol);
  return sl<FormatCurrencyUseCase>().call(params);
}

String getMonthAsReadableReceiptMonth(DateTime dateTime){
  return DateFormat("MMMM yyyy").format(dateTime);
}

String getDateAsReadableDate(DateTime dateTime){
  return DateFormat.yMd("de").format(dateTime);
}

String getReceiptTypeAsString(BuildContext context, ReceiptType type){
  switch(type){
    case ReceiptType.income: return AppLocalizations.translateOf(context, "txt_income");
    case ReceiptType.outcome: return AppLocalizations.translateOf(context, "txt_outcome");
    default: throw Exception("Couldn't resolve receipt-type as string for receipt-type $type");
  }
}