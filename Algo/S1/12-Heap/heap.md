# 堆Heap

堆（Heap）也是一种树状的数据结构（不要跟内存模型中的“堆空间”混淆），常见的堆实现有

- 二叉队（Binary Heap， 完全二叉堆）👈 常用

- 多叉队（D-heap， D-ay Heap）
- 索引堆（Index Heap）
- 二项堆（Binomial Heap）
- 斐波那契堆（Fibonacci Heap）
- 左倾堆



堆的一个重要的性质：任意节点的值总是≥（≤）子节点的值



≥ 最大堆，大根堆、大顶堆

≤ 最小堆，小根堆、小顶堆



堆中的元素必须具有可比较性（跟二叉搜索树一样）

```swift
func getSize() -> Int    // 元素的数量
func isEmpty() -> Bool   // 是否为空
func clear() 			 			 // 清空
func add(element: E)     // 添加元素
func get() -> E   		   // 获取堆顶元素
func remove() -> E   	   // 删除堆顶元素
func replace(element: E) // 删除堆顶元素的同时插入一个新元素
```



# 二叉堆

二叉树的逻辑结构就是一棵完全二叉树，所以也叫完全二叉树

鉴于完全二叉树的一些特性，二叉队的底层（物理结构）一般使用数组实现



## 索引i的一些规律（元素的总是是n）

- i == 0，他是二叉堆的根节点
- 如果 i > 0， 它的父节点编号为floor(( i - 1) / 2)

- 如果2i + 1 ≤ n - 1，它的左子节点的编号为2i+1
- 如果2i + 1 > n - 1，它无左子节点

- 如果2i + 2 ≤ n - 1，它的右子节点的编号为2i+2

- 如果2i + 2 > n - 1，它无右子节点

### 添加

### 删除
1、用最后一个节点覆盖根节点
2、删除最后一个节点
3、循环执行以下操作（图中的43简称为node）

- 如果node < 子节点，与最大的子节点交换位置
- 如果node > 子节点，或者node没有子节点，推出循环

这个过程我们称之为下滤（Sift Down）, 时间复杂度： O(logn)

同样的，交换位置的操作可以像添加那样进行优化

# 最大堆 - 批量建堆（Heapify）

下面的两种算法的思想是，先把局部变成最大堆，逐步扩散到全局

## 最大堆 - 批量建堆 - 自上而下的上滤
```Swift
for(int i =1; i < n; i++) {
    siftUp(i)
}
```
## 最大堆 - 批量建堆 - 自下而上的上下滤


```Swift
for(int i = (size >> 1) - 1; i >= n; i--) {
    siftDown(i)
}
```

## 最大 - 批量建堆 - 效率对比
  
> 小顶堆可以直接复用大顶堆的代码，只需要修改比较策略




## Top K问题

从n个整数中，找出最大的前K个数（k远远小于n）

- 如果使用排序算法进行全排序，需要O(nlogn)的时间复杂度

- 使用二叉堆来解决，可以使用O(nlogK)的时间复杂度来解决

☕️ 自己去了解一下堆排序

## 优先级队列（Priority Queue）

优先级队列也是一个队列，因此也是提供以下接口

```Swift
func getSize() -> Int     // 元素的数量
func isEmpty() -> Bool    // 是否唯恐
func enqueue(element: E)  // 入队
func dequeue() -> E       // 出队
func front() -> E         // 获取队列的头元素
func clear()              // 获取队列的头元素
```

- 普通队列是FIFO，先进先出
- 优先级队列是优先级最高的元素最先出队 

应用场景

医院的夜间门诊
- 队列元素是病人
- 优先级是病情的严重情况、挂号时间

操作系统的多任务调度
- 队列元素是任务
- 优先级是任务类型

## 优先级队列的底层实现




