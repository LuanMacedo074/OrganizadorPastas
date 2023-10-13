#!/bin/bash

# Termux:
#!/data/data/com.termux/files/usr/bin/bash

clear

# Entra na pasta Downloads do usuário
cd $HOME/Downloads

# Cria os subdiretorios caso eles não existam e move os arquivos
MV_FILE(){
	mkdir -p "$1"
	mv "$2" "$1"
}

# Passa por cada arquivo da pasta $HOME/Downloads
for F in *; do
	# Verifica se é diretório, caso seja, é ignorado
	if [[ -d $F ]]; then
		continue
	fi

	# Atribui a primeira palavra do tipo do arquivo à variável TYPE
	TYPE=`file -b "$F" | awk '{print $1;}'`

	# Verifica o tipo do arquivo e envia pra pasta correspondente
	case $TYPE in
		"PDF" | "Microsoft" | "UTF-8" )
			DIR="Documentos"
			MV_FILE "$DIR" "$F"
			;;

		"JPEG" | "PNG")
			DIR="Fotos"
			MV_FILE "$DIR" "$F"
			;;
		
		"Matroska" | "RIFF")
			DIR="Videos"
			MV_FILE "$DIR" "$F"
			;;
		
		"Zip" | "XZ" | "GZ" | "RAR" | "zlib")
			DIR="Compactados"
			MV_FILE "$DIR" "$F"
			;;

		"PE32" | "ELF" | "a")
			DIR="Executáveis"
			MV_FILE "$DIR" "$F"
			;;
		
		"ISO")
			# Sobrescreve a variável $TYPE com a segunda palavra do filetype para diferenciar ISO Media, de ISO CD-ROM
			TYPE=`file -b "$F" | awk '{print $2;}'`
			case $TYPE in
				"Media,")
				DIR="Videos"
					MV_FILE "$DIR" "$F"
					;;
				
				*)
					DIR="ISO"
					MV_FILE "$DIR" "$F"
					;;
			esac
			;;
		
		*)
			DIR="$TYPE"
			MV_FILE "$DIR" "$F"
			;;
	esac
	
	echo "Movido o arquivo $F para `pwd`/$DIR"
done

echo "thanks"