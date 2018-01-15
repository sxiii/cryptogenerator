##############################################################
# SEMI-AUTOMATIC CRYPTOCURRENCY CREATION SCRIPT v 0.3        #
##############################################################
# This script helps you create a cryptonote cryptocurrency.
# Pre-requirements: git, gcc, curl, cmake, libboost-all-dev, sed, and 20 megabytes of space
# sudo apt -y install git curl sed cmake libboost-all-dev (ubuntu/debian)
# sudo pacman -S git curl sed cmake libboost-all-dev (arch/manjaro)
# by Security XIII on 27.05.17 # Updated 15.01.2018

sudo apt -y install git curl sed cmake libboost-all-dev

echo "Welcome to semi-automatic cryptocurrency creation script."
echo "This is WIP (work in progress). Pre-beta version (v 0.3)"
echo "WARNING! This script checks mostly NOTHING. If you made a mistake,"
echo "fix it manually, or re-run the script."
echo 

# echo "Cloning git repo, please wait... Saving repo into 'cryptogenerator' folder"
# git clone https://github.com/sxiii/cryptogenerator
# cd cryptogenerator

echo "= NAME ="
echo "Please enter the name of the crypto! No special symbols, spaces etc."
echo "Hint: check new name via google and mapofcoins.com"
read name
echo "Your crypto will be named: $name. Great! Let's move on..."
echo

sed -i 's/NamePlaceholder/'"$name"'/g' src/CryptoNoteConfig.h
sed -i 's/CryptonotedPlaceholder/'"$name"'/g' src/CMakeLists.txt

echo "= Money Supply ="
echo "Enter money supply (amount of coins totally emmited)"
echo "Default (if empty) will be 18446744073709551616:"
read moneysupply
[[ -z "${moneysupply// }" ]] && moneysupply="(uint64_t)(-1)"
echo "Your money supply will be $moneysupply"
echo

if [[ ${moneysupply} == "(uint64_t)(-1)" ]]; then
sed -i 's/MoneysupplyPlaceholder/'"$moneysupply"'/g' src/CryptoNoteConfig.h
else
sed -i 's/MoneysupplyPlaceholder/UINT64_C('"$moneysupply"')/g' src/CryptoNoteConfig.h
fi

echo "= Network Speed (Difficulty Target) ="
echo "Let's set up difficulty target for block in seconds."
echo "Default is 120 seconds, if empty."
read difficulty
[[ -z "${difficulty// }" ]] && difficulty="120"
echo "Difficulty will be $difficulty seconds."
echo

sed -i 's/DifficultyPlaceholder/'"$difficulty"'/g' src/CryptoNoteConfig.h

echo "= Network Port ="
echo "Set up P2P port. If not set, will be picked random 10000...20000:"
read p2port
[[ -z "${p2port// }" ]] && p2port="$(shuf -i10000-20000 -n1)"
echo "P2P port will be $p2port. Great, move on."
echo

sed -i 's/PortPlaceholder/'"$p2port"'/g' src/CryptoNoteConfig.h

echo "= RPC Port ="
echo "Set up RPC port. If not set, will be picked random 20000..60000"
read rpcport
[[ -z "${rpcport// }" ]] && rpcport="$(shuf -i20000-60000 -n1)"
echo "RPC port will be $rpcport. Great, move on."
echo

sed -i 's/RpcPlaceholder/'"$rpcport"'/g' src/CryptoNoteConfig.h

echo "Enter first (1) seed node IP or domain name with port, for example: 1.2.3.4:10500"
echo "Please wait, getting your ip..."
ipaddr=$(curl -s ifconfig.me/ip)
echo "Note: your public IP address is $ipaddr, press enter to use it"
read ip
[[ -z "${ip// }" ]] && ip="$ipaddr:$p2port"
echo "Setting up node 1 IP: $ip"

sed -i 's/ip1placeholder/'"$ip"'/g' src/CryptoNoteConfig.h

echo "Enter second (2) seed node IP or domain name with port, for example: 4.3.2.1:50010"
read ip
[[ -z "${ip// }" ]] && ip="$ipaddr:$p2port"
echo "Setting up node 2 IP: $ip"

sed -i 's/ip2placeholder/'"$ip"'/g' src/CryptoNoteConfig.h

# Finally! Compilation itself!
echo "Please wait, compiling the project..."
make -j8

# Adding genesis block
genesis=$(./build/release/src/$name --print-genesis-tx | tail -1 | awk -F":" '{ print $2 }' | sed -e 's/,/;/g')
sed -i '/GENESIS_COINBASE_TX_HEX/c\const char GENESIS_COINBASE_TX_HEX[] = '"$genesis"'' src/CryptoNoteConfig.h

# Recompilation with genesis block
echo "Please wait, recompilation with our newly-baked genesis block..." 
make -j8 

# Final message
echo "Now we are ready to rock with own cryptonote crypto!"
echo "Please go to ./cryptogenerator/build/release/src location to find your binaries."
echo
echo "Now you can use the following programs:"
echo "* $name - your coin is your main app to start interacting with new coins"
echo "* simplewallet - wallet program (cli interface)"
echo "* walletd - wallet daemon"
echo "* miner - to mine your new coins"
echo
echo "Thank you for using @sxiii coin generation script!"
