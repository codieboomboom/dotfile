" Linters & fixers for Python only
let b:ale_linters = ['pylsp', 'ruff']
let b:ale_fixers  = ['ruff', 'ruff_format']

" Point pylsp's jedi at the active conda env
" $CONDA_PREFIX is set by `conda activate`; baked in at vim startup,
" so the rule is: one vim session per env.
let s:py = !empty($CONDA_PREFIX) ? $CONDA_PREFIX . '/bin/python' : 'python'
let g:ale_python_pylsp_config = {
\   'pylsp': {
\     'plugins': {
\       'jedi':        {'environment': s:py},
\       'pycodestyle': {'enabled': v:false},
\       'pyflakes':    {'enabled': v:false},
\       'mccabe':      {'enabled': v:false}
\     }
\   }
\}
