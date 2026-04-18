#!/usr/bin/env bash
set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

echo ""
echo -e "${PURPLE}${BOLD}  Claude Stack — Setup Wizard${NC}"
echo -e "${PURPLE}  The Unified AI Development Workflow${NC}"
echo ""

# Detect what's installed
check_tool() {
    if command -v "$1" &>/dev/null; then
        echo -e "  ${GREEN}✓${NC} $2"
        return 0
    else
        echo -e "  ${RED}✗${NC} $2 ${YELLOW}(not found)${NC}"
        return 1
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo -e "  ${GREEN}✓${NC} $2"
        return 0
    else
        echo -e "  ${RED}✗${NC} $2 ${YELLOW}(not found)${NC}"
        return 1
    fi
}

echo -e "${BOLD}Checking installed tools...${NC}"
echo ""

CLAUDE_OK=false
GSD_OK=false
NODE_OK=false

check_tool "claude" "Claude Code" && CLAUDE_OK=true
check_tool "node" "Node.js" && NODE_OK=true
check_tool "npx" "npx"
check_tool "git" "git"
check_tool "gh" "GitHub CLI"
check_tool "python3" "Python 3"

# Check for GSD
if [ -d "$HOME/.claude/skills" ] && find "$HOME/.claude/skills" -name "*.md" -path "*gsd*" 2>/dev/null | grep -q .; then
    echo -e "  ${GREEN}✓${NC} GSD"
    GSD_OK=true
elif [ -d ".planning" ]; then
    echo -e "  ${GREEN}✓${NC} GSD (project initialized)"
    GSD_OK=true
else
    echo -e "  ${RED}✗${NC} GSD ${YELLOW}(not detected)${NC}"
fi

# Check for SuperClaude
if [ -d "$HOME/.claude/skills" ] && find "$HOME/.claude/skills" -name "*.md" -path "*sc*" 2>/dev/null | grep -q .; then
    echo -e "  ${GREEN}✓${NC} SuperClaude"
else
    echo -e "  ${RED}✗${NC} SuperClaude ${YELLOW}(not detected)${NC}"
fi

# Check for MCP config
if [ -f ".mcp.json" ]; then
    echo -e "  ${GREEN}✓${NC} .mcp.json"
    if grep -q "context7" .mcp.json 2>/dev/null; then
        echo -e "  ${GREEN}✓${NC} Context7 MCP (configured)"
    else
        echo -e "  ${RED}✗${NC} Context7 MCP ${YELLOW}(not in .mcp.json)${NC}"
    fi
else
    echo -e "  ${RED}✗${NC} .mcp.json ${YELLOW}(not found)${NC}"
fi

# Check for settings
if [ -f ".claude/settings.json" ]; then
    echo -e "  ${GREEN}✓${NC} .claude/settings.json"
else
    echo -e "  ${RED}✗${NC} .claude/settings.json ${YELLOW}(not found)${NC}"
fi

# Check for CLAUDE.md
if [ -f "CLAUDE.md" ]; then
    echo -e "  ${GREEN}✓${NC} CLAUDE.md"
else
    echo -e "  ${RED}✗${NC} CLAUDE.md ${YELLOW}(not found)${NC}"
fi

echo ""

# Choose profile
echo -e "${BOLD}Choose your stack profile:${NC}"
echo ""
echo -e "  ${GREEN}1)${NC} Minimal    — Claude Code + GSD + Context7 (3 tools)"
echo -e "  ${BLUE}2)${NC} Standard   — + SuperClaude + Serena + Seq. Thinking (6 tools)"
echo -e "  ${PURPLE}3)${NC} Full       — + Mysti + Playwright + Superpowers (10+ tools)"
echo -e "  ${CYAN}4)${NC} Config Only — Just copy config files, I'll install tools myself"
echo ""
read -p "  Enter choice [1-4]: " PROFILE

case $PROFILE in
    1) PROFILE_NAME="minimal" ;;
    2) PROFILE_NAME="standard" ;;
    3) PROFILE_NAME="full" ;;
    4) PROFILE_NAME="config" ;;
    *) echo -e "${RED}Invalid choice${NC}"; exit 1 ;;
esac

echo ""
echo -e "${BOLD}Setting up ${PROFILE_NAME} profile...${NC}"
echo ""

# Determine script directory (works with curl pipe and local execution)
if [ -d "examples" ]; then
    SCRIPT_DIR="."
elif [ -d "claude-stack/examples" ]; then
    SCRIPT_DIR="claude-stack"
else
    SCRIPT_DIR=""
fi

# Create .claude directory
mkdir -p .claude

# Copy settings.json if not exists
if [ ! -f ".claude/settings.json" ]; then
    if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/examples/settings.json" ]; then
        cp "$SCRIPT_DIR/examples/settings.json" .claude/settings.json
        echo -e "  ${GREEN}✓${NC} Created .claude/settings.json (with permission wildcards)"
    else
        cat > .claude/settings.json << 'SETTINGS'
{
  "permissions": {
    "allow": [
      "Bash(npm run *)",
      "Bash(npx *)",
      "Bash(make *)",
      "Bash(pytest *)",
      "Bash(git status)",
      "Bash(git diff *)",
      "Bash(git log *)",
      "Read(*)",
      "Glob(*)",
      "Grep(*)"
    ],
    "deny": [
      "Bash(rm -rf *)",
      "Bash(git push --force *)",
      "Bash(git reset --hard *)",
      "Bash(sudo *)"
    ]
  },
  "env": {
    "CLAUDE_AUTOCOMPACT_PCT_OVERRIDE": "80"
  }
}
SETTINGS
        echo -e "  ${GREEN}✓${NC} Created .claude/settings.json"
    fi
