param(
  [int]$Days = 1,
  [string]$OutputDir = "D:\study\aiyishou_note\ai_topic_library"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if ($Days -lt 1) {
  throw "Days must be >= 1"
}

if (-not (Test-Path -LiteralPath $OutputDir)) {
  New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

$today = Get-Date

for ($i = 0; $i -lt $Days; $i++) {
  $date = $today.AddDays($i).ToString('yyyy-MM-dd')
  $fileName = "${date}-AI题材库.md"
  $filePath = Join-Path $OutputDir $fileName

  if (Test-Path -LiteralPath $filePath) {
    Write-Host "Skip existing: $filePath"
    continue
  }

  $content = @"
# AI题材库 - $date

## 今日方向（可选 3-5 个）
- Agent 工作流自动化
- 多模态（文生图 / 图生视频 / 语音）
- AI + 行业（教育/医疗/法律/电商）
- 开源模型与部署优化
- AI 产品拆解与商业化

## 选题池（先粗收集）
- 标题：
  - 来源：
  - 核心观点：
  - 可延展角度：
- 标题：
  - 来源：
  - 核心观点：
  - 可延展角度：
- 标题：
  - 来源：
  - 核心观点：
  - 可延展角度：

## 爆款判断（打分）
- 关键词热度（1-5）：
- 情绪张力（1-5）：
- 争议性（1-5）：
- 落地价值（1-5）：
- 总分：

## 输出计划
- 短视频脚本：
- 图文笔记：
- 长文深度稿：
- 发布时间建议：

## 待验证信息
- 

## 明日跟进
- 
"@

  Set-Content -LiteralPath $filePath -Value $content -Encoding UTF8
  Write-Host "Created: $filePath"
}
