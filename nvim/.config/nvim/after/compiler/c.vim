if exists("current_compiler")
  finish
endif
let current_compiler = "c"

if !empty(findfile("Makefile", ".;"))
	CompilerSet makeprg=make
elseif !empty(findfile("Justfile", ".;"))
	CompilerSet makeprg=just
else
	CompilerSet makeprg=cc\ %\ -o\ %:r\ &&\ %:p:r
endif

