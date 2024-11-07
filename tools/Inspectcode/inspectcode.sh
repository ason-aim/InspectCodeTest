#!/bin/bash

# fanフォルダに移動
cd ../..

# インストールチェック
if jb inspectcode --version &> /dev/null; then
    echo "ReSharper InspectCode 既にインストール済み"
else
    echo "ReSharper InspectCode インストール..."
    dotnet tool install -g JetBrains.ReSharper.GlobalTools --arch arm64
fi

# 分析
# output分析結果出力先は、実行ファイルと同じフォルダ
# TODO : severityは、実際のfanプロジェクトで検証してから決める
jb inspectcode ./client/client.sln \
  --build \
  --eXtensions=JetBrains.Unity \
  --include="**/TestBehaviourScript.cs;**/TestScript.cs" \
  --settings="./client/client.sln.DotSettings" \
  --severity=INFO \
  --format=Text \
  --output=./tools/Inspectcode/inspectcode.txt

# TODO : ログ確認用、本番は要らないと思う
echo "Press Enter to exit..."
read