# Cryptogenerator
This script helps you create own cryptocurrency. It asks you several questions, you answer, and here it is! Easy as 1-2-3 and fast (takes approx. 3 minutes on decent hardware).

[![asciicast](https://asciinema.org/a/157053.png)](https://asciinema.org/a/157053)

## About this repository
This is two-way repo - it both contains:
* cryptonote reference implementation (improved by karbowanec team)
* script, that asks you several questions (7, actually) and compiles your own cryptocurrency

## Requirements (just get ubuntu!)
Requirements are automatically installed by the script, *if you use ubuntu*. If not, please install the following: git, curl, sed, cmake, libboost-all-dev. For instance, you can do it manually like this in ArchLinux: `sudo pacman -S git curl sed cmake libboost-all-dev`.

The script works perfect (tested) on the following software config:
* Ubuntu 16.04.3 LTS (xenial)
* Linux mainframe 4.10.0-42-generic #46~16.04.1-Ubuntu SMP Mon Dec 4 15:57:59 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
* LSB Version:	core-9.20160110ubuntu0.2-amd64:core-9.20160110ubuntu0.2-noarch:printing-9.20160110ubuntu0.2-amd64:printing-9.20160110ubuntu0.2-noarch:security-9.20160110ubuntu0.2-amd64:security-9.20160110ubuntu0.2-noarch

You will also need up to 100 megabytes of free space.

## How to work with this repo
0) Install git, if you don't have it `sudo apt install git`
1) Clone this repo with: `git clone https://github.com/sxiii/cryptogenerator`
2) Enter the folder with script: `cd cryptogenerator`
3) Make the script executable: `chmod +x cryptogenerator.sh`
4) Run the cool, semi-automatic script: `./cryptogenerator.sh`
5) Answer 7 questions one-at-a-time. After each question (answer) press enter.
6) Wait few minutes, and... Done! Your crypto is laying at ./cryptogenerator/build/release/src

## Resulting binaries
Please go to ./cryptogenerator/build/release/src location to find your binaries.

Now you can use the following programs:
* coinname - your coin is your main app to start interacting with new coins
* simplewallet - wallet program (cli interface)
* walletd - wallet daemon
* miner - to mine your new coins

## Framework used
CryptoNote framework, improved by karbowanec team.

## We're hiring
If you can help this project to develop, please, do so. I created this repo for collaborative work so everybody who founds any issues or errors could interact with this project to get fast fixing.

## Current tasks
* Make this script more flexible with different set-up levels: newbie, pro, expert
* Testing, issues and bug-reports: get the community feedback to see if it's useful
* Test & fully check that script supports archlinux/manjaro
* In the later future - let this script build coins based on different crypto-frameworks (not only cryptonote)
