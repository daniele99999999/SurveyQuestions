//  
//  QuestionSubmit.swift
//

import Foundation

public struct QuestionSubmitRequest {
    public struct Body: Codable {
        public let id: Int
        public let answer: String
    }
}

