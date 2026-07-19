if exists("current_compiler")
  finish
endif
let current_compiler = "java"

CompilerSet makeprg=java\ %

CompilerSet errorformat=%E%f:%l:\ error:\ %m,
		       \%W%f:%l:\ warning:\ %m,
		       \%-Z%p^,
		       \%-C%.%#,
		       \%-G%.%#
