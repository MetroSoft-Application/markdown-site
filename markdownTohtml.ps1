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

# フレーム用CSSもコピー
if (Test-Path "$InputFolder\frame-style.css") {
    Copy-Item "$InputFolder\frame-style.css" -Destination "$OutputFolder" -Force
}

# Markdownファイルの変換
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

# フレーム付きindex.htmlの生成
$templatePath = Join-Path $InputFolder "index-template.html"
if (-not (Test-Path $templatePath)) {
    Write-Error "index-template.html がinputフォルダに見つかりません。"
    exit 1
}

$htmlFiles = Get-ChildItem "$OutputFolder\*.html" | Where-Object { $_.BaseName -ne "index" }
$navigationLinks = ""
foreach ($file in $htmlFiles) {
    # 番号プレフィックス（01-, 02-など）を除去
    $displayName = $file.BaseName -replace '^\d+-', ''
    $displayName = $displayName -replace '-', ' '
    $displayName = (Get-Culture).TextInfo.ToTitleCase($displayName)
    $navigationLinks += "        <li><a href=`"$($file.Name)`" target=`"content`">$displayName</a></li>`n"
}

# テンプレートファイルを読み込み
$indexTemplate = Get-Content $templatePath -Encoding UTF8 -Raw

# プレースホルダーを置換
$indexHtml = $indexTemplate -replace '\{\{NAVIGATION_LINKS\}\}', $navigationLinks
$indexHtml = $indexHtml -replace '\{\{DEFAULT_PAGE\}\}', '01-README.html'

$indexPath = Join-Path $OutputFolder "index.html"
[System.IO.File]::WriteAllText($indexPath, $indexHtml, (New-Object System.Text.UTF8Encoding $false))
