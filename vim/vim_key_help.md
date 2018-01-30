## NERD commenter keybindings

* Comment out the current line or text selected in visual mode.
    `[count]<leader>cc |NERDComComment|`
  
* Comments the given lines using only one set of multipart delimiters.
    `[count]<leader>cm |NERDComMinimalComment|`

* Toggles the comment state of the selected line(s) individually.
    `[count]<leader>ci |NERDComInvertComment|`

* Uncomments the selected line(s).
    `[count]<leader>cu |NERDComUncommentLine|`

## searching with highlighting
  * toggle searching with highlighting
    `:set hlsearch!`
  * '*' search (forward) (and mark) all occurences of word currently under coursor
  * '#' search (backward) (and mark) all occurences of word currently under coursor

## windows manipulation

* change left/right window size
    'CTRL-w <NUM><'
    'CTRL-w <NUM>>'

## general vim key shortcuts
Within command mode:
* `dd` -- cut line 
* `p` -- paste line after current
* `P` -- paste line before current
* `d<movement>` -- cut equivalent of movement
* `dw` -- cut word
* `d<down arrow>` -- cut this line and the line below
* `yy` -- copy line, works like `dd`
* `D` -- cut to the end of line
* `vsp` -- vertically split window
* `sp` -- horizontally split window
* `CTRL-g` -- where I am?
* `CTRL-]` -- jump to tag
* `CTRL-T` -- jump back
* `CTRL-W-CTRL-{H|J|K|L|<-|^|v|->}` - window focus navigation
* `bad` -- add file to buffer list (_buffer add_)
* `bd [N]` -- unload and delete buffer from buffer list (_buffer delete_)
* `g]`,`g-CTRL-]` -- open tag, label list
* `CTRL-\` -- open def in inew tab
* `ALT+]` -- open def in vertical split

* creating tags file: `$ctags -R --language=c++ .`
