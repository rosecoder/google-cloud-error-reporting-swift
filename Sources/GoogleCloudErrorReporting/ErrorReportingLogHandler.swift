import Logging
import Foundation

public struct ErrorReportingLogHandler: LogHandler {

    public let service: ErrorReportingService

    public let label: String

    public var logLevel: Logger.Level

    public var metadata: Logger.Metadata = [:]
    public var metadataProvider: Logger.MetadataProvider?

    public init(
        service: ErrorReportingService,
        label: String,
        logLevel: Logger.Level = .error,
        metadata: Logger.Metadata = [:],
        metadataProvider: Logger.MetadataProvider? = nil
    ) {
        self.service = service
        self.label = label
        self.logLevel = logLevel
        self.metadata = metadata
        self.metadataProvider = metadataProvider
    }

    public subscript(metadataKey key: String) -> Logger.Metadata.Value? {
        get { metadata[key] }
        set { metadata[key] = newValue }
    }

    public func log(
        level: Logger.Level,
        message: Logger.Message,
        metadata: Logger.Metadata?,
        source: String,
        file: String,
        function: String,
        line: UInt
    ) {
        let date = Date()
        service.registerReport(task: Task(priority: .background) {
            do {
                try await service.report(
                    date: date,
                    message: message.description,
                    source: source,
                    file: file,
                    function: function,
                    line: line
                )
            } catch {
                print("Error reporting error: \(error)")
            }
        })
    }
}
