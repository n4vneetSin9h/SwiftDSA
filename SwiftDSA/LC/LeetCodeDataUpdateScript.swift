//
//  LeetCodeDataUpdateScript.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 23/10/24.
//

import Foundation

struct LCPConstants {
    static let path = "/Users/navneetsingh/Documents/GitHub/SwiftDSA/SwiftDSA/LC/LeetCodeData.json"
    
    static let solved = ["Two Sum",
                         "Palindrome Number",
                         "Roman to Integer",
                         "Longest Common Prefix",
                         "Valid Parentheses",
                         "Merge Two Sorted Lists",
                         "Remove Duplicates from Sorted Array",
                         "Remove Element",
                         "Find the Index of the First Occurrence in a String",
                         "Search Insert Position",
                         "Length of Last Word",
                         "Merge Sorted Array",
                         "Best Time to Buy and Sell Stock",
                         "Valid Palindrome",
                         "Majority Element",
                         "Is Subsequence",
                         "Longest Substring Without Repeating Characters",
                         "Jump Game II",
                         "Rotate Image",
                         "Jump Game",
                         "Remove Duplicates from Sorted Array II",
                         "Best Time to Buy and Sell Stock II",
                         "Two Sum II - Input Array Is Sorted",
                         "Rotate Array",
                         "Product of Array Except Self",
                         "H-Index",
                         "Insert Delete GetRandom O(1)",
                         "Candy",
                         "Ransom Note",
                         "Isomorphic Strings",
                         "Word Pattern"]
}

class LCPUpdateScript {
    
    static var objs: [LCP] = []
    static var finalJSONStr = ""
    
    private init() {}
    
    static func run() { getFileData() }
    
    static func checkSolvedCount() {
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: LCPConstants.path), options: .mappedIfSafe)
            objs = try JSONDecoder().decode([LCP].self, from: jsonData)
            let count = objs.filter({$0.completed == true}).count
            print("\(count) problem solved")
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private static func getFileData() {
        do {
            let jsonData = try Data(contentsOf: URL(fileURLWithPath: LCPConstants.path), options: .mappedIfSafe)
            objs = try JSONDecoder().decode([LCP].self, from: jsonData)
            self.updateData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private static func updateData() {
        for obj in objs {
            obj.completed = LCPConstants.solved.contains(obj.name)
        }
        self.generateFileData()
    }
    
    private static func generateFileData() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(objs)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                finalJSONStr = jsonString
                self.updateFileData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private static func updateFileData() {
        do {
            try finalJSONStr.write(to: URL(fileURLWithPath: LCPConstants.path), atomically: true, encoding: .utf8)
        } catch {
            print(error.localizedDescription)
        }
    }
}














