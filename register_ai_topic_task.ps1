param(
  [string]$TaskName = "AI-TopicLibrary-7AM",
  [string]$ProjectRoot = "D:\study\aiyishou_note"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$scriptPath = Join-Path $ProjectRoot "generate_ai_topic_library.ps1"
if (-not (Test-Path -LiteralPath $scriptPath)) {
  throw "Script not found: $scriptPath"
}

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`" -Days 1"
$trigger = New-ScheduledTaskTrigger -Daily -At 7:00AM
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -StartWhenAvailable

Register-ScheduledTask -TaskName $TaskName -Action $action -Trigger $trigger -Settings $settings -Description "Generate AI topic library daily at 7:00 AM" -Force | Out-Null

Write-Host "Scheduled task registered: $TaskName"
