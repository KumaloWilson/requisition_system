import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:req_sys_finale/features/home/model/requisition.dart';
import 'package:req_sys_finale/features/shift/services/shift_services.dart';

class RequisitionsNotifier extends StateNotifier<AsyncValue<List<Requisition>>> {
  final String profileEmail;
  StreamSubscription<List<Requisition>>? _reqSubscription;

  RequisitionsNotifier({required this.profileEmail})
      : super(const AsyncValue.loading()) {
    streamRequisitions(profileEmail: profileEmail);
  }

  // Stream user shifts in real-time
  void streamRequisitions({required String profileEmail}) {
    _reqSubscription?.cancel();

    _reqSubscription = RequisitionServices.streamRequisitionsByEmail(email: profileEmail).listen(
      (shifts) {
        state = AsyncValue.data(shifts);
      },
      onError: (error) {
        state = AsyncValue.error(
            'Failed to fetch requisitions: $error', StackTrace.current);
      },
    );
  }

  // Cleanup: Cancel the stream subscription when no longer needed
  @override
  void dispose() {
    _reqSubscription?.cancel();
    super.dispose();
  }
}
