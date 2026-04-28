#!/usr/bin/enb bash

# ===== CONFIG =====
REPO_PATH="run"   # 🔴 change this
START_DATE="2026-03-12"
END_DATE="2026-04-28"
COMMITS_PER_DAY=1   # change if you want more commits per day

# ===== GO TO REPO =====
cd "$REPO_PATH" || exit

# ===== LOOP THROUGH DATES =====
current_date="$START_DATE"

while [[ "$current_date" < "$END_DATE" || "$current_date" == "$END_DATE" ]]; do
    
    for ((i=1; i<=COMMITS_PER_DAY; i++)); do
        echo hello
        # random time in the day
        hour=$(shuf -i 9-22 -n 1)
        minute=$(shuf -i 0-59 -n 1)
        second=$(shuf -i 0-59 -n 1)

        commit_date="${current_date} ${hour}:${minute}:${second}"

        echo "Commit on $commit_date"

        GIT_AUTHOR_DATE="$commit_date" \
        GIT_COMMITTER_DATE="$commit_date" \
        git commit --allow-empty -m "Backdated commit on $commit_date"

    done

    # move to next day
    current_date=$(date -I -d "$current_date + 1 day")
done

# ===== PUSH =====
git push origin main
