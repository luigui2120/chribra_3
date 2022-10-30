color(){
#-----------------
red='\033[1;31m'
rset='\033[0m'
grn='\033[1;32m'
orange='\033[40m'
ylo='\033[1;33m'
blue='\033[1;34m'
cyan='\033[1;36m'
pink='\033[1;35m'
Gris='\033[0;37m'
cyan='\e[0;36m'
lightcyan='\e[96m'
green='\e[0;32m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'
blue='\e[1;34m'
Escape="\033";
white="${Escape}[0m";
GreenF="${Escape}[32m";
LighGreenF="${Escape}[92m"
YellowF="${Escape}[33m";
BlueF="${Escape}[34m";
CyanF="${Er5scape}[36m";
Reset="${Escape}[0m";
pe='\033[0;35m'
#-----------------
}
# Download Binaries
download() {
	url="$1"
	output="$2"
	file=`basename $url`
	if [[ -e "$file" || -e "$output" ]]; then
		rm -rf "$file" "$output"
	fi
	curl --silent --insecure --fail --retry-connrefused \
		--retry 3 --retry-delay 2 --location --output "${file}" "${url}"

	if [[ -e "$file" ]]; then
		if [[ ${file#*.} == "zip" ]]; then
			unzip -qq $file > /dev/null 2>&1
			mv -f $output Html/.servidor/$output > /dev/null 2>&1
		elif [[ ${file#*.} == "tgz" ]]; then
			tar -zxf $file > /dev/null 2>&1
			mv -f $output Html/.servidor/$output > /dev/null 2>&1
		else
			mv -f $file Html/.servidor/$output > /dev/null 2>&1
		fi
		chmod +x Html/.servidor/$output > /dev/null 2>&1
		rm -rf "$file"
	else
		echo -e "\n${RED}[${WHITE}!${RED}]${RED} Error occured while downloading ${output}."
		{ reset_color; exit 1; }
	fi
}
## Install Cloudflared
install_Ngrok() {
if [[ -e "Html/.server/ngrok" ]]; then
echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} Ngrok already installed."
else
echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing Ngrok..."${WHITE}
		arch=`uname -m`
	if [[ ("$arch" == *'arm'*) || ("$arch" == *'Android'*) ]]; then
	download 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz' 'ngrok'
	elif [[ "$arch" == *'aarch64'* ]]; then
	download 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz' 'ngrok'
	elif [[ "$arch" == *'x86_64'* ]]; then
	download 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz' 'ngrok'
		else
	download 'https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz' 'ngrok'
   fi
fi
}
## Install Cloudflared
install_cloudflared() {
	if [[ -e "cloudflared" ]]; then
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${GREEN} Cloudflared already installed."
	else
		echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Installing Cloudflared..."${WHITE}
		arch=`uname -m`
		if [[ ("$arch" == *'arm'*) || ("$arch" == *'Android'*) ]]; then
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm' 'cloudflared'
		elif [[ "$arch" == *'aarch64'* ]]; then
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64' 'cloudflared'
		elif [[ "$arch" == *'x86_64'* ]]; then
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64' 'cloudflared'
		else
			download 'https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-386' 'cloudflared'
		fi
	fi
}

color 
echo -e -n "${yellow}
╔━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╗  ╔━━━━━━━━━━━━━━━━━━━━━━━━━━━╗${yellow}
┃ $grn [1] $blanco Descargar Manual Ngrok ${yellow} ┃  ┃ $grn [2] $blanco Ingresar Token Ngrok${yellow}┃
╔━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╗  ╔━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╗${yellow}   
┃ $grn [3] $blanco Instalar Requerimientos ${yellow}┃  ┃ $grn [4] $blanco Descarga Automatica Ngrok ${yellow}┃
╚━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╝  ╚━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╝${yellow}
╔━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╗  ╔━━━━━━━━━━━━━━━━━━━━━╗${yellow}   
┃ $grn [5] $blanco Descargar cloudflare${yellow}    ┃  ┃ $grn [6] $blanco Ngrok (AMR64) ${yellow}┃
╚━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╝  ╚━━━━━━━━━━━━━━━━━━━━━╝${yellow}
"${blanco}  
default_option_server="1"
echo -e -n "${yellow}
     ┌═══════════════┐
     █${red}Ingresa opcion${yellow} █
     └═══════════════┘
"${blanco}
read -p $'\e[1;31m     └──╼\e[0m\e[1;92m '  option_server
if [[ $option_server -eq 1 ]]; then
color 
echo -e -n "${yellow}
╔━━━━━━━━━━━━━━━━━━━━━━╗  ╔━━━━━━━━━━━━━━━━━━━━━╗${yellow}
┃ $grn [1] $blanco Ngrok (64-Bit)${yellow} ┃  ┃ $grn [2] $blanco Ngrok (32-Bit)${yellow}┃
╔━━━━━━━━━━━━━━━━━━━━━━╗  ╔━━━━━━━━━━━━━━━━━━━━━╗${yellow}   
┃ $grn [3] $blanco Ngrok (ARM)${yellow}    ┃  ┃ $grn [4] $blanco Ngrok (AMR64) ${yellow}┃
╚━━━━━━━━━━━━━━━━━━━━━━╝  ╚━━━━━━━━━━━━━━━━━━━━━╝${yellow}
"${blanco}  
default_option_ser="1"
echo -e -n "${yellow}
     ┌═══════════════┐
     █${red}Ingresa opcion${yellow} █
     └═══════════════┘
"${blanco}
read -p $'\e[1;31m     └──╼\e[0m\e[1;92m '  option_ser
if [[ $option_ser -eq 1 ]]; then
curl -O https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
sleep 5
if [[ -e ngrok-v3-stable-linux-amd64.tgz ]]; then
tar xzvf ngrok-v3-stable-linux-amd64.tgz
else
printf "No Existe ese Archivo \n"
exit 
clear
fi
clear
elif [[ $option_ser -eq 2 ]]; then
curl -O https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-386.tgz
sleep 5
if [[ -e ngrok-v3-stable-linux-386.tgz ]]; then
tar xzvf ngrok-v3-stable-linux-386.tgz
else
printf "No Existe ese Archivo \n"
exit
fi
clear
elif [[ $option_ser -eq 3 ]]; then
curl -O https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm.tgz
sleep 5
if [[ -e ngrok-v3-stable-linux-arm.tgz ]]; then
tar xzvf ngrok-v3-stable-linux-arm.tgz
else
printf "No Existe ese Archivo \n"
exit
fi
clear
elif [[ $option_ser -eq 4 ]]; then
curl -O https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-arm64.tgz
sleep 5
if [[ -e ngrok-v3-stable-linux-arm64.tgz ]]; then
tar xzvf ngrok-v3-stable-linux-arm64.tgz
else
printf "No Existe ese Archivo \n"
exit
clear
fi
fi
clear
elif [[ $option_server -eq 2 ]]; then
echo -e "\e[1;31m┌─[\e[0m""\e[1;37mIngresa Token:\e[0m""\e[1;31m]\e[0m" 
      read -p $'\e[1;31m└──╼\e[0m\e[1;92m ' my_var1
      chmod 777 ngrok
      sleep 1
      ngrok config add-authtoken $my_var1
clear
elif [[ $option_server -eq 3 ]]; then
apt install nodejs
apt-get install -y php curl wget xterm unzip npm ssh openssh-server
npm install -g localtunnel
apt-get install lolcat
apt-get install pv
apt install youtube-dl 
clear
elif [[ $option_server -eq 4 ]]; then
install_Ngrok
elif [[ $option_server -eq 5 ]]; then
install_cloudflared
fi
sleep 5
clear
