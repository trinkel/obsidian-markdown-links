# Hints and future ideas

## Exclude directories

To exclude directories that contain a specific file (like `.makeLinksIgnore`).

```bash title:"Exclude directories sample code from googlebot
# Sample code
# Add 'specific_file_name' to global .gitignore (or will this get me in trouble with repos that contain this file for some other reason?)
find . -type d \! -exec test -e '{}/specific_file_name' \; -prune -o -type f -print
```
### Resources

[Google AI Overview of a search](https://www.google.com/search?q=bash+find+command%C2%A0exclude+directories+that+contain+a+specific+file+%28like+%60.makeLinksIgnore%60%29&client=safari&hs=MhaU&sca_esv=f2c259abd1bdf684&rls=en&sxsrf=ANbL-n6k18b1xJggnpxAIBYvW1BUUANPkQ%3A1769746617961&ei=uTB8acCrOrG9p84PnJ2VgQ4&ved=0ahUKEwiA7IX0s7KSAxWx3skDHZxOJeAQ4dUDCBE&uact=5&oq=bash+find+command%C2%A0exclude+directories+that+contain+a+specific+file+%28like+%60.makeLinksIgnore%60%29&gs_lp=Egxnd3Mtd2l6LXNlcnAiXWJhc2ggZmluZCBjb21tYW5kwqBleGNsdWRlIGRpcmVjdG9yaWVzIHRoYXQgY29udGFpbiBhIHNwZWNpZmljIGZpbGUgKGxpa2UgYC5tYWtlTGlua3NJZ25vcmVgKUi3UFD3EFjyOXACeAGQAQCYAb8BoAG9EaoBBDUuMTW4AQPIAQD4AQH4AQKYAhWgAocSwgIKEAAYsAMY1gQYR8ICCxAAGIAEGJECGIoFwgIOEC4YgAQYsQMY0QMYxwHCAg4QABiABBixAxiDARiKBcICCxAAGIAEGLEDGIMBwgILEC4YgAQY0QMYxwHCAgUQABiABMICDhAuGIAEGLEDGIMBGIoFwgIKECMYgAQYJxiKBcICBBAjGCfCAgoQABiABBhDGIoFwgIQEAAYgAQYsQMYgwEYFBiHAsICDhAAGIAEGJECGLEDGIoFwgINEAAYgAQYsQMYQxiKBcICBRAuGIAEwgIKEAAYgAQYFBiHAsICCxAuGIAEGLEDGIMBwgIGEAAYFhgewgIIEAAYgAQYogTCAgUQABjvBcICCBAAGKIEGIkFmAMAiAYBkAYIkgcEMy4xOKAH_acBsgcEMS4xOLgH3xHCBwYyLTE4LjPIB3uACAA&sclient=gws-wiz-serp)

[Answer to "Exclude directories in find that don't contain a specific filename?" on Stack Overflow](https://stackoverflow.com/a/16240589)

