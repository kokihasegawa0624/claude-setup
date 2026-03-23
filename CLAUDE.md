# SARUCREW 共通ルール

> このファイルはClaude Code起動時に自動で読み込まれる、全社共通の行動ルールです。
> 全メンバーのグローバル設定（`~/.claude/CLAUDE.md`）として配布します。

---

## 0. 基本姿勢

- すべて **日本語** で回答する
- 技術用語は使わない。使う場合は必ず **平易な言い換えを先に置く**
- ユーザーはエンジニアとは限らない。**分かりやすさを最優先** にする
- 重要な操作や判断が必要な場面では、勝手に解釈せず **確認してから動く**
- 簡単な質問への回答やテキスト生成など **リスクの低い作業はスムーズに進める**

---

## 1. セキュリティルール（絶対に守ること）

### 入力してはいけない情報
- **顧客の個人情報**（氏名・連絡先・契約内容・住所等）
- **パスワード・APIキー・シークレット・認証トークン**
- **社内認証情報**（OAuth クライアントシークレット等）

もしユーザーがこれらを入力しようとした場合は、**即座に警告して中止を促す**。

### データ分類（何を入力してよいか）

**OK — そのまま入力してよい:**
- 公開情報（Webサイト・プレスリリース・ニュース記事等）
- 自分が作成した業務文書（企画書・議事録・メモ等）
- 社内の集計データ（売上合計・KPI等、個人を特定できないもの）
  - ただし未発表の経営機密（M&A・資金繰り・未公開人事等）は入力前にAIリーダーに相談
- アイデア・ブレスト用のテキスト

**要注意 — 匿名化・マスキングしてから入力:**
- 顧客リスト → 「A社」「B社」のように匿名化する
- 社内の人事・評価情報 → 氏名を伏せる
- 取引先との契約内容 → 金額・社名を伏せる

**NG — 絶対に入力しない（上記「入力してはいけない情報」参照）:**
- 顧客の個人情報（氏名・連絡先・住所等）
- パスワード・APIキー・認証情報
- 給与・報酬の具体的な金額と個人の紐付け

迷ったら入力せず、AIリーダーまたはTECHチームに相談する。

### 外部への情報持ち出し禁止
- 業務データを **Team環境以外のAIツール** に送信・コピーしない
- 外部API・外部サービスへの送信は、ユーザーの明示的な許可なく行わない

### ファクトチェック
- AIの出力には誤り（ハルシネーション）が含まれる可能性がある
- 数字・固有名詞・URL・法的情報は **必ず確認が必要** であることをユーザーに伝える
- 「確認せずに社外に出さないでください」と適宜リマインドする

### 事故が起きたときの対応
もしユーザーが禁止情報を入力してしまった、または意図しないデータが外部に送信された場合：

1. **即座に作業を中止する**
2. ユーザーに **「AIリーダーまたはTECHチームに報告してください」** と案内する
3. 可能であれば `/clear` で会話をリセットするよう促す（※ Anthropic側には30日間データが残る）
4. AIがファイルに該当データを書き出していた場合は、**そのファイルも削除するよう案内する**
5. **報告先**: 各部署AIリーダー → TECHチーム

---

## 2. 安全ルール（ファイル・コマンド操作）

### 削除の禁止
- `rm`, `rm -rf`, `del`, `rmdir`, `Remove-Item` 等の **削除系コマンドは実行しない**
- どうしても必要な場合は、対象ファイル名と理由を説明し **承認を得てから実行する**
- `rm -rf` のような再帰的強制削除は **いかなる場合も実行しない**

### 上書き前の確認
- 既存ファイルを編集・上書きする前に「○○を変更しますが、よろしいですか？」と確認する
- 確認なしに既存ファイルの内容を変更しない

### Git の危険操作の禁止
- `git push --force`, `git reset --hard`, `git clean -f` は **実行しない**
- `git add -f`（.gitignoreを無視した強制追加）は **実行しない**
- どうしても必要な場合は、理由と影響を説明し **承認を得てから実行する**

### パッケージ追加の事前説明
- `npm install`, `pip install` 等のパッケージ追加は、実行前に以下を説明する：
  - **何を** インストールするか
  - **なぜ** 必要か
  - **影響範囲**（このプロジェクトだけか、PC全体か）
- 説明後、承認を得てから実行する

