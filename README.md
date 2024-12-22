# Google Cloud Error Reporting for Swift

This package provides a Swift implementation for error reporting on the Google Cloud Platform.

## Example usage

```swift
import GoogleCloudErrorReporting

let errorReportingService = ErrorReportingService()
Task { try await errorReportingService.run() }

try await service.report(
    date: Date(),
    message: "Error doing testing",
    source: "error-reporting.test",
    file: #file,
    function: #function,
    line: #line
)
```

This will automatically authenticate with Google Cloud and send errors to [Cloud Error Reporting](https://cloud.google.com/error-reporting/docs).

See [Google Cloud Auth for Swift](https://github.com/rosecoder/google-cloud-auth-swift) for supported authentication methods.

## Log handler

There's also a log handler which can be used with [SwiftLog](https://github.com/apple/swift-log).

```swift
import Logging
import GoogleCloudErrorReporting

let errorReportingService = ErrorReportingService()
Task { try await errorReportingService.run() }

LoggingSystem.bootstrap { label in
    ErrorReportingLogHandler(service: errorReportingService, label: label)
}
```
