<?php

class Usuario extends CRUD
{
    protected $table = "usuario";
    private int $id;
    private $username;
    private $email;
    private $senha;
    private $tipoUsuario;
    private $ativo;

    public function add()
    {
        $sql = "INSERT INTO $this->table (username, email, senha, tipo_usuario, ativo) 
                VALUES (:username, :email, :senha, :tipo_usuario, :ativo)";
        $stmt = $this->db->prepare($sql);

        $stmt->bindParam(":username", $this->username, PDO::PARAM_STR);
        $stmt->bindParam(":email", $this->email, PDO::PARAM_STR);
        $stmt->bindParam(":senha", $this->senha, PDO::PARAM_STR);
        $stmt->bindParam(":tipo_usuario", $this->tipoUsuario, PDO::PARAM_STR);
        $stmt->bindParam(":ativo", $this->ativo, PDO::PARAM_INT);

        return $stmt->execute();
    }

    public function update()
    {
        $sql = "UPDATE $this->table SET username = :username, email = :email, 
                senha = :senha, tipo_usuario = :tipo_usuario, ativo = :ativo 
                WHERE idusuario = :id";
        $stmt = $this->db->prepare($sql);

        $stmt->bindParam(":id", $this->id, PDO::PARAM_INT);
        $stmt->bindParam(":username", $this->username, PDO::PARAM_STR);
        $stmt->bindParam(":email", $this->email, PDO::PARAM_STR);
        $stmt->bindParam(":senha", $this->senha, PDO::PARAM_STR);
        $stmt->bindParam(":tipo_usuario", $this->tipoUsuario, PDO::PARAM_STR);
        $stmt->bindParam(":ativo", $this->ativo, PDO::PARAM_INT);
        
        return $stmt->execute();
    }

    // Getters e Setters
    public function getId()
    {
        return $this->id;
    }
    public function setId($id)
    {
        $this->id = (int) $id;
    }

    public function getUsername()
    {
        return $this->username;
    }
    public function setUsername($username)
    {
        $this->username = $username;
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

    public function getTipoUsuario()
    {
        return $this->tipoUsuario;
    }
    public function setTipoUsuario($tipo)
    {
        $this->tipoUsuario = $tipo;
    }

    public function getAtivo()
    {
        return $this->ativo;
    }
    public function setAtivo($ativo)
    {
        $this->ativo = $ativo;
    }
}