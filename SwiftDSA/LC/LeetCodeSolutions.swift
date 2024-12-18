//
//  LeetCodeSolutions.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 26/10/24.
//

class LeetCodeSolutions {
    // MARK: Merge Sorted Array
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var i = m - 1
        var j = n - 1
        var k = m + n - 1
        
        while j >= 0 {
            if i >= 0 && nums1[i] > nums2[j] {
                nums1[k] = nums1[i]
                i -= 1
            } else {
                nums1[k] = nums2[j]
                j -= 1
            }
            k -= 1
        }
        
    }
    
    // MARK: Remove Element
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        if nums.isEmpty {
            return 0
        }
        var i = 0
        var j = nums.count - 1
        
        if i == j {
            if nums[i] == val {
                return 0
            }
            return 1
        }
        
        while i != j {
            while nums[j] == val {
                j -= 1
                if j == -1 {
                    return 0
                }
            }
            while nums[i] != val {
                i += 1
                if i == nums.count {
                    return i
                }
            }
            if j > i {
                nums[j] = nums[j] + nums[i]
                nums[i] = nums[j] - nums[i]
                nums[j] = nums[j] - nums[i]
            } else {
                return j + 1
            }
        }
        return j + 1
    }
    
    // MARK: Remove Duplicates from Sorted Array
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        if nums.isEmpty {
            return 0
        }
        var lce = nums[0]
        var uniqueCount = 1
        
        for j in nums {
            if j != lce {
                lce = j
                nums[uniqueCount] = j
                uniqueCount += 1
            }
        }
        
        return uniqueCount
    }
    
    // MARK: Majority Element
    func majorityElement(_ nums: [Int]) -> Int {
        var c = 1
        var me = nums[0]
        let n = nums.count
        for i in 1..<n {
            if me == nums[i] {
                c += 1
            } else {
                c -= 1
                if c == 0 {
                    me = nums[i]
                    c = 1
                }
            }
        }
        return me
    }
    
    // MARK: Best Time to Buy and Sell Stock
    func maxProfit(_ prices: [Int]) -> Int {
        var profit = 0
        var l = 0
        var r = 1
        while r < prices.count {
            if prices[r] - prices[l] > profit {
                profit = prices[r] - prices[l]
            }
            if prices[l] > prices[r] {
                l += 1
            } else {
                r += 1
            }
        }
        return profit
    }
    
    // MARK: Roman to Integer
    let dict = ["I": 1, "V": 5, "X": 10, "L": 50, "C": 100, "D": 500, "M": 1000,]
    
    func romanToInt(_ s: String) -> Int {
        let arr = Array(s)
        var val = 0
        
        var i = arr.count - 1
        
        while i >= 0 {
            let num = dict[String(arr[i])]!
            if 4 * num < val {
                val -= num
            } else {
                val += num
            }
            i -= 1
        }
        
        return val
    }
    
    // MARK: Length of Last Word
    func lengthOfLastWord(_ s: String) -> Int {
        var i = s.count - 1
        var count = 0
        let characters = Array(s)
        
        while i >= 0 && characters[i] == " " {
            i -= 1
        }
        
        while i >= 0 && characters[i] != " " {
            count += 1
            i -= 1
        }
        
        return count
    }
    
    // MARK: Longest Common Prefix
    func longestCommonPrefix(_ strs: [String]) -> String {
        var common = strs[0]
        for s in strs {
            while !s.hasPrefix(common) {
                common = String(common.dropLast())
                if common == "" {
                    return common
                }
            }
        }
        return common
    }
    
    // MARK: Find the Index of the First Occurrence in a String
    func strStr(_ haystack: String, _ needle: String) -> Int {
        let lastIdx = haystack.count-needle.count
        if lastIdx < 0 {
            return -1
        } else if lastIdx == 0 {
            return needle == haystack ? 0 : -1
        }
        var idx = 0
        let hArr = Array(haystack)
        
        for i in 0...lastIdx {
            if String(hArr[i..<i + needle.count]) == needle {
                idx = i
                break
            }
            if i == lastIdx-1 {
                idx = -1
            }
        }
        
        return idx
    }
    
    // MARK: Valid Palindrome
    func isPalindrome(_ s: String) -> Bool {
        let finalStr = getValidCharString(from: s).lowercased()
        let arr = Array(finalStr)
        
        let i = 0
        let j = finalStr.count-1
        
        for x in 0..<finalStr.count/2 {
            
            if arr[i + x] != arr[j - x] {
                return false
            }
        }
        
        return true
    }
    
    func getValidCharString(from str: String) -> String {
        let pattern = "[^A-Za-z0-9]+"
        return str.replacingOccurrences(of: pattern, with: "", options: [.regularExpression])
    }
    
    // MARK: Is Subsequence
    func isSubsequence(_ s: String, _ t: String) -> Bool {
        if s.isEmpty { return true }
        let arrS = Array(s)
        let arrT = Array(t)
        
        var i = 0
        var j = 0
        
        while i < arrT.count && j < arrS.count {
            if arrT[i] == arrS[j] {
                if j == arrS.count-1 {
                    return true
                }
                j += 1
            }
            i += 1
        }
        
        return false
    }
    
    // MARK: Ransom Note
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        if ransomNote.isEmpty {
            return true
        }
        if ransomNote.count > magazine.count {
            return false
        }
        var charCount: [Character: Int] = [:]
        
        for c in ransomNote {
            charCount[c, default: 0] += 1
        }
        
        for c in magazine {
            if let _ = charCount[c] {
                charCount[c]! -= 1
                if charCount[c] == 0 {
                    charCount[c] = nil
                }
            }
            if charCount.isEmpty {
                return true
            }
        }
        
        return charCount.isEmpty
    }
    
    // MARK: Isomorphic Strings
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        if s.count != t.count {
            return false
        }
        
        var sToTMap: [Character: Character] = [:]
        var tToSMap: [Character: Character] = [:]
        
        let sArray = Array(s)
        let tArray = Array(t)
        
        for i in 0..<sArray.count {
            let sChar = sArray[i]
            let tChar = tArray[i]
            
            // Check if there's a conflicting mapping from s -> t
            if let mappedChar = sToTMap[sChar], mappedChar != tChar {
                return false
            }
            
            // Check if there's a conflicting mapping from t -> s
            if let mappedChar = tToSMap[tChar], mappedChar != sChar {
                return false
            }
            
            // Establish the mappings
            sToTMap[sChar] = tChar
            tToSMap[tChar] = sChar
        }
        
        // If we pass all checks, the strings are isomorphic
        return true
    }
    
    // MARK: Word Pattern
    func wordPattern(_ pattern: String, _ s: String) -> Bool {
        let sArr = s.split(separator: " ").map({String($0)})
        if sArr.count != pattern.count {
            return false
        }
        
        let pArr = Array(pattern).map({String($0)})
        var map1: [String: String] = [:]
        var map2: [String: String] = [:]
        
        for i in 0..<pattern.count {
            if map1[pArr[i]] != nil {
                if map1[pArr[i]]! != sArr[i] {
                    return false
                }
            } else {
                map1[pArr[i]] = sArr[i]
            }
            
            if map2[sArr[i]] != nil {
                if map2[sArr[i]]! != pArr[i] {
                    return false
                }
            } else {
                map2[sArr[i]] = pArr[i]
            }
        }
        
        return true
    }
    
    // MARK: Valid Anagram
    func isAnagram(_ s: String, _ t: String) -> Bool {
        var sMap: [Character: Int] = [:]
        var tMap: [Character: Int] = [:]
        
        for c in s {
            sMap[c, default: 0] += 1
        }
        
        for c in t {
            tMap[c, default: 0] += 1
        }
        
        return sMap == tMap
    }
    
    // MARK: Two Sum
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict: [Int: Int] = [:]
        for i in 0..<nums.count {
            let num = target - nums[i]
            guard dict[num] == nil else {
                return [i, dict[num]!]
            }
            dict[nums[i]] = i
        }
        return [0,0]
    }
    
    // MARK: Happy Number
    func isHappy(_ n: Int) -> Bool {
        var slow = n
        var fast = getSumOfSquareOfAllDigits(n)
        
        while fast != 1 && slow != fast {
            slow = getSumOfSquareOfAllDigits(slow)
            fast = getSumOfSquareOfAllDigits(getSumOfSquareOfAllDigits(fast))
        }
        
        return fast == 1
    }
    
    private func getSumOfSquareOfAllDigits(_ n: Int) -> Int {
        var num = n
        var sum: Int = 0
        
        while num != 0 {
            sum += (num % 10) * (num % 10)
            num /= 10
        }
        
        return sum
    }
    
    // MARK: Contains Duplicate II
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        var map:[Int: Int] = [:]
        
        for i in 0..<nums.count {
            if let idx = map[nums[i]] {
                if abs(idx-i) <= k {
                    return true
                }
                
            }
            map[nums[i]] = i
        }
        
        return false
    }
    
    // MARK: Valid Parentheses
    func isValid(_ str: String) -> Bool {
        let dict: [Character: Character] = ["}":"{", "]":"[", ")":"("]
        
        var stacks: [Character] = []
        
        for s in str {
            switch s {
            case "{", "[", "(":
                stacks.append(s)
            case "}", "]", ")":
                if stacks.last != dict[s] { return false } else { stacks.removeLast() }
            default:
                break
            }
        }
        
        return stacks.isEmpty
    }
    
    // MARK: Linked List Cycle
    public class ListNode {
        public var val: Int
        public var next: ListNode?
        public init() { self.val = 0; self.next = nil; }
        public init(_ val: Int) { self.val = val; self.next = nil; }
        public init(_ val: Int, _ next: ListNode?) { self.val = val; self.next = next; }
        public func printList() {
            var node: ListNode? = self
            while node != nil {
                print(node!.val)
                node = node?.next
            }
        }
    }
    
    func hasCycle(_ head: ListNode?) -> Bool {
        guard head != nil else { return false }
        var slow = head
        var fast = head
        
        while let sNext = slow?.next, let fNext = fast?.next?.next {
            slow = sNext
            fast = fNext
            if fast === slow {
                return true
            }
        }
        
        return false
    }
    
    // MARK: Merge Two Sorted Lists
    func mergeTwoLists(_ list1: ListNode?, _ list2: ListNode?) -> ListNode? {
        var node1 = list1
        var node2 = list2
        var listNode: ListNode? = nil
        var currentNode: ListNode? = nil
        
        if node1 == nil {
            return node2
        }
        if node2 == nil {
            return node1
        }
        
        while (node1 != nil || node2 != nil) {
            if node1 == nil {
                currentNode!.next = node2
                break
            }
            if node2 == nil {
                currentNode!.next = node1
                break
            }
            if listNode == nil {
                getCurrentNodeValue(&listNode, node1: &node1, node2: &node2)
                currentNode = listNode!
            } else {
                getCurrentNodeValue(&currentNode!.next, node1: &node1, node2: &node2)
                currentNode = currentNode!.next
            }
        }
        
        return listNode
    }
    
    func getCurrentNodeValue(_ list: inout ListNode?, node1: inout ListNode?, node2: inout ListNode?) {
        if node1!.val > node2!.val {
            list = ListNode(node2!.val)
            node2 = node2!.next
        } else {
            list = ListNode(node1!.val)
            node1 = node1!.next
        }
    }
    
    // MARK: Search Insert Position
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        var l = 0
        var r = nums.count
        
        while l < r {
            let m = (l + r) / 2
            if nums[m] == target {
                return m
            } else if nums[m] < target {
                l = m + 1
            } else {
                r = m
            }
        }
        
        return l
    }
    
    // MARK: Add Binary
    func addBinary(_ a: String, _ b: String) -> String {
        var result = ""
        var carry = 0
        var i = a.count - 1
        var j = b.count - 1
        
        let aArray = Array(a)
        let bArray = Array(b)
        
        while i >= 0 || j >= 0 || carry > 0 {
            let bitA = (i >= 0) ? aArray[i].wholeNumberValue! : 0
            let bitB = (j >= 0) ? bArray[j].wholeNumberValue! : 0
            
            // Calculate sum of bits and carry
            let sum = bitA + bitB + carry
            result.append(String(sum % 2)) // Append the result bit
            carry = sum / 2 // Calculate new carry
            
            i -= 1
            j -= 1
        }
        
        // Reverse the result to get the correct order
        return String(result.reversed())
    }
    
    // MARK: Palindrome Number
    func isPalindrome(_ x: Int) -> Bool {
        var n = x
        var r = 0
        while n > 0 {
            r = r * 10 + n % 10
            n /= 10
        }
        
        return r == x
    }
    
    // MARK: Plus One
    func plusOne(_ digits: [Int]) -> [Int] {
        var arr = digits
        for i in 0..<digits.count {
            let idx = digits.count - i - 1
            
            if arr[idx] == 9 {
                arr[idx] = 0
                if idx == 0 {
                    arr.insert(1, at: 0)
                }
            } else {
                arr[idx] += 1
                break
            }
        }
        
        return arr
    }
    
    // MARK: Sqrt(x)
    func mySqrt(_ x: Int) -> Int {
        if x < 2 {
            return x  // sqrt(0) is 0 and sqrt(1) is 1
        }
        
        var left = 1
        var right = x / 2
        var result = 0
        
        while left <= right {
            let mid = left + (right - left) / 2
            let square = mid * mid
            
            if square == x {
                return mid
            } else if square < x {
                result = mid
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        
        return result
    }
    
    // MARK: Climbing Stairs
    func climbStairs(_ n: Int) -> Int {
        var sum = 0
        
        for i in (n/2 + (n % 2))...n {
            let countOfTwo = n % i
            if countOfTwo == 0 {
                sum += 1
            } else {
                sum += combinations(i, countOfTwo)
            }
        }
        
        return sum
    }
    
    func combinations(_ i: Int, _ x: Int) -> Int {
        // Ensure x is the smaller value for fewer multiplications
        let x = min(x, i - x)
        if x == 0 { return 1 }  // iC0 = 1
        
        var result = 1
        for j in 0..<x {
            result *= (i - j)
            result /= (j + 1)
        }
        
        return result
    }
    
    // MARK: Remove Duplicates from Sorted Array II
    func removeDuplicates2(_ nums: inout [Int]) -> Int {
        if nums.isEmpty { return 0 }
        
        var repititionAvailable = 1
        
        var lce = nums[0]
        var uniqueCount = 1
        
        for j in 1..<nums.count {
            if nums[j] != lce {
                repititionAvailable = 1
                lce = nums[j]
                nums[uniqueCount] = nums[j]
                uniqueCount += 1
            } else {
                if repititionAvailable > 0 {
                    repititionAvailable -= 1
                    lce = nums[j]
                    nums[uniqueCount] = nums[j]
                    uniqueCount += 1
                }
            }
        }
        
        return uniqueCount
    }
    
    // MARK: Rotate Array
    func rotate(_ nums: inout [Int], _ k: Int) {
        reverse(&nums, 0, nums.count-1)
        reverse(&nums, 0, k % nums.count-1)
        reverse(&nums, k % nums.count, nums.count-1)
    }
    
    func reverse(_ nums: inout [Int], _ start: Int, _ end: Int) {
        var start = start
        var end = end
        while start < end {
            nums[end] = nums[start] + nums[end]
            nums[start] = nums[end] - nums[start]
            nums[end] = nums[end] - nums[start]
            start += 1
            end -= 1
        }
    }
    
    // MARK: Best Time to Buy and Sell Stock II
    func maxProfit2(_ prices: [Int]) -> Int {
        var b = 0
        var s = 1
        var otp = 0
        var p = 0
        
        while s < prices.count {
            if prices[s] - prices[b] > otp {
                otp = prices[s] - prices[b]
            }
            if prices[s] < prices[b] || prices[s] < prices[s-1] {
                b = s
                p += otp
                otp = 0
            } else if s == prices.count - 1 {
                p += otp
            }
            s += 1
        }
        
        return p
    }
    
    // MARK: Jump Game
    func canJump(_ nums: [Int]) -> Bool {
        var i = nums.count - 1
        var k = 1
        
        while i > 0 {
            if nums[i - k] >= k {
                i -= k
                k = 1
            } else {
                k += 1
                if k > i {
                    return false
                }
            }
        }
        
        return i == 0
    }
    
    // MARK: Jump Game II
    func jump(_ nums: [Int]) -> Int {
        var jumps = 0 // To track the number of jumps
        var currentEnd = 0 // The end of the current jump range
        var farthest = 0 // The farthest position we can reach
        
        for i in 0..<nums.count - 1 {
            farthest = max(farthest, i + nums[i]) // Update the farthest we can reach
            if i == currentEnd { // If we have reached the end of the current jump range
                jumps += 1 // We need to make a jump
                currentEnd = farthest // Update the end of the current jump to the farthest we can reach
            }
        }
        
        return jumps
    }
    
    // MARK: H-Index
    func hIndex(_ citations: [Int]) -> Int {
        var arr = Array(repeating: 0, count: citations.count + 1)
        
        for citation in citations {
            if citation >= arr.count {
                arr[arr.count - 1] += 1
            } else {
                arr[citation] += 1
            }
        }
        
        var sum = 0
        
        for i in 0..<arr.count {
            let idx = arr.count-1 - i
            sum += arr[idx]
            if sum >= idx {
                return idx
            }
        }
        
        return 0
    }
    
    // MARK: Insert Delete GetRandom O(1)
    class RandomizedSet {
        
        var dict: [Int: Bool]
        
        init() {
            dict = [:]
        }
        
        func insert(_ val: Int) -> Bool {
            
            guard dict[val] == nil else { return false }
            
            dict[val] = true
            return true
        }
        
        func remove(_ val: Int) -> Bool {
            
            guard dict[val] != nil else { return false }
            dict[val] = nil
            return true
            
        }
        
        func getRandom() -> Int {
            return dict.keys.randomElement()!
        }
    }
    
    // MARK: Product of Array Except Self
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var result = Array(repeating: 1, count: nums.count)
        
        var lp = 1
        for i in 1..<nums.count {
            lp *= nums[i-1]
            result[i] = lp
        }
        
        lp = 1
        for i in (0..<nums.count-1).reversed() {
            lp *= nums[i+1]
            result[i] *= lp
        }
        
        return result
    }
    
    // MARK: Two Sum II - Input Array Is Sorted
    func twoSum2(_ numbers: [Int], _ target: Int) -> [Int] {
        var i = 0
        var j = numbers.count - 1
        
        while i != j {
            let sum = numbers[i] + numbers[j]
            if target == sum {
                return [i+1, j+1]
            } else if sum > target {
                j -= 1
            } else {
                i += 1
            }
        }
        return [i+1, j+1]
    }
    
    // MARK: Longest Substring Without Repeating Characters
    func lengthOfLongestSubstring(_ s: String) -> Int {
        var seen: [Character: Int] = [:]  // Stores the last index of each character
        var maxLength = 0
        var start = 0  // The start of the current substring window
        
        for (index, char) in s.enumerated() {
            // If the character was seen and its last occurrence is within the current window
            if let lastSeenIndex = seen[char], lastSeenIndex >= start {
                start = lastSeenIndex + 1  // Move the start to the next index after the duplicate
            }
            
            // Update the character's latest index
            seen[char] = index
            
            // Calculate the current substring length and update maxLength
            maxLength = max(maxLength, index - start + 1)
        }
        
        return maxLength
    }
    
    // MARK: Rotate Image
    func rotate(_ matrix: inout [[Int]]) {
        let N = matrix[0].count
        for i in 0..<N-1 {
            for j in 0..<N-1-i {
                let temp = matrix[N-1-j][N-1-i]
                matrix[N-1-j][N-1-i] = matrix[i][j]
                matrix[i][j] = temp
            }
        }
        matrix.reverse()
    }
    
    // MARK: Candy
    func candy(_ ratings: [Int]) -> Int {
        if ratings.isEmpty {
            return 0
        }
        if ratings.count == 1 {
            return 1
        }
        
        let n = ratings.count
        var candies = Array(repeating: 1, count: n)
        
        // First pass: left to right
        for i in 1..<n {
            if ratings[i] > ratings[i - 1] {
                candies[i] = candies[i - 1] + 1
            }
        }
        
        // Second pass: right to left
        for i in (0..<(n - 1)).reversed() {
            if ratings[i] > ratings[i + 1] {
                candies[i] = max(candies[i], candies[i + 1] + 1)
            }
        }
        
        return candies.reduce(0, +)
    }
    
    // MARK: Gas Station
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        var totalGas = 0
        var totalCost = 0
        var currentGas = 0
        var startIndex = 0
        
        for i in 0..<gas.count {
            totalGas += gas[i]
            totalCost += cost[i]
            currentGas += gas[i] - cost[i]
            
            if currentGas < 0 {
                startIndex = i + 1
                currentGas = 0
            }
        }
        
        return totalGas >= totalCost ? startIndex : -1
    }
    
    // MARK: Integer to Roman
    func intToRoman(_ num: Int) -> String {
        // Mapping values to Roman numerals in descending order
        let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        let symbols = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        
        var num = num
        var result = ""
        
        while num > 0 {
            for (ind, number) in values.enumerated() where num - number >= 0 {
                num -= number
                result += symbols[ind]
                break
            }
        }
        
        return result
    }
    
    // MARK: Maximum Depth of Binary Tree
    public class TreeNode {
        public var val: Int
        public var left: TreeNode?
        public var right: TreeNode?
        public init() { self.val = 0; self.left = nil; self.right = nil; }
        public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
        public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
            self.val = val
            self.left = left
            self.right = right
        }
    }
    
    class Solution {
        
        var max = 0
        
        func maxDepth(_ root: TreeNode?) -> Int {
            guard root != nil else { return 0 }
            return dfs(root, 0)
        }
        
        func dfs(_ node: TreeNode?,_ current: Int) -> Int {
            guard node != nil else { return current }
            if current > max {
                max = current
            }
            let left = dfs(node!.left, current + 1)
            let right = dfs(node!.right, current + 1)
            
            return left > right ? left : right
        }
    }
    
    // MARK: Reverse Words in a String
    func reverseWords(_ s: String) -> String {
        return s.split(separator: " ").reversed().joined(separator: " ")
    }
    
    // MARK: Trapping Rain Water
    func trap(_ height: [Int]) -> Int {
        var left = 0, right = height.count - 1
        var leftMax = 0, rightMax = 0
        var waterTrapped = 0
        
        while left < right {
            if height[left] < height[right] {
                if height[left] >= leftMax {
                    leftMax = height[left]
                } else {
                    waterTrapped += leftMax - height[left]
                }
                left += 1
            } else {
                if height[right] >= rightMax {
                    rightMax = height[right]
                } else {
                    waterTrapped += rightMax - height[right]
                }
                right -= 1
            }
        }
        
        return waterTrapped
    }
    
    // MARK: Zigzag Conversion
    func convert(_ s: String, _ numRows: Int) -> String {
        if numRows == 1 || numRows >= s.count { return s }
        
        var rows = Array(repeating: "", count: numRows)
        var currentRow = 0
        var goingDown = false
        
        for char in s {
            rows[currentRow] += String(char)
            if currentRow == 0 || currentRow == numRows - 1 {
                goingDown.toggle()
            }
            currentRow += goingDown ? 1 : -1
        }
        
        return rows.joined()
    }
    
    // MARK: Text Justification
    func fullJustify(_ words: [String], _ maxWidth: Int) -> [String] {
        var result = [String]()
        var currentLine = [String]()
        var lineLength = 0
        
        for word in words {
            if lineLength + word.count + currentLine.count > maxWidth {
                for i in 0..<maxWidth - lineLength {
                    currentLine[i % (currentLine.count - 1 > 0 ? currentLine.count - 1 : 1)] += " "
                }
                result.append(currentLine.joined())
                currentLine = [word]
                lineLength = word.count
            } else {
                currentLine.append(word)
                lineLength += word.count
            }
        }
        
        let lastLine = currentLine.joined(separator: " ")
        result.append(lastLine + String(repeating: " ", count: maxWidth - lastLine.count))
        
        return result
    }
    
    // MARK: Container With Most Water
    func maxArea(_ height: [Int]) -> Int {
        var left = 0
        var right = height.count - 1
        var maxArea = 0
        while left != right {
            let area = min(height[left], height[right]) * (right - left)
            if maxArea < area {
                maxArea = area
            }
            
            if height[left] < height[right] {
                left += 1
            } else {
                right -= 1
            }
        }
        
        return maxArea
    }
    
    // MARK: 3Sum
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let nums = nums.sorted()
        var result = [[Int]]()
        
        for i in 0..<nums.count {
            if i > 0 && nums[i] == nums[i - 1] { continue }  // Avoid duplicates
            
            var left = i + 1
            var right = nums.count - 1
            
            while left < right {
                let sum = nums[i] + nums[left] + nums[right]
                if sum == 0 {
                    result.append([nums[i], nums[left], nums[right]])
                    while left < right && nums[left] == nums[left + 1] { left += 1 }
                    while left < right && nums[right] == nums[right - 1] { right -= 1 }
                    left += 1
                    right -= 1
                } else if sum < 0 {
                    left += 1
                } else {
                    right -= 1
                }
            }
        }
        
        return result
    }
    
    // MARK: Minimum Size Subarray Sum
    func minSubArrayLen(_ target: Int, _ nums: [Int]) -> Int {
        var left = 0
        var sum = 0
        var minLength = Int.max
        
        for right in 0..<nums.count {
            sum += nums[right]
            
            while sum >= target {
                minLength = min(minLength, right - left + 1)
                sum -= nums[left]
                left += 1
            }
        }
        
        return minLength == Int.max ? 0 : minLength
    }
    
    // MARK: Substring with Concatenation of All Words
    func findSubstring(_ s: String, _ words: [String]) -> [Int] {
        guard !s.isEmpty, !words.isEmpty else { return [] }
        
        let wordLength = words[0].count
        //        let substringLength = wordLength * words.count
        let totalLength = s.count
        var result = [Int]()
        
        // Word count map for words list
        var wordCount = [String: Int]()
        for word in words {
            wordCount[word, default: 0] += 1
        }
        
        let sArray = Array(s)
        
        // Slide over each possible starting position in the string
        for i in 0..<wordLength {
            var left = i, count = 0
            var currentCount = [String: Int]()
            
            for j in stride(from: i, to: totalLength - wordLength + 1, by: wordLength) {
                let word = String(sArray[j..<j+wordLength])
                
                // If word is in the list
                if let requiredCount = wordCount[word] {
                    currentCount[word, default: 0] += 1
                    count += 1
                    
                    // If we have more of 'word' than needed, slide left pointer
                    while currentCount[word]! > requiredCount {
                        let leftWord = String(sArray[left..<left+wordLength])
                        currentCount[leftWord]! -= 1
                        left += wordLength
                        count -= 1
                    }
                    
                    // If all words matched, store the starting index
                    if count == words.count {
                        result.append(left)
                    }
                    
                } else {
                    // Reset if word is not in words
                    currentCount.removeAll()
                    count = 0
                    left = j + wordLength
                }
            }
        }
        
        return result
    }
    
    // MARK: Minimum Window Substring
    func minWindow(_ s: String, _ t: String) -> String {
        guard !s.isEmpty, !t.isEmpty else { return "" }
        
        // Step 1: Build a hashmap for the target characters in `t`
        var tCount = [Character: Int]()
        for char in t {
            tCount[char, default: 0] += 1
        }
        
        // Step 2: Initialize pointers and variables
        var left = 0
        var minLength = Int.max
        var minStart = 0
        var windowCount = [Character: Int]()
        var formed = 0
        let required = tCount.count
        let sArray = Array(s) // Convert `s` to an array for easier access by index
        
        // Step 3: Slide the `right` pointer to expand the window
        for right in 0..<sArray.count {
            let char = sArray[right]
            windowCount[char, default: 0] += 1
            
            if let countInT = tCount[char], windowCount[char] == countInT {
                formed += 1
            }
            
            // Step 4: Once we have a valid window, contract it from the left
            while formed == required {
                let windowSize = right - left + 1
                if windowSize < minLength {
                    minLength = windowSize
                    minStart = left
                }
                
                let leftChar = sArray[left]
                windowCount[leftChar]! -= 1
                if let countInT = tCount[leftChar], windowCount[leftChar]! < countInT {
                    formed -= 1
                }
                
                left += 1
            }
        }
        
        return minLength == Int.max ? "" : String(sArray[minStart..<minStart + minLength])
    }
    
    // MARK: Group Anagrams
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var anagrams = [String: [String]]()
        
        for str in strs {
            // Sort the characters of the string to create a key
            let sortedStr = String(str.sorted())
            
            // Group by the sorted string
            anagrams[sortedStr, default: []].append(str)
        }
        
        // Return all the grouped anagrams
        return Array(anagrams.values)
    }
    
    // MARK: Longest Consecutive Sequence
    func longestConsecutive(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }
        
        // Create a set for quick lookup of elements
        let numSet = Set(nums)
        var longestStreak = 0
        
        for num in numSet {
            // Only start counting if it's the beginning of a sequence
            if !numSet.contains(num - 1) {
                var currentNum = num
                var currentStreak = 1
                
                // Count consecutive numbers
                while numSet.contains(currentNum + 1) {
                    currentNum += 1
                    currentStreak += 1
                }
                
                // Update longest streak
                longestStreak = max(longestStreak, currentStreak)
            }
        }
        
        return longestStreak
    }
    
    // MARK: Valid Sudoku
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        var rows = Array(repeating: Set<Character>(), count: 9)
        var cols = Array(repeating: Set<Character>(), count: 9)
        var boxes = Array(repeating: Set<Character>(), count: 9)
        
        for i in 0..<9 {
            for j in 0..<9 {
                let char = board[i][j]
                
                if char == "." {
                    continue
                }
                
                // Check row
                if rows[i].contains(char) {
                    return false
                }
                rows[i].insert(char)
                
                // Check column
                if cols[j].contains(char) {
                    return false
                }
                cols[j].insert(char)
                
                // Check 3x3 box
                let boxIndex = (i / 3) * 3 + j / 3
                if boxes[boxIndex].contains(char) {
                    return false
                }
                boxes[boxIndex].insert(char)
            }
        }
        
        return true
    }
    
    // MARK: Spiral Matrix
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        let count = (matrix.count + 1) / 2
        let row = matrix.count
        let col = matrix[0].count
        var result: [Int] = []
        
        for i in 0..<count {
            
            for j in i..<col - i - 1 {
                let x = i
                let y = j
                result.append(matrix[x][y])
                if result.count == row * col { break }
            }
            
            for j in i..<row - i - 1 {
                let x = j
                let y = col - i - 1
                result.append(matrix[x][y])
                if result.count == row * col { break }
            }
            
            for j in i..<col - i - 1 {
                let x = row - i - 1
                let y = col - j - 1
                result.append(matrix[x][y])
                if result.count == row * col { break }
            }
            
            for j in i..<row - i - 1 {
                let x = row - j - 1
                let y = i
                result.append(matrix[x][y])
                if result.count == row * col { break }
            }
            
            if result.count == row * col { break }
        }
        
        if result.count == row * col - 1 {
            result.append(matrix[row / 2][col / 2])
        }
        
        return result
    }
    
    // MARK: Set Matrix Zeroes
    func setZeroes(_ grid: inout [[Int]]) {
        var rows: Set<Int> = .init()
        var cols: Set<Int> = .init()
        
        for row in 0..<grid.count {
            for col in 0..<grid[0].count {
                if grid[row][col] == 0 {
                    rows.insert(row)
                    cols.insert(col)
                }
            }
        }
        
        for row in 0..<grid.count {
            if rows.contains(row) {
                for col in 0..<grid[0].count {
                    grid[row][col] = 0
                }
            } else {
                for col in cols {
                    grid[row][col] = 0
                }
            }
        }
    }
    
    // MARK: Game of Life
    func gameOfLife(_ board: inout [[Int]]) {
        let rows = board.count
        let cols = board[0].count
        
        // Iterate through each cell to determine the next state
        for row in 0..<rows {
            for col in 0..<cols {
                let liveNeighbors = countLiveNeighbors(board, row, col)
                
                // Mark cells for transition using bit manipulation
                if board[row][col] == 1 {
                    if liveNeighbors == 2 || liveNeighbors == 3 {
                        board[row][col] = 3  // Mark cell as live in the next state
                    }
                } else {
                    if liveNeighbors == 3 {
                        board[row][col] = 2  // Mark cell as live in the next state
                    }
                }
            }
        }
        
        // Update board to the next state by shifting bits
        for row in 0..<rows {
            for col in 0..<cols {
                board[row][col] >>= 1  // Right shift to get the next state
            }
        }
    }
    
    // Helper function to count live neighbors
    func countLiveNeighbors(_ board: [[Int]], _ row: Int, _ col: Int) -> Int {
        let directions = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]
        var liveCount = 0
        
        for (dr, dc) in directions {
            let newRow = row + dr
            let newCol = col + dc
            if newRow >= 0 && newRow < board.count && newCol >= 0 && newCol < board[0].count {
                liveCount += board[newRow][newCol] & 1  // Check the least significant bit
            }
        }
        
        return liveCount
    }
    
    // MARK: Summary Ranges
    func summaryRanges(_ nums: [Int]) -> [String] {
        guard !nums.isEmpty else { return [] }
        
        var result = [String]()
        var start = nums[0]
        
        for i in 1..<nums.count {
            // Check if the current number is not consecutive
            if nums[i] != nums[i - 1] + 1 {
                if start == nums[i - 1] {
                    result.append("\(start)")
                } else {
                    result.append("\(start)->\(nums[i - 1])")
                }
                start = nums[i]
            }
        }
        
        // Handle the last range
        if start == nums.last! {
            result.append("\(start)")
        } else {
            result.append("\(start)->\(nums.last!)")
        }
        
        return result
    }
    
    // MARK: Merge Intervals
    func merge(_ intervals: [[Int]]) -> [[Int]] {
        guard intervals.count > 1 else { return intervals }
        
        // Sort intervals by the start time
        let sortedIntervals = intervals.sorted { $0[0] < $1[0] }
        var mergedIntervals: [[Int]] = []
        
        // Initialize the first interval
        var currentInterval = sortedIntervals[0]
        
        for i in 1..<sortedIntervals.count {
            let interval = sortedIntervals[i]
            
            // Check if intervals overlap
            if interval[0] <= currentInterval[1] {
                // Merge the intervals by updating the end of the current interval
                currentInterval[1] = max(currentInterval[1], interval[1])
            } else {
                // No overlap, so add the current interval to the result and update it
                mergedIntervals.append(currentInterval)
                currentInterval = interval
            }
        }
        
        // Add the last interval
        mergedIntervals.append(currentInterval)
        
        return mergedIntervals
    }
    
    // MARK: Insert Interval
    func insert(_ intervals: [[Int]], _ newInterval: [Int]) -> [[Int]] {
        var result = [[Int]]()
        var i = 0
        let n = intervals.count
        
        // Add all intervals that come before the new interval
        while i < n && intervals[i][1] < newInterval[0] {
            result.append(intervals[i])
            i += 1
        }
        
        // Merge intervals that overlap with the new interval
        var mergedInterval = newInterval
        while i < n && intervals[i][0] <= mergedInterval[1] {
            mergedInterval[0] = min(mergedInterval[0], intervals[i][0])
            mergedInterval[1] = max(mergedInterval[1], intervals[i][1])
            i += 1
        }
        result.append(mergedInterval)
        
        // Add all intervals that come after the merged interval
        while i < n {
            result.append(intervals[i])
            i += 1
        }
        
        return result
    }
    
    // MARK: Minimum Number of Arrows to Burst Balloons
    func findMinArrowShots(_ points: [[Int]]) -> Int {
        guard points.count > 1 else { return points.count }
        
        // Sort balloons by their end coordinates
        let sortedPoints = points.sorted { $0[1] < $1[1] }
        
        var arrows = 1
        var lastEnd = sortedPoints[0][1]
        
        for point in sortedPoints {
            // If the current balloon starts after the last arrow's end position, we need a new arrow
            if point[0] > lastEnd {
                arrows += 1
                lastEnd = point[1]
            }
        }
        
        return arrows
    }
    
    // MARK: Min Stack
    class MinStack {
        
        var items: [Int] = []
        
        var minStack: [Int] = []
        
        var min: Int = Int.max
        
        init() {
            
        }
        
        func push(_ val: Int) {
            if min >= val {
                self.min = val
                minStack.append(val)
            }
            
            items.append(val)
        }
        
        func pop() {
            if items.isEmpty {
                return
            }
            
            let val = items.removeLast()
            
            if val == min {
                _ = minStack.removeLast()
                self.min = minStack.last ?? Int.max
            }
        }
        
        func top() -> Int {
            items.last ?? Int.min
        }
        
        func getMin() -> Int {
            self.min
        }
    }
    
    // MARK: Simplify Path
    func simplifyPath(_ path: String) -> String {
        var stack = [String]()
        let components = path.split(separator: "/") // Split by `/`
        
        for component in components {
            switch component {
            case "..":
                // Go up one directory (pop from stack if not empty)
                if !stack.isEmpty {
                    stack.removeLast()
                }
            case ".", "":
                // Ignore current directory `.` and empty components
                continue
            default:
                // Push the directory onto the stack
                stack.append(String(component))
            }
        }
        
        // Reconstruct the path by joining the stack with `/`
        return "/" + stack.joined(separator: "/")
    }
    
    // MARK: Evaluate Reverse Polish Notation
    func evalRPN(_ tokens: [String]) -> Int {
        var result: [Int] = []
        for val in tokens {
            if let num = Int(val) {
                result.append(num)
            } else {
                switch val {
                case "+":
                    result.append(result.removeLast() + result.removeLast())
                    break
                case "-":
                    result.append(-result.removeLast() + result.removeLast())
                    break
                case "*":
                    result.append(result.removeLast() * result.removeLast())
                    break
                case "/":
                    result.append(Int(1/(Double(result.removeLast()) / Double(result.removeLast()))))
                    break
                default:
                    break
                }
            }
        }
        
        return result.last!
    }
    
    // MARK: Basic Calculator
    func calculate(_ s: String) -> Int {
        var result = 0
        var currentNumber = 0
        var sign = 1
        var stack = [Int]()
        
        for char in s {
            if let digit = char.wholeNumberValue {
                // Accumulate current number if digit
                currentNumber = currentNumber * 10 + digit
            } else if char == "+" {
                // Process addition
                result += sign * currentNumber
                currentNumber = 0
                sign = 1
            } else if char == "-" {
                // Process subtraction
                result += sign * currentNumber
                currentNumber = 0
                sign = -1
            } else if char == "(" {
                // Push result and sign onto stack
                stack.append(result)
                stack.append(sign)
                // Reset result and sign for new expression inside parentheses
                result = 0
                sign = 1
            } else if char == ")" {
                // Process closing parenthesis
                result += sign * currentNumber
                currentNumber = 0
                // Pop from stack
                result *= stack.removeLast()  // sign before parentheses
                result += stack.removeLast()  // result calculated before parentheses
            }
        }
        
        // Add any remaining number to the result
        result += sign * currentNumber
        return result
    }
    
    // MARK: Add Two Numbers
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        let dummyHead = ListNode(0)
        var current = dummyHead
        var p = l1, q = l2
        var carry = 0
        
        while p != nil || q != nil {
            let x = p?.val ?? 0
            let y = q?.val ?? 0
            let sum = carry + x + y
            carry = sum / 10
            current.next = ListNode(sum % 10)
            current = current.next!
            
            if p != nil { p = p?.next }
            if q != nil { q = q?.next }
        }
        
        if carry > 0 {
            current.next = ListNode(carry)
        }
        
        return dummyHead.next
    }
    
}
