pids = `pgrep -f push`.split("\n")
`ruby -- /Users/shimtong1004/cloud/Copy/work/shopping_note/lib/tasks/push.rb &` if pids.size == 0