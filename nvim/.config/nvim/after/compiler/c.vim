if exists("current_compiler")
  finish
endif
let current_compiler = "c"

if !empty(findfile("Makefile", ".;"))
	CompilerSet makeprg=make
elseif !empty(findfile("Justfile", ".;"))
	CompilerSet makeprg=just
else
	let s = expand("%:t:r")
	let t = expand("%:t") 
	execute 'CompilerSet makeprg=cc\ ' .. t .. '\ -o\ ' .. s ..'\ &&\ ./' .. s
endif

