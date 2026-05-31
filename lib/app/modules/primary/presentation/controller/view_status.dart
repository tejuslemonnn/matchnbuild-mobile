/// Generic loading status shared by the primary module cubits.
enum ViewStatus { initial, loading, success, failure }

extension ViewStatusX on ViewStatus {
  bool get isInitial => this == ViewStatus.initial;
  bool get isLoading => this == ViewStatus.loading;
  bool get isSuccess => this == ViewStatus.success;
  bool get isFailure => this == ViewStatus.failure;
}
