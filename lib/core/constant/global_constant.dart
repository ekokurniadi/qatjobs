abstract class GlobalConstant {
  static const int jobStatusDraft = 0;
  static const int jobStatusLive = 1;
  static const int jobStatusClose = 2;
  static const int jobStatusPause = 3;

  static const int appliedDeclined = 2;
  static const int appliedHired = 3;
  static const int appliedOnGoing = 4;

  static const int slotStatusSend = 1;
  static const int slotStatusSelecte = 2;
  static const int slotStatusRejected = 3;
  static const int slotStatusNotSend = 4;

  static String getAppliedStatus(int status) {
    return status == appliedDeclined
        ? 'Declined'
        : status == appliedHired
            ? 'Hired'
            : status == appliedOnGoing
                ? 'On Going'
                : 'Applied';
  }

  static String getJobStatus(int status) {
    return status == GlobalConstant.jobStatusLive
        ? 'Live'
        : status == GlobalConstant.jobStatusClose
            ? 'Closed'
            : status == GlobalConstant.jobStatusPause
                ? 'Pause'
                : 'Draft';
  }
}
