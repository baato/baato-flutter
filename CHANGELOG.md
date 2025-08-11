## [0.0.1]

## [0.0.2]

- updated README

## [0.0.3]

- support for Directions API
- support for optional parameters in APIs

## [0.0.4]

- support for 'limit' parameter in Reverse API

## [0.0.5]

- added method to decode encoded polyline received from Directions API and return the list of Geo Coordinates

## [1.0.0]

- support for null-safety

## [1.0.1]

- support for appId binding security

## [1.0.2]

- migrates to Flutter 3

## [1.0.3]

- dependencies compatibility

## [2.0.0]

- Complete refactoring of the library architecture
- New API client design with improved organization and maintainability
- Centralized configuration through `BaatoAPI.configure()`
- Dedicated API clients for different services (Place, Direction)
- Updated to latest Dart SDK (^3.7.0)
- Upgraded dependencies (dio: ^5.8.0+1, crypto: ^3.0.6)
- Improved error handling and response parsing
- Better type safety throughout the codebase
- Enhanced documentation with more examples
- Support for logging interceptor for debugging
- Configurable timeout settings
- Breaking changes:
  - New initialization pattern
  - Updated method signatures
  - Restructured response models

## [2.0.1]
- Upgraded `dio` to the latest version
- Added support for `appId` in API configuration
