#!/bin/bash

# To support different ubuntu version check: https://docs.microsoft.com/en-us/dotnet/core/rid-catalog
# And you must also change in demo.csproj the value for RuntimeIdentifiers

targets=( ubuntu.16.04-x64 )

# Remove previous packages.
rm -rf demoapp*.deb

for i in "${targets[@]}"
do
	echo "Compiling for $i"

    rm -rf demoapp/usr/bin/demoappbin
    rm -rf demoapp/bin
    rm -rf demoapp/obj

    cd demoapp

    dotnet restore

    dotnet publish -c Release -r $i

    # Remove previous install.
    mkdir usr/bin/demoappbin
    cp -R bin/Release/netcoreapp1.1/$i/publish/* usr/bin/demoappbin

    sudo chmod 755 DEBIAN/post*
    sudo chmod 755 DEBIAN/pre*
    sudo chmod +x usr/bin/demoapp

    cd ..
    sudo dpkg-deb --build demoapp
    mv demoapp.deb demoapp-$i.deb
done

echo -e "\nUpload: demoapp-[ubuntu version].deb"
echo -e "Make sure to install libunwind8 (apt-get install libunwind8)"
echo -e "Installation: dpkg -i demoapp-[ubuntu version].deb"
echo -e "Uninstallation: apt-get remove -y demoapp"
echo -e "Usage: demoapp [args]\n"
