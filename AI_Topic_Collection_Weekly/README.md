---
type: automation-guide
tags: [automation, task-scheduler, AI-collection]
---

# 🚀 AI 题材库收集器 - 自动化配置指南

> **每天早上 7:00 自动生成新的 AI 题材库笔记**

## 📋 系统要求

- **OS**: Windows 10/11
- **工具**: Windows Task Scheduler (内置)
- **Obsidian**: 已安装并配置 (可选)

---

## ⚙️ 配置步骤

### 方案一：PowerShell 脚本（推荐 ⭐）

#### 第 1 步：确认脚本位置
脚本已保存在：`AI_Topic_Collection_Weekly\auto-generate.ps1`

#### 第 2 步：打开 Task Scheduler
按 `Win + R`，输入：
```
taskschd.msc
```
或在**开始菜单**搜索 **Task Scheduler**

#### 第 3 步：创建新任务
1. 点击右侧 **"Create Basic Task..."** (或 **"Create Task..."** 获更多选项)
2. 填写信息：
   - **名称**: `AI Theme Collection Daily`
   - **描述**: `Auto generate AI topic collection note every day at 7:00 AM`

#### 第 4 步：设置触发器 (Trigger)
1. 点击 **"Triggers"** 标签
2. 点击 **"New..."**
3. 选择 **"Daily"**
4. 设置开始时间：
   - **Begin the task**: 选择今天的日期
   - **Recur every**: `1` 天
   - **Start**: `07:00:00` (早上7点)
5. 点击 **OK**

#### 第 5 步：设置操作 (Action)
1. 点击 **"Actions"** 标签
2. 点击 **"New..."**
3. 选择 **"Start a program"**
4. 填写：
   - **Program/script**: `powershell.exe`
   - **Add arguments**:
   ```
   -NoProfile -ExecutionPolicy Bypass -File "AI_Topic_Collection_Weekly\auto-generate.ps1"
   ```
   - **Start in**:
   ```
   你的 Obsidian vault 目录路径
   ```
   例如: `C:\Users\YourName\Documents\ObsidianVault`
5. 点击 **OK**

> **💡 提示**: 脚本现在使用相对路径，会自动找到自己所在的目录，更加安全和可移植！

#### 第 6 步：设置条件 (Conditions)
1. 点击 **"Conditions"** 标签
2. 可选配置：
   - ☐ 勾选 "Wake the computer to run this task" (如需在休眠时唤醒)
   - ☐ 勾选 "Run only when user is logged on" (如需用户登录)

#### 第 7 步：设置设置 (Settings)
1. 点击 **"Settings"** 标签
2. 推荐配置：
   - ☐ "Allow task to be run on demand" ✓
   - ☐ "Run task as soon as possible after a scheduled start is missed" ✓
   - ☐ "If the task fails, restart every" - 可设置为 5 分钟重试
   - ☐ "Stop the task if it runs longer than" - 设置为 30 分钟

#### 第 8 步：创建任务
点击 **"OK"** 完成创建

---

### 方案二：Bash 脚本（适用于 WSL/Git Bash）

如果你使用 Git Bash 或 WSL，可以用 bash 版本：

#### 修改脚本路径
编辑 `auto-generate.sh`，改为：
```bash
VAULT_PATH="/mnt/c/Users/YourName/Documents/Vault"  # WSL 路径
# 或
VAULT_PATH="C:/Users/YourName/Documents/Vault"      # Git Bash 路径
```

#### 在 Task Scheduler 中配置
- **Program/script**: `bash.exe` (或 `/usr/bin/bash`)
- **Add arguments**:
```
-c "AI_Topic_Collection_Weekly/auto-generate.sh"
```

---

## 🧪 测试任务

### 方法 1：立即运行
1. 打开 Task Scheduler
2. 找到任务 **"AI Theme Collection Daily"**
3. 右键 → **"Run"**
4. 检查 `AI_Topic_Collection_Weekly` 目录，应该生成一个新的 markdown 文件

