git_delete_branch () {
	git branch -d $1
	git push origin :$1
}
