# 公众号文章流水线 Skill

自动化公众号文章创作全流程，从选题到发布一站式完成。

## 安装

### 方式1：一键安装（推荐）

```bash
# 下载 skill
git clone https://github.com/yourusername/wechat-article-pipeline.git
cd wechat-article-pipeline

# 运行安装脚本
./install.sh

# 添加到 PATH（如果提示）
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 方式2：手动安装

```bash
# 复制到 OpenClaw skills 目录
mkdir -p ~/.stepclaw/skills/
cp -r wechat-article-pipeline ~/.stepclaw/skills/

# 创建快捷命令
mkdir -p ~/.local/bin
cat > ~/.local/bin/wechat-pipeline << 'EOF'
#!/bin/bash
exec "$HOME/.stepclaw/skills/wechat-article-pipeline/pipeline.sh" "$@"
EOF
chmod +x ~/.local/bin/wechat-pipeline

# 添加到 PATH
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### 依赖安装

```bash
# Python 依赖（用于 Markdown 转 HTML）
pip3 install markdown

# 系统依赖
# macOS: 无需额外依赖
# Linux: apt-get install expect
```

## 配置

1. 复制配置文件：
```bash
cp config.example.json config.json
```

2. 编辑 `config.json`，填入你的微信公众号信息

3. 配置服务器（用于上传）：
   - 服务器需在微信公众号IP白名单中
   - 部署 `wx_proxy.py` 代理服务

## 使用方法

### 方式1：分步执行

```bash
# 1. 选题调研
openclaw skills run wechat-article-pipeline --task research --topic "西藏历史"

# 2. 审核选题后，撰写文章
openclaw skills run wechat-article-pipeline --task write --dir content-library/article-20250326

# 3. 准备配图
openclaw skills run wechat-article-pipeline --task images --dir content-library/article-20250326

# 4. 排版上传
openclaw skills run wechat-article-pipeline --task upload --dir content-library/article-20250326
```

### 方式2：一键执行（需人工审核）

```bash
./pipeline.sh content-library/article-20250326 all
```

## 工作流程

```
┌─────────────┐    ┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  情报员      │───▶│   主笔      │───▶│   美编      │───▶│  排版上传    │
│ (main-5)    │    │ (main-3)    │    │ (main-2)    │    │             │
│ 选题调研     │    │ 撰写文章     │    │ 配图下载     │    │ 生成HTML     │
│ 输出research │    │ 输出article  │    │ 输出images/  │    │ 上传公众号   │
└─────────────┘    └─────────────┘    └─────────────┘    └─────────────┘
```

## 文件结构

```
article-YYYYMMDD/
├── research.md       # 选题调研报告
├── article.md        # 原始文章
├── article.html      # 排版后HTML
├── images/           # 配图目录
│   ├── cover.jpg
│   ├── body1.jpg
│   ├── body2.jpg
│   ├── body3.jpg
│   └── body4.jpg
└── download-log.md   # 配图下载日志
```

## 注意事项

1. **西藏/藏族话题**：需严格审核资料来源
2. **配图版权**：优先使用公有领域图片
3. **服务器配置**：确保IP在白名单中
4. **API限制**：避免频繁调用

## 示例

### 示例：西藏民主改革文章

```bash
# 创建目录
mkdir -p content-library/xizang-20250326/images

# 执行流水线
./pipeline.sh content-library/xizang-20250326 all
```

产出：
- 标题：《从农奴到主人：1959年西藏百万农奴翻身记》
- 字数：约2400字
- 配图：5张
- 发布时间：3月28日纪念日

## 作者

米西先生 - AI自媒体运营主控

## 版本

v1.0.0 (2026-03-26)
