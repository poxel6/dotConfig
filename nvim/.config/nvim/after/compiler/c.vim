if exists("current_compiler")
  finish
endif
let current_compiler = "c"

if !empty(findfile("Makefile", ".;"))
	CompilerSet makeprg=make
elseif !empty(findfile("Justfile", ".;"))
	CompilerSet makeprg=just
else
	let s = expand("%:r")
	execute 'CompilerSet makeprg=cc\ %\ -o\ ' .. s ..'\ &&\ ./' .. s
endif

