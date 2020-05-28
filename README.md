# bash_profile_dir
Directory to store bash_profile in a modular fashion.

## Following is added in my main .bash_profile file at the top
```
for file in ~/Git/bash_profile_dir/*.bash_profile;
do
  source $file
done
```
This loads everything from different modules present in this repo.
