//
//  LeetCodeProblem.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 22/10/24.
//

enum LCPType: String, Codable {
    case easy
    case medium
    case hard
}

class LCP: Codable {
    var name: String = ""
    var type: LCPType = .medium
    var completed: Bool = false
    
    init(name: String, type: LCPType = .medium, completed: Bool = false) {
        self.name = name
        self.type = type
        self.completed = completed
    }
    
    // Manual encoding method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(completed, forKey: .completed)
    }
    
    // Manual decoding method
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.type = try container.decode(LCPType.self, forKey: .type)
        self.completed = try container.decode(Bool.self, forKey: .completed)
    }
    
    // Define the keys to match the property names
    enum CodingKeys: String, CodingKey {
        case name
        case type
        case completed
    }
}
