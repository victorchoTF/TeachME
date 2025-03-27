//
//  TokenDecoder.swift
//  TeachME
//
//  Created by TumbaDev on 27.03.25.
//

import Foundation

class TokenDecoder {
    enum TokenDecoderError: Error {
        case invalidSegmentAmount
        case base64EncodingFailed
    }
    
    private let jsonDecoder: JSONDecoder
    
    init(jsonDecoder: JSONDecoder) {
        self.jsonDecoder = jsonDecoder
    }
    
    func decodePayload<T: Decodable>(_ token: String) throws -> T {
        let segments = token.split(separator: ".")
        guard segments.count == 3 else {
            throw TokenDecoderError.invalidSegmentAmount
        }

        let payloadSegment = String(segments[1])
        var base64 = payloadSegment.replacingOccurrences(of: "-", with: "+")
                                    .replacingOccurrences(of: "_", with: "/")
        while base64.count % 4 != 0 { base64.append("=") }

        guard let data = Data(base64Encoded: base64) else {
            throw TokenDecoderError.base64EncodingFailed
        }
        
        return try jsonDecoder.decode(T.self, from: data)
    }

}