### 方法 2：查看任务历史
1. 右键任务 → **"Properties"**
2. 点击 **"History"** 标签查看运行日志

### 方法 3：检查输出
查看 vault 中是否生成了新的笔记：
```
AI_Topic_Collection_Weekly/YYYY-MM-DD-AI题材库.md
```

---

## 📝 每日工作流

### ✨ 早上 7:00
自动生成当天的题材库笔记 → 在 Obsidian 中打开

### 🎯 工作时间
- 收集 AI 相关热点话题
- 记录技术突破和产业动向
- 整理内容创意角度

### 📊 完成检查
- [ ] 填充至少 3 个热门话题
- [ ] 记录 1 个技术突破
- [ ] 列出产业动向
- [ ] 筛选 3 个最值得的选题

---

## 🔧 故障排除

### ❌ 任务未运行
**检查清单：**
1. Task Scheduler 已启用？
   - 右键 "AI Theme Collection Daily" → "Properties" → 确保 "Enabled" 勾选
2. PowerShell 执行策略？
   ```powershell
   Get-ExecutionPolicy
   # 如果不是 Bypass 或 RemoteSigned，运行：
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
   ```
3. 文件路径是否正确？
   - 确认脚本存在：`你的Vault目录\AI_Topic_Collection_Weekly\auto-generate.ps1`
4. Vault 目录权限？
   - 右键 → 属性 → 安全 → 确保当前用户有写入权限

### ❌ 任务运行但无文件生成
1. 检查 vault 目录路径是否正确
2. 查看 Task Scheduler 历史日志（右键任务 → 属性 → 历史）
3. 手动运行脚本测试：
   ```powershell
   .\AI_Topic_Collection_Weekly\auto-generate.ps1
   ```

### ❌ 编码问题（文件乱码）
确保 PowerShell 脚本中使用了 UTF-8 编码：
```powershell
Out-File -FilePath $FILENAME -Encoding UTF8 -Force
```

---

## 📚 相关文件

| 文件 | 用途 |
|-----|------|
| `template.md` | 笔记模板（参考用） |
| `auto-generate.ps1` | PowerShell 自动脚本 |
| `auto-generate.sh` | Bash 自动脚本 |
| `YYYY-MM-DD-AI题材库.md` | 每日生成的笔记 |

---

## 💡 进阶配置

### 启用详细日志
修改 PowerShell 脚本，添加日志功能：

```powershell
# 日志文件路径
$LOG_FILE = "$COLLECTION_DIR\logs.txt"

# 在文件开头添加：
"[$TIMESTAMP] 开始生成笔记..." | Add-Content -Path $LOG_FILE

# 在创建后添加：
"[$TIMESTAMP] ✅ 成功创建" | Add-Content -Path $LOG_FILE
```

### 邮件通知
在创建成功后发送邮件通知（需配置邮件服务器）：

```powershell
$MailParams = @{
    From = "你的邮箱"
    To = "通知邮箱"
    Subject = "✅ 今日AI题材库已生成"
    Body = "笔记位置: $FILENAME"
    SmtpServer = "smtp.gmail.com"
    Port = 587
}
Send-MailMessage @MailParams
```

---

## 🎯 常见问题

**Q: 假期能暂停吗？**
A: 右键任务 → "Disable"，需要时再启用

**Q: 能修改执行时间吗？**
A: 右键任务 → "Properties" → "Triggers" → 修改时间

**Q: 能只在工作日运行吗？**
A: 在 Task Scheduler 中编辑触发器，选择 "On a schedule" 并配置工作日

**Q: 生成失败怎么办？**
A: 检查 Task Scheduler 的历史日志，查看错误信息

---

## 🌟 下一步

- [ ] 配置 Task Scheduler 任务
- [ ] 测试自动生成功能
- [ ] 在 Obsidian 中创建每日链接视图
- [ ] 配置选题评分系统

---

*最后更新: 2026-02-10*
*由 Claude AI 题材库收集器系统生成*
