"if exists("current_compiler")
"  finish
"endif
let current_compiler = "python"

CompilerSet makeprg=python3\ %

"CompilerSet errorformat=%E%f:%l:\ error:\ %m,
"		       \%W%f:%l:\ warning:\ %m,
"		       \%-Z%p^,
"		       \%-C%.%#,
"		       \%-G%.%#
