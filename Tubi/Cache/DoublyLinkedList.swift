import Foundation

final class Node<K, V> {
    var next: Node?
    var previous: Node?
    var key: K
    var value: V?
    
    init(key: K, value: V?) {
        self.key = key
        self.value = value
    }
}

final class DoublyLinkedList<K, V> {
    var head: Node<K, V>?
    var tail: Node<K, V>?
    
    init() {}
    
    func addToHead(node: Node<K, V>) {
        if self.head == nil  {
            self.head = node
            self.tail = node
        } else {
            let temp = self.head
            
            self.head?.previous = node
            self.head = node
            self.head?.next = temp
        }
    }
    
    func remove(node: Node<K, V>) {
        if node === self.head {
            if self.head?.next != nil {
                self.head = self.head?.next
                self.head?.previous = nil
            } else {
                self.head = nil
                self.tail = nil
            }
        } else if node.next != nil {
            node.previous?.next = node.next
            node.next?.previous = node.previous
        } else {
            node.previous?.next = nil
            self.tail = node.previous
        }
    }
}
