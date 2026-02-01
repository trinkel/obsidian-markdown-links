# Hints and future ideas

## Exclude directories

To exclude directories that contain a specific file (like `.makeLinksIgnore`).

```bash title:"Exclude directories sample code from googlebot
# Sample code
# Add 'specific_file_name' to global .gitignore (or will this get me in trouble with repos that contain this file for some other reason?)
find . -type d \! -exec test -e '{}/specific_file_name' \; -prune -o -type f -print
```

