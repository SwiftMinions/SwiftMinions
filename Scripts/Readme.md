# 腳本

```bash

├── Readme.md 				
├── bootstrap.sh			
# Carthage 專用，如果有包含其他的 dependencies 會 Checkout 並且幫你 build 此專案.
├── build.sh				
# Carthage 專用，單純 Build 此專案專用
├── not_so_important.sh
└── trunk.sh
# Cocoapods 專用， 可以讓此專案被 Cocoapods 找到的關鍵。
# cf. https://guides.cocoapods.org/making/getting-setup-with-trunk.html

```

## 如果使用

當你有新版本要發布，請先確認兩步驟，先 build 過專案沒問題之後

1.

```bash 
# 確認 Carthage build 沒問題 
sh bootstrap.sh
```


2. 

```bash 
# 確認 Carthage build 沒問題 
sh trunk.sh
```

> 樓上如果推不上去的原因是，請聯絡 contributors，Cocoapods 需要原先的 contributors 把你加入權限。

