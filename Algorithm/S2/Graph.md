# 递归（Recursion）

函数（方法）直接或者间接调用自身，是一种常用的编程技巧

```swift
func sum(n: Int) -> Int {
	if (n < 1) return n
	return n + sum(n-1)
}
```

## 递归现象

【例1】

从前有座山

山里有座庙

庙里有个老和尚

老和尚在给小和尚讲故事

讲的什么呢

从前有座山

...



【例2】

GNU 是 GNU is Not Unix

CNU - GNU is Not Unix - GNU is Not Unix  is Not Unix



【例3】

假设A在一个电影院，想知道自己在哪一排，但是前面的人很多，

A懒得数，于是问B【你坐在哪一排】，只要把B的答案加一，就是A的排数

B懒得数，于是问C【你坐在哪一排】，只要把C的答案加一，就是B的排数

C懒得数，于是问D【你坐在哪一排】，只要把D的答案加一，就是C的排数



## 函数调用过程

```java
public static main(String[] args) {
	test1()
	test2()
}

public static test1() {}

public static test2() {
	test3(30)
}

public static test3() {
```

1、函数main调用的时候会分配栈空间（内存），内存用来放东西，放【参数】、【局部变量】

2、test1函数进入栈空间

3、test1函数执行完成之后，test1退出栈空间

4、test1函数进入栈空间

5、test3函数进入栈空间

6、test3函数执行完成之后，test3退出栈空间

7、test2退出栈空间

8、main退出栈空间

整个过程很像栈的push和pop 



## 递归函数的调用过程

```java
public static main(String[] args) {
	sum(4)
}

func sum(n: Int) -> Int {
	if (n < 1) return n
	return n + sum(n-1)
}
```

1、main args入栈

2、sum  n = 4  return 4 + sum(3) 入栈

3、sum  n = 3  return 3 + sum(2) 入栈

4、sum  n = 2  return 2 + sum(1) 入栈

5、sum  n = 1  return 1 入栈

6、sum  n = 1  return 1 出栈

4、sum  n = 2  return 2 + sum(1) 出栈

3、sum  n = 3  return 3 + sum(2) 出栈

2、sum  n = 4  return 4 + sum(3) 出栈

1、main args出栈



如果递归算法调用没有终止，将会一直消耗空间，最终导栈内存溢出（Stack Overflow）

所以必须要有一个明确的递归结束的条件

也叫做边界条件、递归基



## 实例分析

求1+2+3+...+(n-1)+n的和（n > 0）

```java
int sum(int n) {
	if (n < 1) return n;
	return n+ sum(n - 1);
}
```

总消耗时间：T(n) =  T(n) + O(1)

时间复杂度：O(n)

空间复杂度：O(n)



```java
int sum(int n) {
	int result = 0;
	
	for(int i =1; i<=n; i++) {
		return += i;
	}
	return result;
}
```

时间复杂度：O(n)

空间复杂度：O(1)



```java
int sum(int n) {
	if n < 1 return n;
	return (1 + n) * n >> 1;
}
```

时间复杂度：O(1)

空间复杂度：O(1)



使用递归不是为了求最优解决，是为了简化解决问题的思路，代码会更加简洁



## 递归的思想

拆解问题

- 把规模较大的问题编程规模较小的同类问题
- 把规模较小的问题不断编程规模更小的问题
- 规模小到一定程度可以直接得出它的解



求解

- 由最小规模问题解得出较大规模问题的解

- 由较大规模的问题的解不断得出规模更大问题的解
- 最后得出原来问题的解



凡是可以利用上诉思想解决问题的，都可以尝试使用递归

很多链表、二叉树相关的问题都是可以用递归来解决

因为链表、二叉树本身就是递归的结构（链表中包含链表，二叉树中包含二叉树）



## 递归的使用套路

