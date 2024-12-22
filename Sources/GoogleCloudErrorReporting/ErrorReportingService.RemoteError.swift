extension ErrorReportingService {
    
    struct RemoteError: Error {

        let code: String
        let message: String
    }
}

extension ErrorReportingService.RemoteError: Decodable {

    private enum RootCodingKeys: String, CodingKey {
        case error = "error"
    }

    private enum CodingKeys: String, CodingKey {
        case code = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let container = try rootContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .error)

        self.code = try container.decode(String.self, forKey: .code)
        self.message = try container.decode(String.self, forKey: .message)
    }
}
