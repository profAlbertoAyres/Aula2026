<?php

class Aluno extends CRUD{
    protected $table = "aluno";
    private int $id;
    private int $fkUsuario; 
    private $nome;
    private $sexo;
    private $nascimento;
    private $celular;
    private $logradouro;
    private $bairro;
    private $cidade;
    private $estado;
    private $cep;
    private $objetivo;

    public function add(){
        $sql = "INSERT INTO $this->table (fkusuario, nome, sexo, nascimento, celular, logradouro, bairro, cidade, estado, cep, objetivo) VALUES( :fkusuario, :nome, :sexo, :nascimento, :celular, :logradouro, :bairro, :cidade, :estado, :cep, :objetivo)";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(":fkusuario", $this->fkUsuario, PDO::PARAM_STR);
        $stmt->bindParam(":nome", $this->nome, PDO::PARAM_STR);
        $stmt->bindParam(":sexo", $this->sexo, PDO::PARAM_STR);
        $stmt->bindParam(":nascimento",$this->nascimento, PDO::PARAM_STR);
        $stmt->bindParam(":celular",$this->celular, PDO::PARAM_STR);
        $stmt->bindParam(":logradouro",$this->logradouro, PDO::PARAM_STR);
        $stmt->bindParam(":bairro",$this->bairro, PDO::PARAM_STR);
        $stmt->bindParam(":cidade",$this->cidade, PDO::PARAM_STR);
        $stmt->bindParam(":estado",$this->estado, PDO::PARAM_STR);
        $stmt->bindParam(":cep",$this->cep, PDO::PARAM_STR);
        $stmt->bindParam(":objetivo",$this->objetivo, PDO::PARAM_STR);
        return $stmt->execute();
    }

    public function update(){
        $sql = "UPDATE $this->table SET fkusuario = :fkusuario, nome = :nome, sexo = :sexo, nascimento = :nascimento, celular = :celular, logradouro = :logradouro, bairro = :bairro, cidade = :cidade, estado = :estado, cep = :cep, objetivo = :objetivo WHERE idaluno = :id;";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(":id",$this->id, PDO::PARAM_INT);
        $stmt->bindParam(":fkusuario", $this->fkUsuario, PDO::PARAM_STR);
        $stmt->bindParam(":nome", $this->nome, PDO::PARAM_STR);
        $stmt->bindParam(":sexo", $this->sexo, PDO::PARAM_STR);
        $stmt->bindParam(":nascimento",$this->nascimento, PDO::PARAM_STR);
        $stmt->bindParam(":celular",$this->celular, PDO::PARAM_STR);
        $stmt->bindParam(":logradouro",$this->logradouro, PDO::PARAM_STR);
        $stmt->bindParam(":bairro",$this->bairro, PDO::PARAM_STR);
        $stmt->bindParam(":cidade",$this->cidade, PDO::PARAM_STR);
        $stmt->bindParam(":estado",$this->estado, PDO::PARAM_STR);
        $stmt->bindParam(":cep",$this->cep, PDO::PARAM_STR);
        $stmt->bindParam(":objetivo",$this->objetivo, PDO::PARAM_STR);
        return $stmt->execute();
    }

    public function getId(){
        return $this->id;
    }

    public function setId($id){
        $this->id = (int)$id;
    }        

    public function getFkUsuario(){
        return $this->fkUsuario;
    }

    public function setFkUsuario($fkUsuario){
        $this->fkUsuario = (int)$fkUsuario;
    }
    
    public function getNome(){
        return $this->nome;
    }
    public function setNome($nome){
        $this->nome = $nome;
    }
    public function getSexo(){
        return $this->sexo;
    }
    public function setSexo($sexo){
        $this->sexo = $sexo;
    }
    public function getNascimento(){
        return $this->nascimento;
    }
    public function setNascimento($nascimento){
        $this->nascimento = $nascimento;
    }
    public function getCelular(){
        return $this->celular;
    }
    public function setCelular($celular){
        $this->celular = $celular;
    }
    public function getLogradouro(){
        return $this->logradouro;
    }
    public function setLogradouro($logradouro){
        $this->logradouro = $logradouro;
    }
    public function getBairro(){
        return $this->bairro;
    }
    public function setBairro($bairro){
        $this->bairro = $bairro;
    }
    public function getCidade(){
        return $this->cidade;
    }
    public function setCidade($cidade){
        $this->cidade = $cidade;
    }
    public function getEstado(){
        return $this->estado;
    }
    public function setEstado($estado){
        $this->estado = $estado;
    }
    public function getCep(){
        return $this->cep;
    }
    public function setCep($cep){
        $this->cep = $cep;
    }
    public function getObjetivo(){
        return $this->objetivo;
    }
    public function setObjetivo($objetivo){
        $this->objetivo = $objetivo;
    }
}