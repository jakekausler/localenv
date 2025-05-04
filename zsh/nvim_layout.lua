local width = vim.o.columns

if width < 100 then
	vim.cmd("tabnew $ZDOTDIR/.zshenv")
	vim.cmd("tabnew $ZDOTDIR/.aliases.sh")
	vim.cmd("tabnew $ZDOTDIR/.functions.sh")
	vim.cmd("tabnew $ZDOTDIR/widgets.zsh")
	vim.cmd("tabnext")
else
	vim.cmd("vsplit $ZDOTDIR/.aliases.sh")
	vim.cmd("split $ZDOTDIR/.functions.sh")
	vim.cmd("split $ZDOTDIR/widgets.zsh")
	vim.cmd("wincmd h")
	vim.cmd("split $ZDOTDIR/.zshenv")
	vim.cmd("wincmd k")
end
