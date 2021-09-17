
String? isNull(String? value){
  if (value == null){
    return "The value must not be null";
  }
  return null;
}

String? minLengthValidator(String? value, int minLength){
  var _isNull = isNull(value);
  if(_isNull != null){
    return _isNull;
  } else {
    if(value!.length < minLength){
      return "The value is too short";
    }
  }
  return null;  
}