else
    echo -e "  ${YELLOW}→${NC} .claude/settings.json already exists (skipped)"
fi

# Create .mcp.json based on profile
if [ ! -f ".mcp.json" ]; then
    case $PROFILE_NAME in
        minimal|config)
            cat > .mcp.json << 'MCP'
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    }
  }
}
MCP
            echo -e "  ${GREEN}✓${NC} Created .mcp.json (Context7)"
            ;;
        standard)
            cat > .mcp.json << 'MCP'
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@anthropic/sequential-thinking-mcp"]
    }
  }
}
MCP
            echo -e "  ${GREEN}✓${NC} Created .mcp.json (Context7 + Sequential Thinking)"
            ;;
        full)
            cat > .mcp.json << 'MCP'
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp"]
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@anthropic/sequential-thinking-mcp"]
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp"]
    }
  }
}
MCP
            echo -e "  ${GREEN}✓${NC} Created .mcp.json (Context7 + Sequential Thinking + Playwright)"
            ;;
    esac
else
    echo -e "  ${YELLOW}→${NC} .mcp.json already exists (skipped)"
fi

# Create .claude/rules/ directory with example rules
if [ ! -d ".claude/rules" ]; then
    mkdir -p .claude/rules
    echo -e "  ${GREEN}✓${NC} Created .claude/rules/ directory"

    if [ -n "$SCRIPT_DIR" ] && [ -d "$SCRIPT_DIR/examples/rules" ]; then
        cp "$SCRIPT_DIR/examples/rules/"*.md .claude/rules/ 2>/dev/null || true
        echo -e "  ${GREEN}✓${NC} Copied example rule files"
    fi
else
    echo -e "  ${YELLOW}→${NC} .claude/rules/ already exists (skipped)"
fi

# Create CLAUDE.md template if not exists
if [ ! -f "CLAUDE.md" ]; then
    if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/examples/claude-md/CLAUDE.md" ]; then
        cp "$SCRIPT_DIR/examples/claude-md/CLAUDE.md" CLAUDE.md
        echo -e "  ${GREEN}✓${NC} Created CLAUDE.md template (customize for your project)"
    else
        cat > CLAUDE.md << 'CLAUDEMD'
# CLAUDE.md

## Project Overview

<!-- Customize this for your project -->

## Quick Commands

```bash
# Add your project's common commands here
```

## Architecture

<!-- Describe your project structure -->

## Critical Conventions

<!-- Add rules Claude should follow -->
CLAUDEMD
        echo -e "  ${GREEN}✓${NC} Created CLAUDE.md template"
    fi
else
    echo -e "  ${YELLOW}→${NC} CLAUDE.md already exists (skipped)"
fi

# Add CLAUDE.local.md to .gitignore
if [ -f ".gitignore" ]; then
    if ! grep -q "CLAUDE.local.md" .gitignore 2>/dev/null; then
        echo "CLAUDE.local.md" >> .gitignore
        echo -e "  ${GREEN}✓${NC} Added CLAUDE.local.md to .gitignore"
    fi
else
    echo "CLAUDE.local.md" > .gitignore
    echo -e "  ${GREEN}✓${NC} Created .gitignore with CLAUDE.local.md"
fi

# Add settings.local.json to .gitignore
if ! grep -q "settings.local.json" .gitignore 2>/dev/null; then
    echo ".claude/settings.local.json" >> .gitignore
    echo -e "  ${GREEN}✓${NC} Added settings.local.json to .gitignore"
fi

echo ""

# Print what to install manually
echo -e "${BOLD}Next steps:${NC}"
echo ""

if [ "$CLAUDE_OK" = false ]; then
    echo -e "  ${YELLOW}1.${NC} Install Claude Code: ${CYAN}npm install -g @anthropic-ai/claude-code${NC}"
fi

if [ "$GSD_OK" = false ]; then
    echo -e "  ${YELLOW}2.${NC} Install GSD: ${CYAN}https://github.com/cyanheads/gsd${NC}"
fi

if [ "$PROFILE_NAME" = "standard" ] || [ "$PROFILE_NAME" = "full" ]; then
    echo -e "  ${YELLOW}3.${NC} Install SuperClaude: ${CYAN}https://github.com/NomenAK/SuperClaude${NC}"
    echo -e "  ${YELLOW}4.${NC} Install Superpowers: ${CYAN}https://github.com/NomenAK/superpowers${NC}"
    echo -e "  ${YELLOW}5.${NC} Configure Serena: ${CYAN}https://github.com/getsurya/serena${NC}"
fi

if [ "$PROFILE_NAME" = "full" ]; then
    echo -e "  ${YELLOW}6.${NC} Install Mysti (VSCode): ${CYAN}ext install DeepMyst.mysti${NC}"
fi

echo ""
echo -e "  ${YELLOW}→${NC} Customize ${BOLD}CLAUDE.md${NC} for your project"
echo -e "  ${YELLOW}→${NC} Review ${BOLD}.claude/settings.json${NC} permissions"
echo -e "  ${YELLOW}→${NC} Read the guide: ${CYAN}https://github.com/effeuteha/claude-stack${NC}"
echo ""
echo -e "${GREEN}${BOLD}Setup complete!${NC} Start Claude Code and run ${CYAN}/gsd:progress${NC} to begin."
echo ""
