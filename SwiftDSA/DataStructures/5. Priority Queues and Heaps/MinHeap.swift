//
//  MinHeap.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 26/10/24.
//

struct MinHeap<T: Comparable> {
    private var elements: [T] = []

    // Check if the heap is empty
    var isEmpty: Bool {
        return elements.isEmpty
    }

    // Get the number of elements in the heap
    var count: Int {
        return elements.count
    }

    // Insert a new element into the heap
    mutating func insert(_ value: T) {
        elements.append(value)
        siftUp(from: elements.count - 1)
    }

    // Remove and return the minimum element (the root) from the heap
    mutating func extractMin() -> T? {
        guard !elements.isEmpty else { return nil }
        if elements.count == 1 {
            return elements.removeLast()
        }
        
        let minValue = elements[0]
        elements[0] = elements.removeLast()
        siftDown(from: 0)
        
        return minValue
    }

    // Peek at the minimum element (the root) without removing it
    func peek() -> T? {
        return elements.first
    }

    // Sift up the element at the specified index to maintain the heap property
    private mutating func siftUp(from index: Int) {
        var childIndex = index
        let childValue = elements[childIndex]

        while childIndex > 0 {
            let parentIndex = (childIndex - 1) / 2
            if childValue >= elements[parentIndex] { break }
            elements[childIndex] = elements[parentIndex]
            childIndex = parentIndex
        }
        elements[childIndex] = childValue
    }

    // Sift down the element at the specified index to maintain the heap property
    private mutating func siftDown(from index: Int) {
        var parentIndex = index
        let parentValue = elements[parentIndex]

        while true {
            let leftChildIndex = 2 * parentIndex + 1
            let rightChildIndex = 2 * parentIndex + 2
            var minIndex = parentIndex

            if leftChildIndex < elements.count && elements[leftChildIndex] < elements[minIndex] {
                minIndex = leftChildIndex
            }

            if rightChildIndex < elements.count && elements[rightChildIndex] < elements[minIndex] {
                minIndex = rightChildIndex
            }

            if minIndex == parentIndex { break }
            elements[parentIndex] = elements[minIndex]
            parentIndex = minIndex
        }
        elements[parentIndex] = parentValue
    }

    // Function to return all elements in the heap
    func allElements() -> [T] {
        return elements
    }
}
