openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj '/C=FR/ST=75/L=Paris/O=42/CN=ncolomer' \
	-keyout localhost.key -out localhost.crt
