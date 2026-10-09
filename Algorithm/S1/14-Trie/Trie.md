## Trie

## 需求



如何判断一堆不重复的字符串，是否以某个前缀开头

[abc, add, friend, girl],   是否有gi开头的字符串



- 用set或map存储字符串
- 遍历所有的字符串进行判断
- 时间复杂度O(n)



有没有更好的数据结构可以做这个需求，答案是肯定的



- Trie也叫做字典树，前缀树（Prefix Tree）、单词查找树
- Trie搜索字符串的效率主要跟字符串的长度有关
- 假设使用Trie存储cat、dog、doggy、does、cast、add六个单词



## 接口设计

```swift
func getSize() -> Int
func isEmpty() -> Bool
func clear()
func contains(str: String) -> Bool
func add(str: String)
func remove(str: String)
func startWith(prefix: String) -> Bool
```

更为通用的接口设计（希望在存储字符串的同时，同时存储额外的信息，比如说通讯录）

```swift
func getSize() -> Int
func isEmpty() -> Bool
func clear()
func contains(str: String) -> Bool
func add(str: String, value: V)
func remove(str: String) -> V
func startWith(prefix: String) -> Bool
```





