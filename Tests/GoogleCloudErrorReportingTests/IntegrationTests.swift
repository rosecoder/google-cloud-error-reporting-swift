import Testing
import Logging
import Foundation
import ServiceLifecycle
import GoogleCloudErrorReporting

@Suite struct IntegrationTests {

    @Test(.enabled(if: ProcessInfo.processInfo.environment["GOOGLE_APPLICATION_CREDENTIALS"] != nil))
    func reportError() async throws {
        let logger = Logger(label: "test")

        let errorReportingService = ErrorReportingService()
        LoggingSystem.bootstrap { label in
            ErrorReportingLogHandler(service: errorReportingService, label: label, logLevel: .error)
        }

        let app = AppService()

        let serviceGroup = ServiceGroup(configuration: ServiceGroupConfiguration(
            services: [
                .init(service: errorReportingService),
                .init(service: app, successTerminationBehavior: .gracefullyShutdownGroup),
            ],
            logger: logger
        ))

        try await serviceGroup.run()

        // Manually validate that error has been created i GCP
        // Errors should be written automatically before shutdown
    }

    struct AppService: Service {

        func run() async throws {
            let logger = Logger(label: "testing")
            logger.error("This is an error from GoogleCloudErrorReportingTests")
        }
    }
}
