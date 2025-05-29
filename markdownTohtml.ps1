param (
    [string]$InputFolder,
    [string]$OutputFolder
)

if (-not (Test-Path $InputFolder)) {
    Write-Error "入力フォルダが存在しません: $InputFolder"
    exit 1
}

if (-not (Test-Path "$InputFolder\style.css")) {
    Write-Error "style.css が入力フォルダに見つかりません。"
    exit 1
}

New-Item -ItemType Directory -Force -Path $OutputFolder | Out-Null
Copy-Item "$InputFolder\style.css" -Destination "$OutputFolder" -Force

Get-ChildItem "$InputFolder\*.md" | ForEach-Object {
    $mdPath = $_.FullName
    $baseName = $_.BaseName
    $htmlFile = Join-Path $OutputFolder "$baseName.html"

    # UTF-8（BOMなし）で読み取り
    $content = Get-Content $mdPath -Encoding UTF8 -Raw

    # .md → .html のリンク置換
    $convertedContent = $content -replace '\(([^)]+)\.md\)', '($1.html)'

    # 一時ファイル保存（BOMなし）
    $tempPath = [System.IO.Path]::GetTempFileName()
    [System.IO.File]::WriteAllText($tempPath, $convertedContent, (New-Object System.Text.UTF8Encoding $false))

    # pandoc 実行（警告回避済）
    pandoc $tempPath -f markdown -o $htmlFile --css="style.css" --standalone --metadata title="$baseName"

    Remove-Item $tempPath
}
