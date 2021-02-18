#!/usr/bin/env python3
import subprocess


def branch_list_generator():
    # Get all branches with commit id of latest commit
    for branch in subprocess.check_output(["git", "branch", "-v"]).decode().splitlines():
        branch = branch.strip("*").split()
        commit_msg = " ".join(branch[2:])

        # Get the dates of the commits ( relateive date, UNIX timestamp)
        dates = subprocess.check_output(["git", "log", branch[1], "-1", '--pretty=format:"%ct,%ar"']).decode().strip('"').split(",")

        yield (branch[0], branch[1], commit_msg, dates[1], dates[0])

# Sort branches by UNIX timestamp
for branch, commit_id, commit_msg, time, unix in sorted(branch_list_generator(), key=lambda tup: tup[4]):
    print("{:40s}\t{}\t{:12s} {:50s}".format(branch[:40], commit_id, time, commit_msg[:50] ))

