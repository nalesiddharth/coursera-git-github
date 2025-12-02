#!/usr/bin/env bash
# simple-interest.sh
# Computes Simple Interest = (P * R * T) / 100
# Usage:
#   ./simple-interest.sh --principal 1000 --rate 5 --time 2
#   or interactive mode: ./simple-interest.sh

print_usage() {
  cat <<EOF
Usage: $0 [--principal P] [--rate R] [--time T] [-h|--help]

Options:
  --principal   Principal amount (positive number)
  --rate        Annual interest rate (percentage, positive number)
  --time        Time period in years (positive number)
  -h, --help    Show this help and exit

If no options are supplied, the script runs in interactive mode.
EOF
}

# parse args
P=""
R=""
T=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --principal) P="$2"; shift 2 ;;
    --rate) R="$2"; shift 2 ;;
    --time) T="$2"; shift 2 ;;
    -h|--help) print_usage; exit 0 ;;
    *) echo "Unknown option: $1"; print_usage; exit 1 ;;
  esac
done

# interactive prompts if needed
if [[ -z "$P" ]]; then
  read -p "Enter principal amount (P): " P
fi
if [[ -z "$R" ]]; then
  read -p "Enter annual interest rate (R in %): " R
fi
if [[ -z "$T" ]]; then
  read -p "Enter time in years (T): " T
fi

# validate numeric using regex
is_number() {
  [[ $1 =~ ^[0-9]+([.][0-9]+)?$ ]]
}

if ! is_number "$P" || ! is_number "$R" || ! is_number "$T"; then
  echo "Error: principal, rate and time must be positive numbers."
  exit 2
fi

SI=$(awk "BEGIN {printf "%.2f", ($P * $R * $T) / 100}")
echo "Principal (P): $P"
echo "Rate (R): $R %"
echo "Time (T): $T years"
echo "Simple Interest (SI): $SI"
