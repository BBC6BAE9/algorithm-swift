//
//  BianryTree.swift
//  Algo
//
//  Created by hong on 4/19/25.
//

import Foundation

class BinaryTree<T: Comparable>  {
    
    var asString:String { return root?.asString ?? ""}
    
    public var size: Int = 0
    
    var root: Node<T>?
    
    func getRoot() -> Any? {
        return root
    }
    
    func getSize() -> Int {
        return size
    }
    
    func isEmpty() -> Bool {
        return size == 0
    }
    
    func clear(){
        root = nil
        size = 0
    }
    
    /// 前序遍历【递归】
    /// 根结点、前序遍历左子树、前序遍历右子树
    func preorderTraversal() {
        preorderTraversal(node: root)
    }
    
    private func preorderTraversal(node: Node<T>?) {
        guard let node = node else {
            return
        }
        print(node.element)
        preorderTraversal(node: node.left)
        preorderTraversal(node: node.right)
    }
    
    /// 中序遍历
    /// 中序遍历左子树、根结点、中序遍历右子树
    func inorderTraversal() {
        inorderTraversal(node: root)
    }
    
    private func inorderTraversal(node: Node<T>?) {
        guard let node = node else {
            return
        }
        inorderTraversal(node: node.left)
        print(node.element)
        inorderTraversal(node: node.right)
    }
    
    /// 中序遍历
    /// 中序遍历左子树、中序遍历右子树、根结点
    func postorderTraversal() {
        postorderTraversal(node: root)
    }
    
    private func postorderTraversal(node: Node<T>?) {
        guard let node = node else {
            return
        }
        postorderTraversal(node: node.left)
        postorderTraversal(node: node.right)
        print(node.element)
    }
    
    /// 层序遍历
    func levelOrderTravrtsal() {
        guard let root = root else {
            return
        }
        let queue = Queue<Node<T>>()
        queue.enQueue(element: root)
        
        while !queue.isEmpty() {
            let node = queue.deQueue()!
            print(node.element)
            
            if let leftNode = node.left {
                queue.enQueue(element: leftNode)
            }
            
            if let rightNode = node.right {
                queue.enQueue(element: rightNode)
            }
        }
    }
    
    /// 创建一个新节点
    public func createNode(element: T, parent: Node<T>?) -> Node<T> {
        return Node(element: element, parent: parent)
    }
    
    // 【迭代】二叉树的高度
    func height() -> Int {
        guard let root = root else {
            return 0
        }
        
        var height = 0
        
        var levelSize = 1
        
        let queue = Queue<Node<T>>()
        queue.enQueue(element: root)
        
        while !queue.isEmpty() {
            let node = queue.deQueue()!
            levelSize -= 1
            if let leftNode = node.left {
                queue.enQueue(element: leftNode)
            }
            
            if let rightNode = node.right {
                queue.enQueue(element: rightNode)
            }
            
            if levelSize == 0 { // 意味着即将要访问下一层
                levelSize = queue.size()
                height += 1
            }
        }
        
        return height
    }
    
    /// 【递归】二叉树的高度
    func height2() -> Int {
        let height = height(node: root)
        return height
    }
    
    private func height(node: Node<T>?) -> Int {
        if node == nil {
            return 0
        }
        let left = height(node: node?.left)
        let right = height(node: node?.left)
        return 1 + max(left, right)
    }
    
    // 获取一个节点的前驱节点
    // 前驱节点（predecessor）中序遍历时的前一个节点
    
    public func predecessor(node: Node<T>?) -> Node<T>? {
        var node = node
        if node == nil {
            return nil
        }
        
        // 前驱节点在左子树中（left.right.right.right...）
        if let leftNode = node?.left {
            var p: Node<T>? = leftNode
            while (p?.right != nil){
                p = p?.right
            }
            return p
        }
        
        // 从父节点、祖父节点中寻找前驱节点
        while(node?.parent != nil && node == node?.parent?.left){
            node = node?.parent
        }
        
        return node?.parent
    }
    