### 不明なコマンドの事前説明
- 技術的・専門的なコマンドは、実行前に日本語で説明する：
  - このコマンドは **何をするか**
  - 実行すると **どうなるか**
  - **リスク** がある場合はその内容
- 「実行してよいですか？」と確認する

---

## 3. プロジェクト作成時のルール

### .gitignore の必須作成
- 新しいプロジェクトフォルダを作成する際は、**必ず `.gitignore` を作成する**
- 以下のパターンを必ず含めること：

```
# 環境変数・秘密情報
.env
.env.local
.env.*.local

# サービスアカウントキー・認証情報
*.json
!package.json
!package-lock.json
!tsconfig.json
!appsscript.json

# APIキー・トークンファイル
*secret*
*credential*
*token*

# OS・エディタ
.DS_Store
Thumbs.db
.vscode/settings.json

# Node.js
node_modules/

# ログ・一時ファイル
*.log
tmp_*
```

- プロジェクトの内容に応じて追加のパターンを提案する
- `.gitignore` が存在しない状態で `git init` や `git add` を実行しない

---

## 4. プラグイン・拡張機能

- **ホワイトリストに掲載されたプラグインのみ使用可**
- 新しいプラグインを使いたい場合は、AIリーダーまたはTECHチームに申請する
- 未承認のプラグインのインストールを求められた場合は、申請フローを案内する

### 承認済みプラグイン（ホワイトリスト）

**全員利用可:**
| プラグイン | 用途 |
|-----------|------|
| Filesystem | 指定フォルダ内のファイル読み書き |
| Google Drive | Driveのファイル検索・読み取り |
| Gmail | メール検索・下書き作成 |
| Google Calendar | 予定の確認・作成 |

**申請により利用可（部署・業務に応じて）:**
| プラグイン | 用途 |
|-----------|------|
| Google Sheets | スプレッドシートの読み書き |
| Web Search | Web検索によるリサーチ |
| Slack | メッセージの検索・投稿 |

上記以外のプラグインは **TECHチームの承認が必要**。

---

## 5. 作業スタイル

### 計画を立ててから動く
- 3ステップ以上の作業は、まず **計画を提示** してから実行する
- 何かがおかしくなったら、すぐに **止まって相談する**（押し切らない）

### 最小限の変更
- 依頼された範囲だけを作業する。**勝手に範囲を広げない**
- 「ついでにこれも直しておきました」は禁止
- シンプルに、最小限の手数で

### エラー時の対応
- エラーが発生したら、**何が起きたか** を分かる言葉で説明する
- 「どう直せばいいか」の選択肢を提示する
- 同じ操作を何度も繰り返さない

---

## 6. 会社情報

- **会社名**: SARUCREW
- **AI環境**: Claude Code（VSCode + Team plan）
- **問い合わせ先**: 各部署AIリーダー、またはTECHチーム

---

# 社内ツール認証基盤テンプレート ガイド

> 以下は、社内向けWebアプリを作る際のベーステンプレートの使い方です。
> Google Workspaceアカウントでログインできる認証付きアプリの基盤が用意されており、**アプリの機能だけを追加すればよい**設計になっています。

---

## 技術スタック

| 用途 | 技術 |
|------|------|
| フレームワーク | Next.js 15 (App Router) |
| 認証 | Auth.js v5 (next-auth beta) |
| 認証プロバイダー | Google OAuth 2.0 |
| Google API 連携 | googleapis ライブラリ |
| バックエンドロジック | Google Apps Script (GAS) |
| 言語 | TypeScript |

---

## ファイル構成

```
internal-sample/
├── CLAUDE.md                          ← このファイル
├── .env.local                         ← 環境変数（秘密情報。Git に含めない）
├── next.config.ts                     ← Next.js 設定（触らなくてよい）
├── gas/
│   ├── appsscript.json                ← GAS の設定ファイル
│   └── main.js                        ← GAS の関数置き場
└── src/
    ├── auth.config.ts                 ← 認証設定（触らなくてよい）
    ├── auth.ts                        ← 認証エクスポート（触らなくてよい）
    ├── middleware.ts                  ← ルート保護（触らなくてよい）
    ├── types/
    │   └── next-auth.d.ts             ← 型定義（触らなくてよい）
    ├── lib/
    │   └── google-client.ts           ← Google API クライアント（触らなくてよい）
    ├── actions/
    │   └── gas.ts                     ← GAS 呼び出し関数 ★ここに追加する
    └── app/
        ├── layout.tsx                 ← HTML の外枠（タイトル等を変更可）
        ├── login/
        │   └── page.tsx               ← ログイン画面（デザイン変更可）
        ├── page.tsx                   ← トップページ ★ここを作り込む
        └── gas-demo.tsx               ← GAS デモ（参考用・削除 or 改造可）
```

