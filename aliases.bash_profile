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
for file in ~/Git/40m/labutils/netgpibdata/*.py;
do
  alias ${${file##*/}/.py/}="python "$file
done

# ssh functions
## Nodus
alias nodus='myssh controls nodus.ligo.caltech.edu'
## CTN WS1
alias ctnws1='myssh controls 131.215.115.216'
## 2um WS1
alias 2umws1='myssh controls 131.215.123.219'
## Red Pitaya
alias rp1='myssh root rp-f071e9.local'

# scp functions
## Nodus
alias nodusscp='sshscp controls nodus.ligo.caltech.edu'
alias scpnodus='scpssh controls nodus.ligo.caltech.edu'
## CTN WS1
alias ctnws1scp='sshscp controls 131.215.115.216'
alias scpctnws1='scpssh controls 131.215.115.216'
## 2um WS1
alias 2umws1scp='sshscp controls 131.215.123.219'
alias scp2umws1='scpssh controls 131.215.123.219'
## Red Pitaya
alias rp1scp='sshscp root rp-f071e9.local'
alias scprp1='scpssh root rp-f071e9.local'
