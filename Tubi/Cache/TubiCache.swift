import Foundation

final class TubiCache<K: Hashable, V> {
    let capacity: Int
    var length = 0
    
    fileprivate let queue: DoublyLinkedList<K, V>
    fileprivate var dictionary: [K : Node<K, V>]
    
    init(capacity: Int) {
        self.capacity = capacity
        self.queue = DoublyLinkedList()
        self.dictionary = [K : Node<K, V>](minimumCapacity: self.capacity)
    }
    
    func isValid(key: K) -> Bool {
        return self.dictionary[key] != nil
    }
    
    //Even though you asked for an isValid function I still wanted to return an optional to be safe
    func get(key: K) -> V? {
        guard let node = self.dictionary[key] else { return nil }
        self.queue.remove(node: node)
        self.queue.addToHead(node: node)
        return node.value
    }
    
    func add(key: K, value: V) {
        if let node = self.dictionary[key] {
            node.value = value
            self.queue.remove(node: node)
            self.queue.addToHead(node: node)
        } else {
            let node = Node(key: key, value: value)
            
            if self.length < capacity {
                self.queue.addToHead(node: node)
                self.dictionary[key] = node
                
                self.length = self.length + 1
            } else {
                dictionary.removeValue(forKey: self.queue.tail!.key)
                self.queue.tail = self.queue.tail?.previous
                
                if let node = self.queue.tail {
                    node.next = nil
                }
                
                self.queue.addToHead(node: node)
                self.dictionary[key] = node
            }
        }
    }
}
