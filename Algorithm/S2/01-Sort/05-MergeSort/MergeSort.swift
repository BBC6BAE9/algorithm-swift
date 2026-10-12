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

class MergeSort<E: Comparable>: Sort<E> {
//
    private var leftArray: [E] = []

    override func sort() {
        // 左半段最多有 array.count / 2 个元素，缓冲区在各次合并中复用
        leftArray = Array(array.prefix(array.count >> 1))
        sort(begin: 0, end: array.count)
    }

    /// 对[begin， end)范围的数据进行归并排序
    private func sort(begin: Int, end: Int) {
        if (end - begin < 2) { return }
        let mid = (begin + end) >> 1
        sort(begin: begin, end: mid)
        sort(begin: mid, end: end)

        merge(begin: begin, mid: mid, end: end)
    }

    /// 将[begin, mid)和[mid, end)范围的序列合并成一个有序序列
    private func merge(begin: Int, mid: Int, end: Int) {
        var li = 0
        let le = mid - begin
        var ri = mid
        let re = end
        var ai = begin

        // 备份左边的数组
        for i in 0..<le {
            leftArray[i] = array[begin + i]
        }

        while li < le { // 如果左边还没结束
            // 右边未耗尽且严格小于左边时取右边；相等时取左边，保持稳定性
            if ri < re && cmpElements(v1: array[ri], v2: leftArray[li]) < 0 {
                array[ai] = array[ri]
                ri += 1
            } else {
                array[ai] = leftArray[li]
                li += 1
            }
            ai += 1
        }
    }

}
