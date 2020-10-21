alias wine='open -a /Applications/Wine\ Stable.app'
alias winscp='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/WinSCP/WinSCP.exe'
alias syncTSfile='python ~/Git/cit_ctnlab/ctn_scripts/syncTSfiles.py'
alias liconvert='~/Git/lireader/liconvert'
for file in ~/Git/my_scripts/*.py;
do
  alias ${${file##*/}/.py/}="python "$file
done
for file in ~/Git/cit_ctnlab/ctn_scripts/moku*.py;
do
  alias ${${file##*/}/.py/}="python "$file
done
