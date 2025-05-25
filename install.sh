#!/bin/bash

echo "🚀 Iniciando a instalação do FGTV..."

# Solicitar dados do banco
read -p "Digite o nome do Banco de Dados: " DB_NAME
read -p "Digite o nome do usuário do Banco de Dados: " DB_USER
read -sp "Digite a senha do Banco de Dados: " DB_PASS
echo ""

# Instalar dependências
echo "🚀 Instalando dependências..."
sudo apt update
sudo apt install -y nginx php php-mysql php-cli mysql-server git unzip

# Clonar repositório
echo "🚀 Clonando repositório do FGTV..."
cd /var/www/html
sudo git clone https://github.com/FG-telecom/FGTV.git
sudo chown -R www-data:www-data FGTV
cd FGTV

# Configuração do Banco de Dados
echo "🚀 Configurando o MySQL..."
sudo mysql -e "CREATE DATABASE ${DB_NAME};"
sudo mysql -e "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Importar estrutura inicial (ajuste o caminho conforme seu projeto)
if [ -f database/schema.sql ]; then
    sudo mysql -u ${DB_USER} -p${DB_PASS} ${DB_NAME} < database/schema.sql
fi

# Criar arquivo de configuração do banco
cat <<EOL > backend/config.php
<?php
\$host = "localhost";
\$db = "${DB_NAME}";
\$user = "${DB_USER}";
\$pass = "${DB_PASS}";

try {
    \$pdo = new PDO("mysql:host=\$host;dbname=\$db;charset=utf8", \$user, \$pass);
    \$pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException \$e) {
    die("Erro na conexão: " . \$e->getMessage());
}
?>
EOL

# Configurar NGINX
echo "🚀 Configurando NGINX..."
sudo tee /etc/nginx/sites-available/fgtv <<EOF
server {
    listen 80;
    server_name _;

    root /var/www/html/FGTV/frontend;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$args;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php-fpm.sock;
    }

    location ~ /\.ht {
        deny all;
    }
}
EOF

sudo ln -s /etc/nginx/sites-available/fgtv /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx
sudo systemctl restart php*-fpm

echo "✅ Instalação concluída!"
echo "🌐 Acesse: http://SEU_IP ou http://SEU_DOMINIO para usar o painel IPTV."
