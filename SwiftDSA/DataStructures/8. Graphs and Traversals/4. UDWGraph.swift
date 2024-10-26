//
//  UDWGraph.swift
//  SwiftDSA
//
//  Created by Navneet Singh on 26/10/24.
//

struct WeightedEdge {
    let vertex: Int
    let weight: Int
}

class UDWGraph {
    var V = 0                       // number of vertices
    var adj = [[WeightedEdge]]()    // adjacency list for weighted edges
    
    init(_ V: Int) {
        self.V = V
        for _ in 0..<V {
            adj.append([WeightedEdge]()) // create empty array of adjacency lists
        }
    }
    
    // Add an undirected edge with weight from vertex v to vertex w
    func addEdge(v: Int, w: Int, weight: Int) {
        adj[v].append(WeightedEdge(vertex: w, weight: weight))
        adj[w].append(WeightedEdge(vertex: v, weight: weight)) // Add the reverse edge
    }
    
    // Remove an undirected edge between vertex v and vertex w
    func removeEdge(v: Int, w: Int) {
        adj[v].removeAll(where: { $0.vertex == w })
        adj[w].removeAll(where: { $0.vertex == v }) // Remove the reverse edge
    }
    
    // Check if there is an edge between vertex v and vertex w
    func hasEdge(v: Int, w: Int) -> Bool {
        return adj[v].contains(where: { $0.vertex == w })
    }
    
    // Get all neighbors of vertex v
    func getNeighbors(v: Int) -> [(vertex: Int, weight: Int)] {
        return adj[v].map { ($0.vertex, $0.weight) }
    }
    
    // Get the out-degree of a vertex (same as the total edges for undirected)
    func outDegree(v: Int) -> Int {
        return adj[v].count
    }
    
    // BFS traversal from a given source s
    func BFS(s: Int) -> [Int] {
        var result = [Int]()
        var visited = adj.map { _ in false }
        var queue = GQueue<Int>()
        
        visited[s] = true
        print("Starting at \(s)")
        queue.add(s)
        result.append(s)
        
        while queue.count > 0 {
            let current = queue.remove()!
            print("De-queueing \(current)")
            
            for edge in adj[current] {
                let n = edge.vertex
                if visited[n] == false {
                    visited[n] = true
                    print("Queuing \(n) with weight \(edge.weight)")
                    queue.add(n)
                    result.append(n)
                }
            }
        }
        
        return result
    }
    
    // DFS traversal from a given source s
    func DFS(s: Int) -> [Int] {
        var result = [Int]()
        var visited = adj.map { _ in false }
        var stack = GStack<Int>()
        
        print("Starting at \(s)")
        visited[s] = true
        stack.push(s)
        
        while stack.count > 0 {
            let current = stack.pop()!
            print("Popping \(current)")
            result.append(current)
            
            for edge in adj[current] {
                let n = edge.vertex
                if visited[n] == false {
                    visited[n] = true
                    print("Pushing - \(n) with weight \(edge.weight)")
                    stack.push(n)
                }
            }
        }
        
        return result
    }
}
