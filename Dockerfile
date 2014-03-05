# Using base ubuntu, which defaults to 12.04
From ubuntu

# Update and upgrade before continuing
RUN apt-get update
RUN apt-get upgrade

# Install the packages needed for bootstraping the development environment
Run apt-get install -y wget build-essential vim git perl-doc libssl-dev

# Create a non priveleged user
RUN useradd -m -s /bin/bash duckpan

# Download the install script 
RUN su -l duckpan -c 'wget -L http://duckpan.com/install.pl -O duckpan-install.pl'

# The first run of install script always exits with non-zero status
# To let the build process continue executing, we negate the exit status with "!"
RUN ! (su -l duckpan -c 'perl duckpan-install.pl')

# Running the 2nd installation attempt from bash in order to source the .bashrc updated by the 1rst attempt
RUN su -l duckpan -c 'bash -l -i -c "perl duckpan-install.pl"'