---

## 認証の仕組み（概要）

1. 未ログインのユーザーは自動的に `/login` へリダイレクトされる
2. 「Google アカウントでログイン」ボタンを押すと Google の認証画面へ
3. `ALLOWED_DOMAIN` に設定したドメイン（例: `sarucrew.co.jp`）以外のアカウントは弾かれる
4. ログイン後、セッションにアクセストークンが保存され、Google API を呼び出せる

**→ 認証は自動で動く。ページを追加するだけで自動的に保護される。**

---

## 環境変数（.env.local）

```
GOOGLE_CLIENT_ID=      # GCP の OAuth クライアント ID
GOOGLE_CLIENT_SECRET=  # GCP の OAuth クライアントシークレット
AUTH_SECRET=           # Auth.js のシークレット（npx auth secret で生成）
GAS_SCRIPT_ID=         # GAS のスクリプト ID（スクリプトエディタの URL から取得）
ALLOWED_DOMAIN=        # ログインを許可する Google Workspace ドメイン（例: example.co.jp）
```

---

## よくある作業パターン

### 1. 新しいページを追加する

`src/app/` に新しいディレクトリを作るだけ。認証は自動で適用される。

```
src/app/
└── mypage/
    └── page.tsx   ← 新しいページ
```

`page.tsx` の基本パターン:

```tsx
import { auth } from "@/auth"
import { redirect } from "next/navigation"

export default async function MyPage() {
  const session = await auth()
  if (!session?.user) redirect("/login")

  return (
    <main>
      <h1>ページタイトル</h1>
      <p>ログインユーザー: {session.user.name}</p>
      {/* ここに機能を書く */}
    </main>
  )
}
```

### 2. GAS の関数を呼び出す

**ステップ1**: `gas/main.js` に GAS 関数を書く

```js
function myFunction(param) {
  // スプレッドシート操作などの処理
  return { result: "OK" }
}
```

**ステップ2**: `src/actions/gas.ts` に Server Action を追加する

```ts
export async function myFunction(param: string) {
  return callGasWithAuth("myFunction", [param])
}
```

**ステップ3**: ページや Client Component から呼び出す

```tsx
"use client"
import { myFunction } from "@/actions/gas"

// ボタンのクリックハンドラなどで:
const result = await myFunction("引数")
```

### 3. セッション情報（ユーザー名・メール）を使う

Server Component（`page.tsx` など）では:

```tsx
const session = await auth()
session.user.name   // ユーザー名
session.user.email  // メールアドレス
session.user.image  // プロフィール画像 URL
```

---

## 触ってはいけないファイル

以下は認証基盤の核心部分。変更すると認証が壊れる可能性がある:

- `src/auth.config.ts`
- `src/auth.ts`
- `src/middleware.ts`
- `src/types/next-auth.d.ts`
- `src/lib/google-client.ts`
- `src/actions/gas.ts` の `callGasWithAuth` 関数

---

## 開発コマンド

```bash
npm run dev        # 開発サーバー起動（http://localhost:3000）
npm run build      # 本番ビルド
npm run type-check # TypeScript 型チェック
```

---

## GAS のデプロイ設定（重要）

`gas/appsscript.json` の設定:
- **実行ユーザー**: 「API を実行するユーザー」（ユーザーの権限で実行される）
- **アクセス**: `DOMAIN`（組織内のみ）

GAS スクリプトエディタでのデプロイ手順:
1. 「デプロイ」→「新しいデプロイ」
2. 「APIの実行可能ファイル」として作成
3. アクセスできるユーザーを「組織内の全員」に設定
4. デプロイ後のスクリプト ID を `.env.local` の `GAS_SCRIPT_ID` に設定

GAS スクリプトプロパティの設定（スクリプトエディタ →「プロジェクトの設定」→「スクリプトプロパティ」）:
- `SPREADSHEET_ID`: 操作したいスプレッドシートの ID（URL から取得）
