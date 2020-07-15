import 'package:cash_box/domain/core/repositories/buckets_repository.dart';
import 'package:cash_box/domain/core/repositories/contacts_repository.dart';
import 'package:cash_box/domain/core/repositories/empty_data.dart';
import 'package:cash_box/domain/core/repositories/receipts_repository.dart';
import 'package:cash_box/domain/core/repositories/tags_repository.dart';
import 'package:cash_box/domain/core/repositories/templates_repository.dart';
import 'package:cash_box/domain/core/usecases/use_case.dart';
import 'package:equatable/equatable.dart';

class NotifyUserIdChangedUseCase extends SecureSyncUseCase<
    EmptyData, NotifyUserIdChangedParams> {
  final BucketsRepository bucketsRepository;
  final ContactsRepository contactsRepository;
  final ReceiptsRepository receiptsRepository;
  final TagsRepository tagsRepository;
  final TemplatesRepository templatesRepository;

  NotifyUserIdChangedUseCase(
      this.bucketsRepository,
      this.contactsRepository,
      this.receiptsRepository,
      this.tagsRepository,
      this.templatesRepository);

  @override
  EmptyData call(NotifyUserIdChangedParams params) {
    final userId = params.userId;

    bucketsRepository.notifyUserIdChanged(userId);
    contactsRepository.notifyUserIdChanged(userId);
    receiptsRepository.notifyUserIdChanged(userId);
    tagsRepository.notifyUserIdChanged(userId);
    templatesRepository.notifyUserIdChanged(userId);

    return EmptyData();
  }
}

class NotifyUserIdChangedParams extends Equatable {
  final String userId;

  NotifyUserIdChangedParams(this.userId);

  @override
  List get props => [userId];
}
