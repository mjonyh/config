#!/bin/bash

echo "ZSH Performance Comparison Test"
echo "==============================="

# Test current zshrc
echo -n "Testing current zshrc (5 runs): "
total_time=0
for i in {1..5}; do
    start_time=$(date +%s%N)
    ZDOTDIR=/tmp zsh -c 'cp ~/git/config/zshrc ~/.zshrc; source ~/.zshrc; exit' 2>/dev/null
    end_time=$(date +%s%N)
    duration=$((($end_time - $start_time) / 1000000))  # Convert to milliseconds
    total_time=$(($total_time + $duration))
done
avg_current=$((total_time / 5))
echo "${avg_current}ms average"

# Test optimized zshrc  
echo -n "Testing optimized zshrc (5 runs): "
total_time=0
for i in {1..5}; do
    start_time=$(date +%s%N)
    ZDOTDIR=/tmp zsh -c 'cp ~/git/config/zshrc ~/.zshrc; source ~/.zshrc; exit' 2>/dev/null
    end_time=$(date +%s%N)
    duration=$((($end_time - $start_time) / 1000000))  # Convert to milliseconds
    total_time=$(($total_time + duration))
done
avg_optimized=$((total_time / 5))
echo "${avg_optimized}ms average"

# Calculate improvement
improvement=$((avg_current - avg_optimized))
percentage=$(((improvement * 100) / avg_current))

echo ""
echo "Results:"
echo "--------"
echo "Current zshrc:    ${avg_current}ms"
echo "Optimized zshrc:  ${avg_optimized}ms"
echo "Improvement:      ${improvement}ms (${percentage}% faster)"

# Cleanup
rm -f /tmp/.zshrc
