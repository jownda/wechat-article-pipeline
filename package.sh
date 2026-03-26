#!/bin/bash
# 打包 skill 用于分发

set -e

VERSION="1.0.0"
PACKAGE_NAME="wechat-article-pipeline-v${VERSION}.tar.gz"

echo "=== 打包公众号文章流水线 ==="
echo "版本: $VERSION"
echo ""

# 清理旧文件
rm -f "$PACKAGE_NAME"

# 打包（排除不需要的文件）
tar -czf "$PACKAGE_NAME" \
    --exclude='.git' \
    --exclude='*.tar.gz' \
    --exclude='package.sh' \
    --exclude='test' \
    .

echo "✅ 打包完成: $PACKAGE_NAME"
echo ""
echo "分发方式:"
echo "1. 上传到 GitHub Releases"
echo "2. 分享给其他用户"
echo "3. 上传到 OpenClawMP（如果支持）"
echo ""
echo "安装命令:"
echo "  tar -xzf $PACKAGE_NAME"
echo "  cd wechat-article-pipeline"
echo "  ./install.sh"
