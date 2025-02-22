<?php
require dirname(__DIR__) . 'vendor/autoload.php';

use Ratchet\MessageComponentInterface;
use Ratchet\ConnectionInterface;

class Chat implements MessageComponentInterface {
    protected $clients;

    public function __construct() {
        $this->clients = new \SplObjectStorage;
    }

    public function onOpen(ConnectionInterface $conn) {
        $this->clients->attach($conn);
        echo "Nova conexão! ID: {$conn->resourceId}\n";
    }

    public function onClose(ConnectionInterface $conn) {
        $this->clients->detach($conn);
        echo "Conexão fechada! ID: {$conn->resourceId}\n";
    }

    public function onMessage(ConnectionInterface $from, $msg) {
        echo "Mensagem recebida: {$msg}\n";
        foreach ($this->clients as $client) {
            if ($from !== $client) {
                $client->send($msg);
            }
        }
    }

    public function onError(ConnectionInterface $conn, \Exception $e) {
        echo "Erro: {$e->getMessage()}\n";
        $conn->close();
    }
}

// Usa a variável de ambiente PORT definida pelo Railway ou 8080 como padrão
$port = getenv('PORT') ?: 8080;

// Escuta em todas as interfaces
$app = new Ratchet\App('0.0.0.0', $port);
$app->route('/chat', new Chat, ['*']);
$app->run();
