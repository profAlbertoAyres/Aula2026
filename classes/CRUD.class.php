<?php

abstract class CRUD
{
    protected $table;
    protected $db;

    public function __construct()
    {
        $this->db = Database::getInstance()->getConnection();
    }

    abstract public function add();
    abstract public function update(int $id);

    public function all()
    {
        $sql = "SELECT * FROM $this->table";
        $stmt = $this->db->prepare($sql);

        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_OBJ);
    }

    // Método para buscar um registro pelo campo e ID
    public function search(string $campo, int $id)
    {
        $sql = "SELECT * FROM $this->table WHERE $campo = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(":id", $id, PDO::PARAM_INT);
        $stmt->execute();

        return $stmt->rowCount() > 0 ? $stmt->fetch(PDO::FETCH_OBJ) : null;
    }

    // Método para excluir um registro pelo ID
    public function delete(string $campo, int $id): array
    {
        $sql = "DELETE FROM $this->table WHERE $campo = :id";
        $stmt = $this->db->prepare($sql);
        $stmt->bindParam(":id", $id, PDO::PARAM_INT);

        try {
            $stmt->execute();
            return [
                'success' => true,
                'message' => 'Registro excluído com sucesso.'
            ];
        } catch (PDOException $e) {
            $errorCode = $e->errorInfo[1] ?? null;

            if ($errorCode == 1451) {
                // Caso de chave estrangeira
                return [
                    'success' => false,
                    'message' => 'Não é possível excluir: o registro possui relacionamentos em outra tabela.'
                ];
            }

            // Outros erros → mostra código e mensagem
            return [
                'success' => false,
                'message' => "Erro ao excluir (código $errorCode): {$e->getMessage()}. 
                           Procure o Administrador do sistema."
            ];
        }
    }



    public function aleatorio(int $quantidade = 0, string $joins = null)
    {
        if ($quantidade > 0) {
            $sql = "SELECT * FROM {$this->table} {$joins} ORDER BY RAND() LIMIT :quantidade";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(":quantidade", $quantidade, PDO::PARAM_INT);
        } else {
            $sql = "SELECT * FROM {$this->table} {$joins} ORDER BY RAND()";
            $stmt = $this->db->prepare($sql);
        }

        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_OBJ);
    }

    public function sp_exibir($procedure)
    {
        $sql = "call $procedure";
        $stmt = $this->db->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_OBJ);
        
    }

    public function iniciaTrans()
    {
        $this->db->beginTransaction();
    }

    public function confirmaTrans()
    {
        $this->db->commit();
    }
    public function cancelarTrans()
    {
        $this->db->rollBack();
    }

}
