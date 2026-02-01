# Why
Because I'm the idiot who prefers to pair program and chat with my llm while coding. This is a nice way to drop well formatted context into a chat interface. 

# Get it working

Update the file to point to your desired output folder.

```
mkdir -p ~/.local/bin
cp wlkr.janet ~/.local/bin/wlkr
chmod +x ~/.local/bin/wlkr
```

Add the below to your `~/.zshrc`

`export PATH="$HOME/.local/bin:$PATH"`

Reload your terminal or exit and start a new session.

Now you can wield the power of copying a single directory or a group of directories into a markdown file to feed to llm engineering rabbis.

`wlkr` - performs the scrape in current directory

`wlkr ./some-silly-directory` - single directory argument, ensure you use `./` to be relative to the path

`wlkr ./dir1 ./dir2` - multie directory scrape