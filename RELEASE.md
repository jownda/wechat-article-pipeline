# GitHub Release 内容

## Release Title
公众号文章流水线 v1.0.0

## Tag
v1.0.0

## Release Description

```markdown
## 🎉 公众号文章流水线 v1.0.0 发布

自动化公众号文章创作全流程，从选题到发布一站式完成。

### ✨ 功能特点

- **多Agent协作**：情报员+主笔+美编并行工作
- **智能选题**：基于热点和纪念日自动推荐
- **自动配图**：浏览器搜索+多来源下载+质量检查
- **一键上传**：服务器代理绕过IP白名单限制

### 📦 安装

#### 方式1：一键安装（推荐）
```bash
git clone https://github.com/你的用户名/wechat-article-pipeline.git
cd wechat-article-pipeline
./install.sh
```

#### 方式2：下载压缩包
```bash
curl -L -o wechat-pipeline.tar.gz \
    https://github.com/你的用户名/wechat-article-pipeline/releases/download/v1.0.0/wechat-article-pipeline-v1.0.0.tar.gz
tar -xzf wechat-pipeline.tar.gz
cd wechat-article-pipeline
./install.sh
```

### 🚀 快速开始

```bash
# 创建文章目录
mkdir -p content-library/my-article/images

# 执行完整流程
wechat-pipeline content-library/my-article all
```

### 📋 工作流程

1. **选题调研**（情报员）- 生成 research.md
2. **文章撰写**（主笔）- 生成 article.md
3. **配图准备**（美编）- 下载 5 张配图
4. **排版上传** - 生成 HTML 并上传到公众号

### 📁 文件结构

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

### ⚙️ 配置

```bash
cp config.example.json config.json
# 编辑 config.json 填入你的公众号信息
```

### 📝 使用示例

```bash
# 分步执行
wechat-pipeline content-library/article-20250326 research
wechat-pipeline content-library/article-20250326 write
wechat-pipeline content-library/article-20250326 images
wechat-pipeline content-library/article-20250326 upload

# 一键执行
wechat-pipeline content-library/article-20250326 all
```

### ⚠️ 注意事项

- 西藏/藏族话题需严格审核资料来源
- 配图优先使用公有领域图片
- 服务器需在微信公众号IP白名单中

### 📄 文档

- [README.md](README.md) - 快速入门
- [SKILL.md](SKILL.md) - 详细文档
- [INSTALL.md](INSTALL.md) - 安装指南

### 👤 作者

米西先生 - AI自媒体运营主控

### 📜 许可证

MIT License
```

---

## 需要上传的文件

1. **wechat-article-pipeline-v1.0.0.tar.gz** - 打包的 skill 文件

生成命令：
```bash
cd ~/.stepclaw/skills/wechat-article-pipeline
./package.sh
```

---

## Git 推送命令

```bash
cd ~/.stepclaw/skills/wechat-article-pipeline

# 配置 Git
git config user.name "你的名字"
git config user.email "你的邮箱"

# 添加远程仓库
git remote add origin https://github.com/你的用户名/wechat-article-pipeline.git

# 推送
git push -u origin main
```
