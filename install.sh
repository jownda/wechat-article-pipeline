#!/bin/bash
# 公众号文章流水线 - 本地安装脚本

set -e

SKILL_NAME="wechat-article-pipeline"
INSTALL_DIR="$HOME/.stepclaw/skills/$SKILL_NAME"

echo "=== 公众号文章流水线安装 ==="
echo ""

# 检查目录
if [ -d "$INSTALL_DIR" ]; then
    echo "⚠️  $SKILL_NAME 已安装"
    read -p "是否覆盖安装? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "取消安装"
        exit 0
    fi
    rm -rf "$INSTALL_DIR"
fi

# 创建目录
mkdir -p "$INSTALL_DIR"

# 复制文件
cp -r . "$INSTALL_DIR/"

# 设置权限
chmod +x "$INSTALL_DIR/pipeline.sh"
chmod +x "$INSTALL_DIR/md_to_html.py"
chmod +x "$INSTALL_DIR/upload.exp"

# 创建快捷命令
BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

cat > "$BIN_DIR/wechat-pipeline" << 'EOF'
#!/bin/bash
exec "$HOME/.stepclaw/skills/wechat-article-pipeline/pipeline.sh" "$@"
EOF

chmod +x "$BIN_DIR/wechat-pipeline"

echo "✅ 安装完成！"
echo ""
echo "使用方法:"
echo "  wechat-pipeline <工作目录> [任务]"
echo ""
echo "示例:"
echo "  wechat-pipeline content-library/article-20250326 all"
echo ""
echo "任务选项:"
echo "  research - 选题调研"
echo "  write    - 撰写文章"
echo "  images   - 准备配图"
echo "  upload   - 排版上传"
echo "  all      - 执行全部（默认）"
echo ""
echo "配置文件:"
echo "  $INSTALL_DIR/config.json"
echo ""

# 检查 PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    echo "⚠️  请将 $BIN_DIR 添加到 PATH:"
    echo "  echo 'export PATH=\"\$HOME/.local/bin:\$PATH\"' >> ~/.zshrc"
    echo "  source ~/.zshrc"
    echo ""
fi

echo "安装位置: $INSTALL_DIR"
