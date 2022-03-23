" With this function you can reuse the same terminal in neovim.
" You can toggle the terminal and also send a command to the same terminal.

let s:monkey_terminal_window = -1
let s:monkey_terminal_buffer = -1
let s:monkey_terminal_job_id = -1
let s:monkey_terminal_window_size = -1

function! CragTerminalOpen()
  " Check if buffer exists, if not create a window and a buffer
  if !bufexists(s:monkey_terminal_buffer)
    " Creates a window call monkey_terminal
    new monkey_terminal
    " Moves the window to the bottom
    wincmd J
    resize 20
    let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })

     " Change the name of the buffer to "Terminal 1"
     silent file Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
     let s:monkey_terminal_buffer = bufnr('%')

    " The buffer of the terminal won't appear in the list of the buffers
    " when calling :buffers command
    set nobuflisted
  else
    if !win_gotoid(s:monkey_terminal_window)
    sp
    " Moves to the window below the current one
    wincmd J
    execute "resize " . s:monkey_terminal_window_size
    buffer Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
    endif
  endif
endfunction

function! CragTerminalToggle()
  if win_gotoid(s:monkey_terminal_window)
    call CragTerminalClose()
  else
    call CragTerminalOpen()
  endif
endfunction

function! CragTerminalClose()
  if win_gotoid(s:monkey_terminal_window)
    let s:monkey_terminal_window_size = winheight(s:monkey_terminal_window)
    " close the current window
    hide
  endif
endfunction

function! CragTerminalExec(cmd)
  if !win_gotoid(s:monkey_terminal_window)
    call CragTerminalOpen()
  endif

  " clear current input
  call jobsend(s:monkey_terminal_job_id, "clear\n")

  " run cmd
  call jobsend(s:monkey_terminal_job_id, a:cmd . "\n")
  normal! G
  wincmd p
endfunction

" With this maps you can now toggle the terminal
nnoremap <leader><leader> :call CragTerminalToggle()<cr>
tnoremap <leader><leader> <C-\><C-n>:call CragTerminalToggle()<cr>
