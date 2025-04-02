/// Exception thrown when a value is null
///
/// Used to indicate that a required value was null
/// @deprecated This exception is deprecated and will be removed in a future version
@deprecated
class IsNullException implements Exception {
  /// The error message
  final String message;

  /// Creates a new IsNullException with the specified message
  /// @deprecated This constructor is deprecated and will be removed in a future version
  @deprecated
  const IsNullException(this.message);

  /// Returns a string representation of this exception
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  @override
  String toString() => 'IsNullException: $message';
}

/// Exception thrown when a value is empty
///
/// Used to indicate that a required value was empty
/// @deprecated This exception is deprecated and will be removed in a future version
@deprecated
class IsEmptyException implements Exception {
  /// The error message
  final String message;

  /// Creates a new IsEmptyException with the specified message
  /// @deprecated This constructor is deprecated and will be removed in a future version
  @deprecated
  const IsEmptyException(this.message);

  /// Returns a string representation of this exception
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  @override
  String toString() => 'IsEmptyException: $message';
}

/// Exception thrown when authentication fails
///
/// Used to indicate that an authentication attempt was unsuccessful
/// @deprecated This exception is deprecated and will be removed in a future version
@deprecated
class FailedAuthException implements Exception {
  /// The error message
  final String message;

  /// Creates a new FailedAuthException with the specified message
  /// @deprecated This constructor is deprecated and will be removed in a future version
  @deprecated
  const FailedAuthException(this.message);

  /// Returns a string representation of this exception
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  @override
  String toString() => 'FailedAuthException: $message';
}

/// Exception thrown when SMS delivery fails
///
/// Used to indicate that an SMS could not be delivered
/// @deprecated This exception is deprecated and will be removed in a future version
@deprecated
class SMSDeliveryException implements Exception {
  /// The error message
  final String message;

  /// Creates a new SMSDeliveryException with the specified message
  /// @deprecated This constructor is deprecated and will be removed in a future version
  @deprecated
  const SMSDeliveryException(this.message);

  /// Returns a string representation of this exception
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  @override
  String toString() => 'SMSDeliveryException: $message';
}

/// Exception thrown when there are issues with SMS details
///
/// Used to indicate problems with SMS configuration or content
/// @deprecated This exception is deprecated and will be removed in a future version
@deprecated
class SMSDetailsException implements Exception {
  /// The error message
  final String message;

  /// Creates a new SMSDetailsException with the specified message
  /// @deprecated This constructor is deprecated and will be removed in a future version
  @deprecated
  const SMSDetailsException(this.message);

  /// Returns a string representation of this exception
  /// @deprecated This method is deprecated and will be removed in a future version
  @deprecated
  @override
  String toString() => 'SMSSendingException: $message';
}
