fun! Vimfun(x)
	python import vim
	python f(vim.eval(str('a:x')))
endfun

python << EOF
def f(x):
	print x
EOF

" run it
call Vimfun('Hello!')
