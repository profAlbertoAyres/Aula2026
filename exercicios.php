<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <title>Exercicios | PersonalPRO</title>
</head>
<body>
    <?php 
    require_once "_parts/_menu.php";
    
    spl_autoload_register(function ($class) {
      require_once "class/{$class}.class.php";
    });

    $exercicio = new Exercicio();

    $exercicios = $exercicio->all();
    
    ?>
    
<main class="container">
  <div class="mt-5 d-flex justify-content-between p-5">
    <h3>Exercícios</h3>
    <a href="ger-exercicio.php" class="btn btn-success">Novo Exercício</a>
  </div>

  <div class="mb-3 d-flex gap-2 justify-content-center">
    <div class="col-md-6">
      <input type="text" name="campo-filtro" id="campo-filtro" class="form-control" placeholder="🔍 Digite para pesquisar" title="Pesquise pelo nome do exercício">
    </div>
  </div>

  <table class="table p-3" id="tabela-exercicios">
    <thead>
      <tr>
        <th class="text-center">#</th>
        <th>Nome</th>
        <th class="text-center">Ações</th>
      </tr>
    </thead>
    <tbody>
      <?php foreach($exercicios as $exec): ?>
      <tr>
        <td><?php echo $exec->idexercicio ?></td>
        <td><?php echo $exec->nome ?></td>
        <td class="d-flex gap-1 justify-content-center">
            <a href="#" class="btn btn-outline-info btn-sm">
              <i class="bi bi-eye"></i>
            </a>
            <a href="ger-exercicio.php?id=<?= $exec->idexercicio ?>" class="btn btn-outline-primary btn-sm">
              <i class="bi bi-pencil-square"></i>
            </a>
            <form action="db-exercicio.php" method="post">
              <input type="hidden" name="id" value="<?= $exec->idexercicio ?? null ?>">
              <button type="submit" class="btn btn-sm btn-outline-danger" onclick="confirm('Deseja excluir o registro?')" name="btn-deletar">
                <i class="bi bi-trash"></i>
              </button>
            </form>
        </td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
 <div class="alert alert-info d-flex justify-content-center d-none" id="msg-vazio">
  <i class="bi bi-info-circle mx-2"></i> Nenhum exercício encontrado para o filtro digitado.
 </div> 
    
</main>
    


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

<script src="js/tb-interativa.js"></script>
<script src="js/exercicios.js"></script>
</body>
</html>