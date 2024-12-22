import Testing
import Foundation
@testable import GoogleCloudErrorReporting

@Suite struct RemoteErrorTests {

    @Test func shouldParseError() throws {
        let data = """
{
  "error": {
    "code": 400,
    "message": "Message cannot be empty.",
    "status": "INVALID_ARGUMENT"
  }
}
""".data(using: .utf8)!

        let error = try JSONDecoder().decode(ErrorReportingService.RemoteError.self, from: data)

        #expect(error.code == "INVALID_ARGUMENT")
        #expect(error.message == "Message cannot be empty.")
    }
}
