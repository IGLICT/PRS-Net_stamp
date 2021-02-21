# Create a virtual environment 
cd
virtualenv -p /usr/bin/python3.7 ~/prsnet

# Activate the virtual environment
source ~/prsnet/bin/activate

# Update pip
pip install -U pip

# install necessary library
pip install tensorflow-gpu==1.15.0
pip install torch==1.7.1
pip install torchsummary==1.5.1

echo "installing sucessfully"