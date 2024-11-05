#!/bin/bash
# fanフォルダに移動
cd ../..
# インストール、後から消したい
dotnet tool install -g JetBrains.ReSharper.GlobalTools --arch arm64
# 分析、複数のcsprojを一緒に実行したい
# 分析結果出力先は、実行ファイルと同じフォルダ
jb inspectcode ./client/TestAssembly.csproj --output=./tools/Inspectcode/inspectcode.json
# ログ確認用、本番は要らないと思う
echo "Press Enter to exit..."
read