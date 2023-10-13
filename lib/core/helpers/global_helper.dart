class GlobalHelper {
  static bool isEmpty(value) {
    if (value == '' || value == null || value == 'null') {
      return true;
    } else {
      return false;
    }
  }

  static bool isEmptyList(Iterable<dynamic>? list) {
    if (list == null) {
      return true;
    } else if (list.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static bool isBoolean(bool? value) {
    bool result = false;
    if (!isEmpty(value.toString())) {
      result = value ?? false;
    }
    return result;
  }
}
