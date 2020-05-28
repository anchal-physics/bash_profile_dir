alias wine='open -a /Applications/Wine\ Stable.app'
alias winscp='wine ~/.wine/drive_c/Program\ Files\ \(x86\)/WinSCP/WinSCP.exe'

for file in ~/Git/my_scripts/*.py;
do
  alias ${${file##*/}/.py/}="python "$file
done
