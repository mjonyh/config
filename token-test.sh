#!/bin/bash
# Quick token-management comparison demo

echo "=== Pi token settings ==="
python3 -c "
import json
with open('/Users/mjonyh/.pi/agent/settings.json') as f:
    s = json.load(f)
for k in ['defaultThinkingLevel','thinkingBudgets','cacheWarming','compaction']:
    print(f'{k}: {s.get(k, \"N/A\")}')
"

echo ""
echo "=== Basic agent (no budget/compaction) ==="
echo "No built-in reserve/compaction settings found."

echo ""
echo "=== Comparison ==="
echo "Pi: explicit budgets + compaction + cache warming"
echo "Others (Claude Code): also compaction, less granular budget control exposed"
