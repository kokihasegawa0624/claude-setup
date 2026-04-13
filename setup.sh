#!/bin/bash
# SARUCREW Claude Code セットアップスクリプト
#
# 通常実行（非エンジニア版）:
#   curl -sL https://raw.githubusercontent.com/kokihasegawa0624/claude-setup/main/setup.sh | bash
#
# エンジニア版:
#   curl -sL https://raw.githubusercontent.com/kokihasegawa0624/claude-setup/main/setup.sh | bash -s -- -e

set -e

REPO_BASE="https://raw.githubusercontent.com/kokihasegawa0624/claude-setup/main"
CLAUDE_DIR="$HOME/.claude"

# エンジニアモード判定
ENGINEER_MODE=false
while getopts "e" opt; do
  case $opt in
    e) ENGINEER_MODE=true ;;
  esac
done

if [ "$ENGINEER_MODE" = true ]; then
  SETTINGS_FILE="settings.json"
  MODE_LABEL="エンジニア"
else
  SETTINGS_FILE="settings_non_engineer.json"
  MODE_LABEL="スタンダード"
fi

echo ""
echo "========================================="
echo "  SARUCREW Claude Code セットアップ"
echo "  モード: ${MODE_LABEL}"
echo "========================================="
echo ""

# 1. ~/.claude/ フォルダ作成
if [ ! -d "$CLAUDE_DIR" ]; then
  echo "[1/4] ~/.claude/ フォルダを作成中..."
  mkdir -p "$CLAUDE_DIR"
else
  echo "[1/4] ~/.claude/ フォルダは既にあります"
fi

# 2. CLAUDE.md を配置
echo "[2/4] SARUCREW共通ルール（CLAUDE.md）をダウンロード中..."
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  cp "$CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md.bak"
  echo "  → 既存ファイルを CLAUDE.md.bak にバックアップしました"
fi
curl -sL "$REPO_BASE/CLAUDE.md" -o "$CLAUDE_DIR/CLAUDE.md"
echo "  → ~/.claude/CLAUDE.md に配置しました"

# 3. settings.json を配置（モードに応じて切替）
echo "[3/4] SARUCREW安全設定（settings.json / ${MODE_LABEL}）をダウンロード中..."
if [ -f "$CLAUDE_DIR/settings.json" ]; then
  cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.bak"
  echo "  → 既存ファイルを settings.json.bak にバックアップしました"
fi
curl -sL "$REPO_BASE/${SETTINGS_FILE}" -o "$CLAUDE_DIR/settings.json"
echo "  → ~/.claude/settings.json に配置しました（${MODE_LABEL}モード）"

# 4. グローバル .gitignore を配置
echo "[4/4] グローバル .gitignore を設定中..."
if [ -f "$HOME/.gitignore_global" ]; then
  cp "$HOME/.gitignore_global" "$HOME/.gitignore_global.bak"
  echo "  → 既存ファイルを .gitignore_global.bak にバックアップしました"
fi
curl -sL "$REPO_BASE/.gitignore_global" -o "$HOME/.gitignore_global"
git config --global core.excludesFile "$HOME/.gitignore_global"
echo "  → ~/.gitignore_global に配置し、Gitに適用しました"

echo ""
echo "========================================="
echo "  セットアップ完了！（${MODE_LABEL}モード）"
echo "========================================="
echo ""
echo "  次のステップ："
echo "  1. VSCodeを開く"
echo "  2. ターミナルを開く（Ctrl + \`）"
echo "  3. 「claude」と打ってEnter"
echo "  4. 日本語でチャット開始！"
echo ""
