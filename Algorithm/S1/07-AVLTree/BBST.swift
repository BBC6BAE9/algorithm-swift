//
//  BBST.swift
//  Algo
//
//  Created by hong on 4/21/25.
//

import Foundation

class BBST<T: Comparable>: BST<T> {
    
    func afterRotate(grand: Node<T>, parent: Node<T>?, child: Node<T>?) {
        // 让parent称为子树的根节点
        parent?.parent = grand.parent
        if grand.isLeftChild() {
            grand.parent?.left = parent
        } else if (grand.isRightChild()) {
            grand.parent?.right = parent
        } else {
            root = parent
        }
        
        if let child = child {
            child.parent = grand
        }
        
        grand.parent = parent
    }
    
    func rotate(r: Node<T>,  // 子树的根节点，一定有值
                        b: Node<T>,  // 一定有值
                        c: Node<T>?,
                        d: Node<T>,  // 一定有值
                        e: Node<T>?,
                        f: Node<T>,  // 一定有值
    ) {
        // 1、让d称为这颗子树的根节点
        d.parent = r.parent
        if r.isLeftChild() {
            r.parent?.left = d
        } else if r.isRightChild() {
            r.parent?.right = d
        } else {
            root = d
        }
        
        b.right = c
        if let c = c {
            c.parent = b
        }
        
        // 3、处理e-f-g
        
        f.left = e
        if let e = e {
            e.parent = f
        }

        // 4、处理 b - d - f
        d.left = b
        d.right = f
        
        b.parent = d
        f.parent = d
        
    }
    
    // 左旋转
    func rotateLeft(_ grand: Node<T>?) {
        guard let grand = grand else {
            return
        }
        let parent = grand.right
        let child = parent?.left
        grand.right = child
        parent?.left = grand
        
        afterRotate(grand: grand, parent: parent, child: child)
    }
    
    // 右旋转
    func rotateRight(_ grand: Node<T>?) {
        guard let grand = grand else {
            return
        }
        let parent = grand.left
        let child = parent?.right
        grand.left = child
        parent?.right = grand
        
        afterRotate(grand: grand, parent: parent, child: child)
    }
}