    // 获取一个节点的后继节点
    public func successor(node: Node<T>?) -> Node<T>? {
        var node = node
        if node == nil {
            return nil
        }
        
        // 前驱节点在左子树中（right.left.left.left...）
        if let leftNode = node?.right {
            var p: Node<T>? = leftNode
            while (p?.right != nil){
                p = p?.left
            }
            return p
        }
        
        // 从父节点、祖父节点中寻找前驱节点
        while(node?.parent != nil && node == node?.parent?.right){
            node = node?.parent
        }
        
        return node?.parent
    }
    
    class Node<E: Comparable>: Equatable {
    
        var asString:String { return treeString(self){("\($0.element)",$0.left,$0.right)}  }
        
        static func == (lhs: BST<T>.Node<E>, rhs: BST<T>.Node<E>) -> Bool {
            lhs.element == rhs.element
        }
        
        var element: E
        var left: Node<E>?
        var right: Node<E>?
        var parent: Node<E>?
        
        init(element: E, parent: Node<E>?) {
            self.element = element
            self.parent = parent
        }
        
        /// 是否是叶子节点
        func isLeaf() -> Bool {
            return left == nil && right == nil
        }
        
        /// 是否有两个子节点
        func hasTwoChildren() -> Bool {
            return left != nil && right != nil
        }
        
        /// 当前节点是否是父节点的左子节点
        func isLeftChild() -> Bool {
            return parent != nil && self == parent?.left
        }
        
        /// 当前节点是否是父节点的右子节点
        func isRightChild() -> Bool {
            return parent != nil && self == parent?.right
        }
        
        /// 访问兄弟节点
        func sibling() -> Node<E>? {
            if isLeftChild() {
                return parent?.right
            }
            
            if isRightChild() {
                return parent?.left
            }
            
            return nil
        }
    }
}

