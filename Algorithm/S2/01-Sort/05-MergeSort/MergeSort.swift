//
//  MergeSort.swift
//  Algorithm
//
//  Created by hong on 10/11/26.
//

import Foundation

/// 💡
/// 执行流程
/// 1、不断地将当前序列平均分割成2个子序列 divide
///  - 直到不能分割（序列中只剩1个元素）
/// 2、不断地将当前序列合并成成一个有序序列 merge
///  - 直到只剩下1个有序序列

class MergeSort1<E: Comparable>: Sort<E> {
    
    override func sort() {
        sort(begin: 0, end: array.count)
    }
    
    /// 对[begin， end)范围的数据进行归并排序
    private func sort(begin: Int, end: Int) {
        if (end - begin < 2) { return }
        
        
        
    }
}
