# 公众号文章流水线

自动化公众号文章创作全流程，从选题到发布一站式完成。

## 功能特点

- **多Agent协作**：情报员+主笔+美编+数据分析师并行工作
- **选题智能**：基于热点和纪念日自动推荐
- **配图自动**：浏览器搜索+多来源下载+质量检查
- **一键上传**：服务器代理绕过IP白名单限制
- **数据复盘**：定期数据分析，优化反馈给所有子代理

## 使用场景

- 历史人文类公众号
- 文化科普类内容
- 人物传记类文章
- 节日/纪念日热点

## 快速开始

### 1. 配置服务器（首次使用）

在 `~/.stepclaw/.server-credentials` 中添加：
```
SERVER_IP=your_server_ip
SERVER_USER=ubuntu
SERVER_PASS=your_password
```

服务器需要：
- 已配置微信公众号IP白名单
- 运行 wx_proxy.py 代理服务

### 2. 启动流水线

```bash
# 创建文章工作目录
mkdir -p content-library/article-YYYYMMDD/images

# 派出情报员选题
openclaw skills run wechat-article-pipeline --task research --topic "西藏历史"

# 审核选题后，并行派出主笔+美编
openclaw skills run wechat-article-pipeline --task write --article-dir content-library/article-YYYYMMDD
openclaw skills run wechat-article-pipeline --task images --article-dir content-library/article-YYYYMMDD

# 排版上传
openclaw skills run wechat-article-pipeline --task upload --article-dir content-library/article-YYYYMMDD
```

## 详细流程

### 第一步：选题调研（情报员）

**输入**：主题关键词（如"西藏历史"）
**输出**：`research.md`

包含：
- 3个备选选题
- 核心素材（时间、地点、人物、事件）
- 资料来源（百度百科/维基百科）
- 爆款潜力评分

### 第二步：文章撰写（主笔）

**输入**：`research.md`
**输出**：`article.md`

要求：
- 2000-2500字
- 标题+导语+正文+金句
- 引用史料来源
- 结构清晰，情感共鸣

### 第三步：配图准备（美编）

**输入**：文章主题
**输出**：`images/` 目录

流程：
1. 浏览器搜索相关图片
2. 多来源下载（维基→百度→必应）
3. 重试机制（3次尝试）
4. 质量检查（>10KB，尺寸合适）
5. 生成下载日志

### 第四步：排版上传

**输入**：`article.md` + `images/`
**输出**：微信公众号草稿

流程：
1. Markdown转HTML
2. 插入配图URL
3. 服务器代理上传
4. 返回 draft media_id

## 文件结构

```
article-YYYYMMDD/
├── research.md       # 选题调研报告
├── article.md        # 原始文章
├── article.html      # 排版后HTML
├── images/           # 配图目录
│   ├── cover.jpg     # 封面图
│   ├── body1.jpg     # 正文配图1
│   ├── body2.jpg     # 正文配图2
│   ├── body3.jpg     # 正文配图3
│   └── body4.jpg     # 正文配图4
└── download-log.md   # 配图下载日志
```

## 配置说明

### 微信公众号配置

在 `wx_upload_lv.py` 中配置：
```python
APPID = "your_appid"
SECRET = "your_secret"
```

### 服务器配置

服务器需要安装：
- Python 3
- wx_proxy.py 代理服务
- 配置微信公众号IP白名单

## 注意事项

1. **西藏/藏族话题**：需严格审核资料来源，避免敏感内容
2. **配图版权**：优先使用公有领域图片（维基百科）
3. **上传限制**：单张图片<2MB，文章总大小<10MB
4. **频率限制**：避免频繁调用微信API

## 示例

### 示例1：西藏历史文章

```bash
# 选题
openclaw skills run wechat-article-pipeline --task research --topic "西藏民主改革"

# 审核后执行
openclaw skills run wechat-article-pipeline --task write --dir content-library/xizang-20250326
openclaw skills run wechat-article-pipeline --task images --dir content-library/xizang-20250326
openclaw skills run wechat-article-pipeline --task upload --dir content-library/xizang-20250326
```

产出：
- 标题：《从农奴到主人：1959年西藏百万农奴翻身记》
- 字数：约2400字
- 配图：5张
- 发布时间：3月28日纪念日

## 故障排查

### 浏览器无法使用
- 检查 Chrome 钥匙串配置
- 重启 OpenClaw gateway

### 上传失败
- 检查服务器IP是否在白名单
- 检查 wx_proxy.py 是否运行
- 检查 APPID/SECRET 是否正确

### 配图下载失败
- 使用浏览器手动搜索下载
- 或准备本地备用图片

## 第六步：数据复盘（数据分析师）

**周期**：每周/每月（可配置）

**任务**：
1. 收集文章数据（阅读量、点赞、分享、评论）
2. 分析爆款文章特征
3. 生成复盘报告
4. 优化建议反馈给所有子代理

**输出**：`analytics-report.md`

### 复盘内容

| 指标 | 说明 |
|------|------|
| 总阅读量 | 本周/月总阅读 |
| 爆款文章数 | 阅读量>1万的文章 |
| 最佳选题 | 阅读量最高的选题类型 |
| 最佳发布时间 | 阅读量最高的发布时段 |
| 配图效果 | 有配图vs无配图的阅读对比 |

### 优化反馈

数据分析师将复盘结果反馈给：
- **情报员**：优化选题方向
- **主笔**：优化写作风格
- **美编**：优化配图策略

### 执行命令

```bash
# 生成周报
openclaw skills run wechat-article-pipeline --task analytics --period weekly

# 生成月报
openclaw skills run wechat-article-pipeline --task analytics --period monthly
```

## 版本历史

- v1.0.0 (2026-03-26): 初始版本，支持完整流水线

## 作者

米西先生 - AI自媒体运营主控
