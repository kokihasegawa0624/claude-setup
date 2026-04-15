# Google Drive MCP セットアップガイド

Claude CodeからGoogle Drive / Docs / Sheets / Slides を操作できるようにします。

> **注意**: このツールはAnthropic公式ではなくコミュニティ製（MITライセンス）です。
> 公式のDrive MCPが修正され次第移行予定です。

---

## 前提条件

- Claude Codeがインストール済み
- Node.js がインストール済み
- Google Workspaceアカウント（@sarucrew.co.jp）

---

## セットアップ手順

### Step 1: Google Cloud ConsoleでAPIを有効化

以下のURLにアクセスして、それぞれ「有効にする」をクリック:

- https://console.cloud.google.com/apis/library/drive.googleapis.com
- https://console.cloud.google.com/apis/library/docs.googleapis.com
- https://console.cloud.google.com/apis/library/sheets.googleapis.com
- https://console.cloud.google.com/apis/library/slides.googleapis.com

### Step 2: OAuth認証情報を作成

1. https://console.cloud.google.com/apis/credentials にアクセス
2. 「認証情報を作成」→「OAuth クライアントID」
3. アプリケーションの種類: **デスクトップアプリ**
4. 名前: 任意（例: Claude Code Drive）
5. 作成後「JSONをダウンロード」

### Step 3: 認証ファイルを配置

ダウンロードしたJSONファイルを以下の場所に配置:

```bash
# フォルダ作成
mkdir -p ~/.config/google-drive-mcp

# ダウンロードしたファイルをコピー（ファイル名を変更）
cp ~/Downloads/client_secret_XXXXX.json ~/.config/google-drive-mcp/gcp-oauth.keys.json
```

### Step 4: パッケージをインストール

```bash
npm install -g @piotr-agier/google-drive-mcp
```

### Step 5: Claude Codeに追加

```bash
claude mcp add google-drive -s user -- google-drive-mcp
```

### Step 6: Claude Codeを再起動

```bash
claude
```

初回利用時にブラウザでGoogleの認証画面が開きます。「許可」を押してください。

---

## 使えるようになること

| 機能 | 例 |
|---|---|
| Drive | ファイル検索、フォルダ作成、ファイル移動・コピー・共有 |
| Docs | ドキュメント作成・読み込み・編集 |
| Sheets | スプレッドシート作成・読み書き |
| Slides | スライド作成・編集 |

---

## 動作確認

Claude Codeで以下を試してください:

```
Google Driveでファイルを検索して
```

ファイル一覧が返ってくればOKです。

---

## 注意事項

- `npm update -g @piotr-agier/google-drive-mcp` は実行しないでください
  - アップデートはTECHチームが検証してから案内します
- 困ったらTECHチーム（長谷川）に相談してください