public func treeString<T>(_ node:T, reversed:Bool=false, isTop:Bool=true, using nodeInfo:(T)->(String,T?,T?)) -> String
{
    // node value string and sub nodes
    let (stringValue, leftNode, rightNode) = nodeInfo(node)
    
    let stringValueWidth  = stringValue.count
    
    // recurse to sub nodes to obtain line blocks on left and right
    let leftTextBlock     = leftNode  == nil ? []
    : treeString(leftNode!,reversed:reversed,isTop:false,using:nodeInfo)
        .components(separatedBy:"\n")
    
    let rightTextBlock    = rightNode == nil ? []
    : treeString(rightNode!,reversed:reversed,isTop:false,using:nodeInfo)
        .components(separatedBy:"\n")
    
    // count common and maximum number of sub node lines
    let commonLines       = min(leftTextBlock.count,rightTextBlock.count)
    let subLevelLines     = max(rightTextBlock.count,leftTextBlock.count)
    
    // extend lines on shallower side to get same number of lines on both sides
    let leftSubLines      = leftTextBlock
    + Array(repeating:"", count: subLevelLines-leftTextBlock.count)
    let rightSubLines     = rightTextBlock
    + Array(repeating:"", count: subLevelLines-rightTextBlock.count)
    
    // compute location of value or link bar for all left and right sub nodes
    //   * left node's value ends at line's width
    //   * right node's value starts after initial spaces
    let leftLineWidths    = leftSubLines.map{$0.count}
    let rightLineIndents  = rightSubLines.map{$0.prefix{$0==" "}.count  }
    
    // top line value locations, will be used to determine position of current node & link bars
    let firstLeftWidth    = leftLineWidths.first   ?? 0
    let firstRightIndent  = rightLineIndents.first ?? 0
    
    
    // width of sub node link under node value (i.e. with slashes if any)
    // aims to center link bars under the value if value is wide enough
    //
    // ValueLine:    v     vv    vvvvvv   vvvvv
    // LinkLine:    / \   /  \    /  \     / \
    //
    let linkSpacing       = min(stringValueWidth, 2 - stringValueWidth % 2)
    let leftLinkBar       = leftNode  == nil ? 0 : 1
    let rightLinkBar      = rightNode == nil ? 0 : 1
    let minLinkWidth      = leftLinkBar + linkSpacing + rightLinkBar
    let valueOffset       = (stringValueWidth - linkSpacing) / 2
    
    // find optimal position for right side top node
    //   * must allow room for link bars above and between left and right top nodes
    //   * must not overlap lower level nodes on any given line (allow gap of minSpacing)
    //   * can be offset to the left if lower subNodes of right node
    //     have no overlap with subNodes of left node
    let minSpacing        = 2
    let rightNodePosition = zip(leftLineWidths,rightLineIndents[0..<commonLines])
        .reduce(firstLeftWidth + minLinkWidth)
    { max($0, $1.0 + minSpacing + firstRightIndent - $1.1) }
    
    
    // extend basic link bars (slashes) with underlines to reach left and right
    // top nodes.
    //
    //        vvvvv
    //       __/ \__
    //      L       R
    //
    let linkExtraWidth    = max(0, rightNodePosition - firstLeftWidth - minLinkWidth )
    let rightLinkExtra    = linkExtraWidth / 2
    let leftLinkExtra     = linkExtraWidth - rightLinkExtra
    
    // build value line taking into account left indent and link bar extension (on left side)
    let valueIndent       = max(0, firstLeftWidth + leftLinkExtra + leftLinkBar - valueOffset)
    let valueLine         = String(repeating:" ", count:max(0,valueIndent))
    + stringValue
    let slash             = reversed ? "\\" : "/"
    let backSlash         = reversed ? "/"  : "\\"
    let uLine             = reversed ? "¯"  : "_"
    // build left side of link line
    let leftLink          = leftNode == nil ? ""
    : String(repeating: " ", count:firstLeftWidth)
    + String(repeating: uLine, count:leftLinkExtra)
    + slash
    
    // build right side of link line (includes blank spaces under top node value)
    let rightLinkOffset   = linkSpacing + valueOffset * (1 - leftLinkBar)
    let rightLink         = rightNode == nil ? ""
    : String(repeating:  " ", count:rightLinkOffset)
    + backSlash
    + String(repeating:  uLine, count:rightLinkExtra)
    
    // full link line (will be empty if there are no sub nodes)
    let linkLine          = leftLink + rightLink
    
    // will need to offset left side lines if right side sub nodes extend beyond left margin
    // can happen if left subtree is shorter (in height) than right side subtree
    let leftIndentWidth   = max(0,firstRightIndent - rightNodePosition)
    let leftIndent        = String(repeating:" ", count:leftIndentWidth)
    let indentedLeftLines = leftSubLines.map{ $0.isEmpty ? $0 : (leftIndent + $0) }
    
    // compute distance between left and right sublines based on their value position
    // can be negative if leading spaces need to be removed from right side
    let mergeOffsets      = indentedLeftLines
        .map{$0.count}
        .map{leftIndentWidth + rightNodePosition - firstRightIndent - $0 }
        .enumerated()
        .map{ rightSubLines[$0].isEmpty ? 0  : $1 }
    
    
    // combine left and right lines using computed offsets
    //   * indented left sub lines
    //   * spaces between left and right lines
    //   * right sub line with extra leading blanks removed.
    let mergedSubLines    = zip(mergeOffsets.enumerated(),indentedLeftLines)
        .map{ ( $0.0, $0.1, $1 + String(repeating:" ", count:max(0,$0.1)) ) }
        .map{ $2 + String(rightSubLines[$0].dropFirst(max(0,-$1))) }
    
    // Assemble final result combining
    //  * node value string
    //  * link line (if any)
    //  * merged lines from left and right sub trees (if any)
    let treeLines = [leftIndent + valueLine]
    + (linkLine.isEmpty ? [] : [leftIndent + linkLine])
    + mergedSubLines
    
    return (reversed && isTop ? treeLines.reversed(): treeLines)
        .joined(separator:"\n")
}
