all: intro.html _includes/sidenav.html
	jekyll build

intro.html: data/big.py data/master.xml
	mkdir -p lessons vocabs dialogs units sections
	cd data; python big.py master.xml

_includes/sidenav.html: data/sidenav.py data/master.xml
	cd data; python sidenav.py master.xml