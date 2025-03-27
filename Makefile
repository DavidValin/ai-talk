all:
	@echo "Downloading whisper large model..."
	@mkdir -p "$(HOME)/.whisper-models"
	@curl -L -J -o "$(HOME)/.whisper-models/ggml-large-v3-q5_0.bin" --create-dirs https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-large-v3-q5_0.bin
	@echo "Installing 'ttalk' command in '/usr/local/bin/ttalk...'"
	@if [ -f "/usr/local/bin/ttalk" ]; then \
		read -p "An installation of '/usr/local/bin/ttalk' already exists. Do you want to overwrite it? (y/n): " response; \
		if [ "$$response" = "y" ] || [ "$$response" = "Y" ]; then \
		  chmod +x ttalk.sh; \
			sudo cp ttalk.sh /usr/local/bin/ttalk; \
			echo "'ttalk' command installed!"; \
		else \
			echo "Installation canceled!"; \
			exit 0; \
		fi; \
	else \
		sudo cp ttalk.sh /usr/local/bin/ttalk; \
		echo "'ttalk' command installed!"; \
	fi
