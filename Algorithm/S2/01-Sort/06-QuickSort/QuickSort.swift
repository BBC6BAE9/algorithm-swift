//
//  QuickSort.swift
//  Algorithm
//
//  Created by hong on 10/11/26.
//

import Foundation
/// 💡
/// 1、从序列中选出一个轴点元素（piovt）
///  - 随机选一个元素与 begin 位置交换，再以 begin 位置的元素为轴点元素
///  - 固定取 begin 时，有序序列会退化成 O(n^2)，递归深度 O(n) 可能栈溢出

/// 2、利用piovt将序列分成两个子序列
///  - 将小于piovt的元素放在piovt前面
///  - 将大于piovt的元素放在piovt后面
///  - 等于piovt的元素放在哪边都可以

/// 3、对子序列进行1、2的操作
///  - 直到不能再分割（子序列中只剩下1个元素）

/// 本质：逐渐将每一个元素变成轴点元素
class QuickSort<E: Comparable>: Sort<E> {

    override func sort() {
        sort(begin: 0, end: array.count)
    }

    func sort (begin: Int, end: Int) {
        if (end - begin < 2) { return }
        // 确定轴点位置
        let mid = piovtIndex(begin: begin, end: end)
        // 对子序列进行快速排序，跳过已经归位的轴点
        sort(begin: begin, end: mid)
        sort(begin: mid + 1, end: end)
    }


    /// 构造出[begin,  end) 范围的轴点元素
    /// - Parameters:
    /// - Returns: 轴点元素的最终位置
    func piovtIndex(begin: Int, end: Int) -> Int {
        var begin = begin
        var end = end
        // 随机选择轴点，避免有序序列导致最坏情况
        swap(i1: begin, i2: Int.random(in: begin..<end))
        // 备份begin位置的元素
        let pivot =  array[begin]
        end -= 1

        while (begin < end) {
            while (begin < end) {
                if (cmpElements(v1: pivot, v2: array[end]) < 0) { // 右边元素 > 轴点元素
                    end -= 1
                } else { // 右边元素 <= 轴点元素
                    array[begin] = array[end]
                    begin += 1

                    break
                }
            }

            while (begin < end) {
                if (cmpElements(v1: pivot, v2: array[begin]) > 0) { // 左边元素 < 轴点元素
                    begin += 1
                } else { // 左边元素 >= 轴点元素
                    array[end] = array[begin]
                    end -= 1

                    break
                }
            }
        }

        // 将轴点放到最终的位置
        array[begin] = pivot

        // begin和end重叠
        return begin
    }
}
