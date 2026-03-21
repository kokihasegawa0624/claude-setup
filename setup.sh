#!/bin/bash
# SARUCREW Claude Code セットアップスクリプト
# 使い方: curl -sL https://raw.githubusercontent.com/kokihasegawa0624/claude-setup/main/setup.sh | bash

set -e

REPO_BASE="https://raw.githubusercontent.com/kokihasegawa0624/claude-setup/main"
CLAUDE_DIR="$HOME/.claude"

echo ""
echo "========================================="
echo "  SARUCREW Claude Code セットアップ"
echo "========================================="
echo ""

# 1. ~/.claude/ フォルダ作成
if [ ! -d "$CLAUDE_DIR" ]; then
  echo "[1/3] ~/.claude/ フォルダを作成中..."
  mkdir -p "$CLAUDE_DIR"
else
  echo "[1/3] ~/.claude/ フォルダは既にあります"
fi

# 2. CLAUDE.md を配置
echo "[2/3] SARUCREW共通ルール（CLAUDE.md）をダウンロード中..."
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  cp "$CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md.bak"
  echo "  → 既存ファイルを CLAUDE.md.bak にバックアップしました"
fi
curl -sL "$REPO_BASE/CLAUDE.md" -o "$CLAUDE_DIR/CLAUDE.md"
echo "  → ~/.claude/CLAUDE.md に配置しました"

# 3. settings.json を配置
echo "[3/3] SARUCREW安全設定（settings.json）をダウンロード中..."
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.bak"
  echo "  → 既存ファイルを settings.json.bak にバックアップしました"
fi
curl -sL "$REPO_BASE/settings.json" -o "$CLAUDE_DIR/settings.json"
echo "  → ~/.claude/settings.json に配置しました"

echo ""
echo "========================================="
echo "  セットアップ完了！"
echo "========================================="
echo ""
echo "  次のステップ："
echo "  1. VSCodeを開く"
echo "  2. ターミナルを開く（Ctrl + \`）"
echo "  3. 「claude」と打ってEnter"
echo "  4. 日本語でチャット開始！"
echo ""
