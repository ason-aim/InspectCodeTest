#!/bin/bash

# ドキュメント：https://github.com/Aiminginc2/fan/issues/7769

# fanフォルダに移動
cd ../..

# インストールチェック
if jb inspectcode --version &> /dev/null; then
    echo "ReSharper InspectCode 既にインストール済み"
else
    echo "ReSharper InspectCode インストール..."
    dotnet tool install -g JetBrains.ReSharper.GlobalTools
fi

# 外部からの解析するファイルを指定する引数、このまま実行するとデフォルトのAssets下全ての.csが解析対象になる
include_files=${1:-"Assets/**.cs"}
# 外部指定の場合は\nで分割してください。例："Assets/Test/TestBehaviourScript.cs\nAssets/Test/TestScript.cs\n"
include_files=$(printf "%b" "$include_files" | tr '\n' ';')

# 分析
# settingsはRiderのプロジェクト設定と同じものを参照している
# severityは提案からエラーまでに設定したが、実際の状況によって変更
# output分析結果出力先は、実行ファイルと同じフォルダ
# format=Textが一番簡潔なフォーマット、他は[Sarif, Html, Xml]など細かい出力が設定出来る
jb inspectcode ./client/client.sln \
  --build \
  --swea \
  --eXtensions=JetBrains.Unity \
  --include="$include_files" \
  --settings="./client/client.sln.DotSettings" \
  --severity=SUGGESTION \
  --format=Text \
  --output=./tools/Inspectcode/client-inspectcode.txt

# TODO : ログ確認用、本番は要らないと思う
echo "Press Enter to exit..."
read

# dllの指定、複数可
#  --project=TestAssembly \
#  --project=Test2Assembly \
#  --project=Test3Assembly \