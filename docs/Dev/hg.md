https://www.mercurial-scm.org/wiki/ConvertExtension


## --filemap map.txt

```txt
include "."
exclude "doc"
include "doc/foo bar.txt"
include "doc/FAQ"
rename "doc/FAQ" "faq"
```

## --branchmap branch.txt

```txt
original_branch_name new_branch_name
```