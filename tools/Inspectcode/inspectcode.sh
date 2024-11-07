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

# 分析、複数のcsprojを一緒に実行したい
# output分析結果出力先は、実行ファイルと同じフォルダ
jb inspectcode ./client/client.sln \
  --include="**/TestBehaviourScript.cs;**/TestScript.cs" \
  --output=./tools/Inspectcode/inspectcode.json

# ログ確認用、本番は要らないと思う
echo "Press Enter to exit..."
read