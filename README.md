## Sennheiser GSX 1000 Linux fix 
### I don't care about chat output and only want virtual surround edition
This is a modification of [evilphish's GSX1000/GSX1200 fix](https://github.com/evilphish/sennheiser-gsx-1000) that only adds virtual surround with **stereo** output and fixes the order of the channels. 

Reasons to use: 
- You don't care about the mono chat output
- You only want virtual surround
- You don't like how some 8-channel media sounds with the non-stereo version of this fix (i.e., quiet voices in movies)

This is a quick edit of the install file with hard-coded support for the GSX 1000. If you have a 1200, replace all instances of `1000` in `install.sh` with `1200`; this is untested, however, as I don't have a GSX 1200.

## Installation
```
git clone https://github.com/Jawfish/sennheiser-gsx-1000
cd sennheiser-gsx-1000
./install.sh
```
