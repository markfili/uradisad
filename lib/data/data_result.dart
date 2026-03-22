enum DataSource { remote, asset }

class DataResult<T> {
  final T data;
  final DataSource source;
  final DateTime? generatedAt;

  const DataResult(this.data, this.source, {this.generatedAt});

  bool get isStale => source == DataSource.asset;
}
