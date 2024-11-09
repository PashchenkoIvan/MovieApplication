import Foundation

struct SessionIdStruct : Codable {
    
	let success : Bool
	let sessionId : String

	enum CodingKeys: String, CodingKey {
		case success = "success"
		case sessionId = "session_id"
	}

}
