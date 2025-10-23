#!/bin/bash

# Script to summarize staged git changes using Gemini and commit them.

# 1. Check if this is a git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Error: Not a git repository."
    exit 1
fi

# 2. Get the staged diff
git add .
diff_output=$(git diff --staged)

# 3. Check if there are any staged changes
if [ -z "$diff_output" ]; then
    echo "No staged changes to commit."
    exit 0
fi

# 4. Create the prompt for Gemini
# The prompt asks for a conventional commit message with a subject and body.
prompt="Based on the following git diff, generate a conventional commit message with a subject and a detailed body. The subject should follow the conventional commit format (e.g., 'feat: add new feature', 'fix: resolve bug'). The body should provide a more detailed explanation of the changes. The output should be ONLY the commit message itself, with no extra text, explanation, or markdown formatting."

echo "🤖 Asking Gemini to summarize your staged changes..."

# 5. Pipe the diff to the Gemini CLI and get the summary
# We pass the diff via stdin to the gemini command.
summary=$(echo "$diff_output" | gemini --model gemini-2.5-flash "$prompt")

# 6. Clean up the summary
# LLMs can sometimes add markdown backticks or quotes. This removes them.
cleaned_summary=$(echo "$summary" | tr -d '`' | sed 's/^[\"]*//;s/[\"]*$//')

# 7. Show the generated message and ask for confirmation
echo ""
echo "Generated Commit Message:"
echo "-------------------------"
echo "$cleaned_summary"
echo "-------------------------"
echo ""
read -p "Commit with this message? (y/n) " -n 1 -r
echo ""

# 8. If confirmed, perform the commit
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git commit -m "$cleaned_summary"
    echo "✅ Changes committed."
else
    echo "🛑 Commit aborted."
fi
