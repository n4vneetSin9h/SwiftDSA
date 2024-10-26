//
//  DWGraph.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 26/10/24.
//

class Graph {
    var V: Int                       // number of vertices
    var adj: [[(vertex: Int, weight: Int)]] // adjacency list for weighted graph
    
    init(_ V: Int) {
        self.V = V
        adj = Array(repeating: [], count: V) // create empty array of adjacency lists
    }
    
    // Add a directed edge from vertex v to vertex w with a given weight
    func addEdge(v: Int, w: Int, weight: Int) {
        adj[v].append((vertex: w, weight: weight))
    }
    
    // Remove an edge from vertex v to vertex w
    func removeEdge(v: Int, w: Int) {
        adj[v].removeAll { $0.vertex == w }
    }
    
    // Check if there is an edge from vertex v to vertex w
    func hasEdge(v: Int, w: Int) -> Bool {
        return adj[v].contains(where: { $0.vertex == w })
    }
    
    // Get all neighbors of vertex v
    func getNeighbors(v: Int) -> [(Int, Int)] {
        return adj[v]
    }
    
    // Get the out-degree of a vertex
    func outDegree(v: Int) -> Int {
        return adj[v].count
    }
    
    // Get the in-degree of a vertex
    func inDegree(v: Int) -> Int {
        var count = 0
        for neighbors in adj {
            if neighbors.contains(where: { $0.vertex == v }) {
                count += 1
            }
        }
        return count
    }
    
    // BFS traversal from a given source s
    func BFS(s: Int) -> [Int] {
        var result = [Int]()
        var visited = Array(repeating: false, count: V)
        var queue = GQueue<Int>()
        
        visited[s] = true
        print("Starting at \(s)")
        queue.add(s)
        result.append(s)
        
        while queue.count > 0 {
            let current = queue.remove()!
            print("De-queueing \(current)")
            
            for (neighbor, _) in adj[current] {
                if !visited[neighbor] {
                    visited[neighbor] = true
                    print("Queuing \(neighbor)")
                    queue.add(neighbor)
                    result.append(neighbor)
                }
            }
        }
        
        return result
    }
    
    // DFS traversal from a given source s
    func DFS(s: Int) -> [Int] {
        var result = [Int]()
        var visited = Array(repeating: false, count: V)
        var stack = GStack<Int>()
        
        print("Starting at \(s)")
        visited[s] = true
        stack.push(s)
        
        while stack.count > 0 {
            let current = stack.pop()!
            print("Popping \(current)")
            result.append(current)
            
            for (neighbor, _) in adj[current] {
                if !visited[neighbor] {
                    visited[neighbor] = true
                    print("Pushing - \(neighbor)")
                    stack.push(neighbor)
                }
            }
        }
        
        return result
    }
}
