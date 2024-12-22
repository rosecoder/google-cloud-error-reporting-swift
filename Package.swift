// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "google-cloud-error-reporting",
    platforms: [
        .macOS(.v15),
    ],
    products: [
        .library(name: "GoogleCloudErrorReporting", targets: ["GoogleCloudErrorReporting"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.4.2"),
        .package(url: "https://github.com/rosecoder/google-cloud-service-context.git", from: "0.0.2"),
        .package(url: "https://github.com/rosecoder/retryable-task.git", from: "1.1.2"),
        .package(url: "https://github.com/rosecoder/google-cloud-auth-swift.git", from: "1.0.0"),
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.10.0"),
    ],
    targets: [
        .target(name: "GoogleCloudErrorReporting", dependencies: [
            .product(name: "Logging", package: "swift-log"),
            .product(name: "GoogleCloudServiceContext", package: "google-cloud-service-context"),
            .product(name: "RetryableTask", package: "retryable-task"),
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
            .product(name: "GoogleCloudAuth", package: "google-cloud-auth-swift"),
        ]),
        .testTarget(
            name: "GoogleCloudErrorReportingTests",
            dependencies: ["GoogleCloudErrorReporting"]
        ),
    ]
)
