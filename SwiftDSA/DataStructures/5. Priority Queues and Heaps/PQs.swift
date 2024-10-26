//
//  PQs.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 22/10/24.
//

struct PriorityQueue<T> where T: Comparable {
    private var heap: [T] = []

    var isEmpty: Bool {
        return heap.isEmpty
    }

    var count: Int {
        return heap.count
    }

    // Insert an element into the priority queue
    mutating func enqueue(_ element: T) {
        heap.append(element)
        shiftUp(heap.count - 1)
    }

    // Remove and return the highest priority element
    mutating func dequeue() -> T? {
        guard !isEmpty else { return nil }
        let priorityElement = heap[0]
        // Move the last element to the top
        heap[0] = heap.removeLast()
        shiftDown(0)
        return priorityElement
    }

    // Peek at the highest priority element without removing it
    func peek() -> T? {
        return heap.first
    }

    // Private helper functions for maintaining the heap property
    private func leftChildIndex(_ index: Int) -> Int {
        return 2 * index + 1
    }

    private func rightChildIndex(_ index: Int) -> Int {
        return 2 * index + 2
    }

    private func parentIndex(_ index: Int) -> Int {
        return (index - 1) / 2
    }

    private func hasLeftChild(_ index: Int) -> Bool {
        return leftChildIndex(index) < count
    }

    private func hasRightChild(_ index: Int) -> Bool {
        return rightChildIndex(index) < count
    }

    private mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let element = heap[childIndex]
        while childIndex > 0 && element < heap[parentIndex(childIndex)] {
            heap[childIndex] = heap[parentIndex(childIndex)]
            childIndex = parentIndex(childIndex)
        }
        heap[childIndex] = element
    }

    private mutating func shiftDown(_ index: Int) {
        var parentIndex = index
        let element = heap[parentIndex]

        while hasLeftChild(parentIndex) {
            var smallerChildIndex = leftChildIndex(parentIndex)

            if hasRightChild(parentIndex) && heap[rightChildIndex(parentIndex)] < heap[smallerChildIndex] {
                smallerChildIndex = rightChildIndex(parentIndex)
            }

            if element <= heap[smallerChildIndex] {
                break
            }

            heap[parentIndex] = heap[smallerChildIndex]
            parentIndex = smallerChildIndex
        }

        heap[parentIndex] = element
    }
}
