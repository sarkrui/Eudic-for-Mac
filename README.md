## Eudic-for-Mac

一键安装欧路词典并导入第三方 mdict 词库（牛津高阶词典）

#### 效果展示

![](https://i.imgur.com/zC1P0pt.gif)


#### 安装展示

![](https://i.imgur.com/OvVuKXy.gif)


#### 一键安装

```bash
export LANG="zh_CN.UTF-8" && sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/sarkrui/Eudic-for-Mac@master/Eudic_cn.sh)"
```


<details>
  <summary>安装成功</summary>
  <img src="https://i.imgur.com/QUPZKPt.png" alt="image-20200818182209777" style="zoom:40%;" />
</details>

#### 启用词库
<details>
  <summary>点击展开</summary>
  <img src="https://i.imgur.com/Xy9lUcB.png" alt="image-20200818182209777" style="zoom:40%;" />
  <img src="https://i.imgur.com/K8JDSud.png" alt="image-20200818182352595" style="zoom:40%;" />
</details>
#### 重新激活

```bash
export LANG="zh_CN.UTF-8" && sh -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/sarkrui/Eudic-for-Mac@master/Activation.sh)"
```

#### 手动安装

<details>
  <summary>点击展开</summary>

  1. 克隆库
  ```bash
  git clone https://github.com/sarkrui/Eudic-for-Mac.git
  ```

  2. 更改工作路径
  ```bash
   cd Eudic-for-Mac
  ```
  3. 执行脚本
  ```bash
  chmod +x Eudic && ./Eudic
  ```
  4. 添加第三方 mdict 词典
  - 下载 [牛津高阶 mdict 词库](https://github.com/sarkrui/Eudic-for-Mac/releases/download/1.0.1/Oxford_mdict.zip) 
  -  解压压缩包
  -  将 `mdict` 文件拖拽进欧路词典的`词典管理`页面
    </details>
