# Multi-Agent CLI Tools

List of AI CLI agents: devin, agent (cursor cli), kiro-cli, kilo, antigravity (agy), codex cli, Github Copilot CLI

## Devin

**Platforms:** macOS, Linux, WSL

```bash
curl -fsSL https://cli.devin.ai/install.sh | bash
```

**Windows (PowerShell):**

```powershell
irm https://static.devin.ai/cli/setup.ps1 | iex
```

## Antigravity

**macOS/Linux:**

```bash
curl -fsSL https://antigravity.google/cli/install.sh | bash
```

**Windows PowerShell:**

```powershell
irm https://antigravity.google/cli/install.ps1 | iex
```

**Windows CMD:**

```cmd
curl -fsSL https://antigravity.google/cli/install.cmd -o install.cmd && install.cmd && del install.cmd
```

## Cursor Agent CLI

**Command:** `agent`

**Universal:**

```bash
curl https://cursor.com/install -fsS | bash
```

## Kiro CLI

**Command:** `kiro-cli`

**Universal:**

```bash
curl -fsSL https://cli.kiro.dev/install | bash
```

## Kilo CLI

**Command:** `Kilo`

**Universal:**

```bash
curl -fsSL https://kilo.ai/cli/install | bash
```

## Codex CLI

**Command:** `Codex`

**macOS/Linux:**

```bash
curl -fsSL https://chatgpt.com/codex/install.sh | sh
```

**Windows:**

```powershell
powershell -ExecutionPolicy ByPass -c "irm https://chatgpt.com/codex/install.ps1 | iex"
```

**npm:**

```bash
npm install -g @openai/codex
```

## GitHub Copilot CLI

**Command:** `Copilot`

**macOS/Linux:**

```bash
curl -fsSL https://gh.io/copilot-install | bash
```

**Homebrew:**

```bash
brew install copilot-cli
brew install copilot-cli@prerelease
```

**Windows:**

```powershell
winget install GitHub.Copilot
winget install GitHub.Copilot.Prerelease
```

**npm:**

```bash
npm install -g @github/copilot
npm install -g @github/copilot@prerelease
```
