all: intro.html _includes/sidenav.html
	jekyll build

intro.html: data/big.py data/master.xml
	mkdir -p sections units lessons vocabs dialogs
	cd data; python big.py master.xml

_includes/sidenav.html: data/sidenav.py data/master.xml
	cd data; python sidenav.py master.xml