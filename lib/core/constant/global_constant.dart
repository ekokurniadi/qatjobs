abstract class GlobalConstant {
  static const int jobStatusDraft = 0;
  static const int jobStatusLive = 1;
  static const int jobStatusClose = 2;
  static const int jobStatusPause = 3;

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