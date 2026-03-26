#!/bin/bash
# 数据分析复盘脚本

set -e

PERIOD="${1:-weekly}"
WORK_DIR="${2:-content-library}"
REPORT_FILE="$WORK_DIR/analytics-report-${PERIOD}-$(date +%Y%m%d).md"

echo "=== 公众号数据复盘 ==="
echo "周期: $PERIOD"
echo "时间: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""

# 收集数据
echo "【1/4】收集文章数据..."

# 统计文章数量
ARTICLE_COUNT=$(find "$WORK_DIR" -name "article.md" | wc -l)
echo "  文章总数: $ARTICLE_COUNT"

# 统计选题类型
echo ""
echo "【2/4】分析选题分布..."
echo "  选题类型统计:"
grep -r "选题" "$WORK_DIR"/*/research.md 2>/dev/null | head -10 || echo "  暂无数据"

# 生成报告
echo ""
echo "【3/4】生成复盘报告..."

cat > "$REPORT_FILE" << EOF
# 公众号数据复盘报告

**周期**: $PERIOD  
**生成时间**: $(date '+%Y-%m-%d %H:%M:%S')

---

## 一、基础数据

| 指标 | 数值 |
|------|------|
| 文章总数 | $ARTICLE_COUNT |
| 发布周期 | $PERIOD |

## 二、选题分析

### 选题类型分布
（需手动补充阅读量数据后分析）

### 爆款文章特征
- 最佳选题方向: （待补充）
- 最佳发布时间: （待补充）
- 最佳文章长度: （待补充）

## 三、配图效果

- 有配图文章数: （待补充）
- 无配图文章数: （待补充）
- 配图对阅读量的影响: （待补充）

## 四、优化建议

### 给情报员
- 关注选题方向: 西藏/藏族历史、人物传记
- 时效性把握: 提前3-5天准备节日/纪念日选题

### 给主笔
- 标题优化: 使用悬念+数字结构
- 内容结构: 导语→背景→正文→金句→结尾
- 字数控制: 2000-2500字最佳

### 给美编
- 配图数量: 至少5张（封面+4张正文）
- 图片来源: 优先维基百科（公有领域）
- 质量检查: 文件>10KB，尺寸>400px

## 五、待办事项

- [ ] 补充阅读量数据
- [ ] 分析爆款文章特征
- [ ] 优化选题策略
- [ ] 调整配图流程

---

*报告生成: 数据分析师 (main-4)*
EOF

echo "  报告已生成: $REPORT_FILE"

# 输出摘要
echo ""
echo "【4/4】复盘完成"
echo ""
echo "=== 摘要 ==="
echo "文章总数: $ARTICLE_COUNT"
echo "报告文件: $REPORT_FILE"
echo ""
echo "下一步:"
echo "1. 补充阅读量数据到报告"
echo "2. 分析爆款文章特征"
echo "3. 将优化建议反馈给子代理"
