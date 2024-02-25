

extension CheckNull on String? {
  String get checkNull {
    if (this != null && this!.trim().isNotEmpty && this!.trim().toLowerCase() != 'null') {
      return this!;
    } else {
      return '';
    }
  }


  bool get checkNotEmptyAndNull {
    if (this != null && this!.trim().isNotEmpty && this!.trim().toLowerCase() != 'null') {
      return true;
    } else {
      return false;
    }
  }

  String get checkDash {
    if (this != null && this!.trim().isNotEmpty && this!.trim().toLowerCase() != 'null') {
      return this!;
    } else {
      return '-';
    }
  }

  String get checkEmpty {
    if (this != null && this!.trim().isNotEmpty && this!.trim().toLowerCase() != 'null') {
      return this!;
    } else {
      return "";
    }
  }
}

extension OnNumber on double {
  String get getDoubleOrInt {
    if (toString().split('.').length > 1) {
      if (int.parse(toString().split('.').elementAt(1)) > 0) {
        return toDouble().toStringAsFixed(2);
      } else {
        return toInt().toString();
      }
    } else {
      return toInt().toString();
    }
  }
}


