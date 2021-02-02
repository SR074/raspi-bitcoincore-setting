wget https://bitcoin.org/bin/bitcoin-core-0.21.0/bitcoin-0.21.0-arm-linux-gnueabihf.tar.gz

tar -xvf bitcoin-0.21.0-arm-linux-gnueabihf.tar.gz
mkdir ~/.bitcoin ~/bitcoin-0.21.0/data ~/bitcoin-0.21.0/share/rpcauth
wget -O bitcoin.conf.sample -P ~/.bitcoin/ https://raw.githubusercontent.com/bitcoin/bitcoin/master/share/examples/bitcoin.conf
wget -P ~/bitcoin-0.21.0/share/rpcauth https://raw.githubusercontent.com/bitcoin/bitcoin/master/share/rpcauth/rpcauth.py
chmod +x ~/bitcoin-0.21.0/share/rpcauth/rpcauth.py
python3 ~/bitcoin-0.21.0/share/rpcauth/rpcauth.py $(hostname) | tee ~/rpcauth.txt


echo 'regtest=1' >> ~/.bitcoin/bitcoin.conf
echo -n -e "\n" >> ~/.bitcoin/bitcoin.conf

echo rpcuser=$(hostname) >> ~/.bitcoin/bitcoin.conf
tail -n1 rpcauth.txt | echo rpcpassword=$(cat) >> ~/.bitcoin/bitcoin.conf
grep rpcauth rpcauth.txt >> ~/.bitcoin/bitcoin.conf
echo -n -e "\n" >> ~/.bitcoin/bitcoin.conf

echo '[main]' >> ~/.bitcoin/bitcoin.conf
echo -n -e "\n" >> ~/.bitcoin/bitcoin.conf
echo '[test]' >> ~/.bitcoin/bitcoin.conf
echo -n -e "\n" >> ~/.bitcoin/bitcoin.conf
echo '[regtest]' >> ~/.bitcoin/bitcoin.conf
sed -i '$ a datadir=/home/'$USER'/bitcoin-0.21.0/data' ~/.bitcoin/bitcoin.conf

echo -n -e "\n" >> ~/.bashrc
echo 'export PATH=$PATH:/home/'$USER'/bitcoin-0.21.0/bin' >> ~/.bashrc
source .bashrc
