#!/bin/bash
# 公众号文章流水线主脚本

set -e

WORK_DIR="${1:-content-library/article-$(date +%Y%m%d)}"
TASK="${2:-all}"

mkdir -p "$WORK_DIR/images"

echo "=== 公众号文章流水线 ==="
echo "工作目录: $WORK_DIR"
echo "任务: $TASK"
echo ""

case $TASK in
  research|all)
    echo "【1/4】选题调研..."
    # 派出情报员
    echo "请手动执行:"
    echo "  sessions_spawn(agentId='main-5', task='选题调研', ...)"
    echo "  输出: $WORK_DIR/research.md"
    echo ""
    ;;
  
  write|all)
    echo "【2/4】文章撰写..."
    echo "请手动执行:"
    echo "  sessions_spawn(agentId='main-3', task='撰写文章', ...)"
    echo "  输入: $WORK_DIR/research.md"
    echo "  输出: $WORK_DIR/article.md"
    echo ""
    ;;
  
  images|all)
    echo "【3/4】配图准备..."
    echo "请手动执行:"
    echo "  sessions_spawn(agentId='main-2', task='配图准备', ...)"
    echo "  输出: $WORK_DIR/images/"
    echo ""
    ;;
  
  upload|all)
    echo "【4/4】排版上传..."
    
    # 检查必要文件
    if [ ! -f "$WORK_DIR/article.md" ]; then
      echo "错误: 找不到 article.md"
      exit 1
    fi
    
    # 生成HTML
    echo "生成HTML..."
    python3 "$(dirname "$0")/md_to_html.py" "$WORK_DIR/article.md" "$WORK_DIR/article.html"
    
    # 上传
    echo "上传中..."
    expect "$(dirname "$0")/upload.exp" "$WORK_DIR"
    
    echo "✅ 上传完成"
    ;;
  
  *)
    echo "未知任务: $TASK"
    echo "可用任务: research, write, images, upload, all"
    exit 1
    ;;
esac

echo ""
echo "=== 流水线执行完成 ==="
