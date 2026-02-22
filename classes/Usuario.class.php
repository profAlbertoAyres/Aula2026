<?php

class Usuario extends CRUD
{
    protected $table = "usuario";
    private $id;
    private $nome;
    private $email;
    private $senha;
    private $nivel;
    public $redirect;

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;
    }

    public function getNome()
    {
        return $this->nome;
    }

    public function setNome($nome)
    {
        $this->nome = $nome;
    }

    public function getEmail()
    {
        return $this->email;
    }

    public function setEmail($email)
    {
        $this->email = $email;
    }
    public function getSenha()
    {
        return $this->senha;
    }

    public function setSenha($senha)
    {
        $this->senha = $senha;
    }
    public function getNivel()
    {
        return $this->nivel;
    }

    public function setNivel($nivel)
    {
        $this->nivel = $nivel;
    }

    public function getRedirect()
    {
        return $this->redirect;
    }

    public function setRedirect($redirect)
    {
        $this->redirect = $redirect;
    }

    public function add()
    {
        try {
            $sql = "INSERT INTO {$this->table} (nome, email, senha, nivel_acesso) 
                VALUES (:nome, :email, :senha, :nivel_acesso)";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':nome', $this->nome);
            $stmt->bindParam(':email', $this->email);
            $stmt->bindParam(':senha', $this->senha);
            $stmt->bindParam(':nivel_acesso', $this->nivel);

            $stmt->execute();
            return true;

        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                $msg = $e->getMessage();

                if (strpos($msg, 'emailusuario') !== false) {
                    return "Erro: este e-mail já está cadastrado!";
                } elseif (strpos($msg, 'nomeusuario') !== false) {
                    return "Erro: este usuário já está cadastrado!";
                } else {
                    return "Erro: dado duplicado em campo único!";
                }
            }
            return "Erro inesperado: " . $e->getMessage();
        }
    }



    public function update(int $id)
    {
        try {
            $sql = "UPDATE $this->table SET nome=:nome, nivel_acesso=:nivel_acesso WHERE $campo=:id";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':nome', $this->nome);
            $stmt->bindParam(':nivel_acesso', $this->nivel);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
            return true;

        } catch (PDOException $e) {
            if ($e->getCode() == 23000) {
                $msg = $e->getMessage();

                if (strpos($msg, 'nomeusuario') !== false) {
                    return "Erro: este usuário já está cadastrado!";
                } else {
                    return "Erro: dado duplicado em campo único!";
                }
            }
            return "Erro inesperado: " . $e->getMessage();
        }
    }

    public function login()
    {
        if (session_status() === PHP_SESSION_NONE) {
            session_start();
        }
        $sql = "SELECT * FROM  $this->table WHERE nome = :nome";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(':nome', $this->nome);
        $stmt->execute();
        if ($stmt->rowCount() > 0) {
            $usuario = $stmt->fetch(PDO::FETCH_OBJ);
            if (password_verify($this->senha, $usuario->senha)) {
                $_SESSION['user_id'] = $usuario->id_usuario;
                $_SESSION['user_name'] = $usuario->nome;
                $redirect_url = $this->redirect ?? 'dashboard.php';
                header("Location: $redirect_url");
                exit();
            }
        }
        return "Usuário ou Senha incorreta. Por favor, tente novamente.";
    }

    public function logout()
    {
        session_unset();
        session_destroy();
        header("Location: login.php");
        exit();
    }

    public function atualiza_email()
    {

        try {
            // Verifica se a senha atual está correta
            $sql = "SELECT * FROM $this->table WHERE nome = :nome";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':nome', $this->nome);
            $stmt->execute();
            if ($stmt->rowCount() > 0) {
                $usuario = $stmt->fetch(PDO::FETCH_OBJ);
                if (password_verify($this->senha, $usuario->senha)) {
                    // Atualiza o e-mail
                    $sql = "UPDATE $this->table SET email = :email WHERE nome = :nome";
                    $stmt = $this->db->prepare($sql);
                    $stmt->bindParam(':email', $this->email, PDO::PARAM_STR);
                    $stmt->bindParam(':nome', $this->nome);

                    return $stmt->execute();
                } else {
                }
                return 'Usuário ou Senha incorreta. Por favor, tente novamente.';
            }
        } catch (PDOException $e) {
            return 'Erro no sistema contate o administrador';
        }
    }

    public function alterarSenha($senhaAtual)
    {
        try {
            // Verifica se a senha atual está correta
            $sql = "SELECT * FROM $this->table WHERE nome = :nome";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':nome', $this->nome, PDO::PARAM_STR);
            $stmt->execute();
            if ($stmt->rowCount() > 0) {
                $usuario = $stmt->fetch(PDO::FETCH_OBJ);
                if ($usuario && password_verify($senhaAtual, $usuario->senha)) {
                    // Atualiza com a nova senha (hash)
                    $novaSenhaHash = password_hash($this->senha, PASSWORD_DEFAULT);
                    $sql = "UPDATE $this->table SET senha = :novaSenha WHERE nome = :nome";
                    $stmt = $this->db->prepare($sql);
                    $stmt->bindParam(':novaSenha', $novaSenhaHash, PDO::PARAM_STR);
                    $stmt->bindParam(':nome', $this->nome, PDO::PARAM_STR);
                    return $stmt->execute();
                }
            } else {
                return false; // Senha atual incorreta
            }
        } catch (PDOException $e) {
            return false;
        }
    }

}
