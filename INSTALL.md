# 安装指南

## 快速安装

### 1. 下载并解压

```bash
# 下载压缩包
curl -L -o wechat-article-pipeline-v1.0.0.tar.gz \
    https://github.com/yourusername/wechat-article-pipeline/releases/download/v1.0.0/wechat-article-pipeline-v1.0.0.tar.gz

# 解压
tar -xzf wechat-article-pipeline-v1.0.0.tar.gz
cd wechat-article-pipeline
```

### 2. 运行安装脚本

```bash
./install.sh
```

### 3. 配置

```bash
# 复制配置模板
cp config.example.json config.json

# 编辑配置
nano config.json
```

填入你的信息：
```json
{
  "wechat": {
    "appid": "your_appid",
    "secret": "your_secret"
  },
  "server": {
    "ip": "your_server_ip",
    "user": "ubuntu",
    "password": "your_password"
  }
}
```

### 4. 验证安装

```bash
wechat-pipeline --help
```

## 使用方法

### 创建新文章

```bash
# 创建目录
mkdir -p content-library/my-article/images

# 执行流水线
wechat-pipeline content-library/my-article all
```

### 分步执行

```bash
# 1. 选题调研
wechat-pipeline content-library/my-article research

# 2. 撰写文章（审核选题后）
wechat-pipeline content-library/my-article write

# 3. 准备配图
wechat-pipeline content-library/my-article images

# 4. 排版上传
wechat-pipeline content-library/my-article upload
```

## 卸载

```bash
rm -rf ~/.stepclaw/skills/wechat-article-pipeline
rm ~/.local/bin/wechat-pipeline
```

## 故障排查

### 命令找不到
```bash
# 检查 PATH
echo $PATH | grep ".local/bin"

# 手动添加
export PATH="$HOME/.local/bin:$PATH"
```

### 权限不足
```bash
chmod +x ~/.local/bin/wechat-pipeline
chmod +x ~/.stepclaw/skills/wechat-article-pipeline/*.sh
chmod +x ~/.stepclaw/skills/wechat-article-pipeline/*.py
chmod +x ~/.stepclaw/skills/wechat-article-pipeline/*.exp
```

### 上传失败
- 检查服务器IP是否在微信公众号白名单
- 检查 wx_proxy.py 是否在服务器运行
- 检查 APPID/SECRET 是否正确

## 更新

```bash
# 下载新版本
tar -xzf wechat-article-pipeline-v1.1.0.tar.gz
cd wechat-article-pipeline

# 重新安装（会覆盖旧版本）
./install.sh
```
