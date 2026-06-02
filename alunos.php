<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
  <title>Alunos | PersonalPRO</title>
</head>

<body>
  <?php
  require_once "_parts/_menu.php";

  spl_autoload_register(function ($class) {
    require_once "class/{$class}.class.php";
  });

  $aluno = new Aluno();

  $alunos = $aluno->all();

  $status = filter_input(INPUT_GET, 'status', FILTER_SANITIZE_SPECIAL_CHARS);

  // 2. Se houver um status na URL, monta o alerta
  if ($status):
    $mensagem = "";
    $classe = "alert-info"; // Cor padrão (Azul)
  
    switch ($status) {
      case 'sucesso':
        $mensagem = "Operação realizada com sucesso!";
        $classe = "alert-success"; // Verde
        break;
      case 'erro':
        $mensagem = "Ocorreu um erro ao processar os dados.";
        $classe = "alert-danger"; // Vermelho
        break;
    }
    ?>
    <div id="msgAlerta" class="alert <?= $classe ?> alert-dismissible fade show" role="alert">
      <?= $mensagem ?>
      <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>

  <?php endif; ?>
  <main class="container">
    <div class="mt-5 d-flex justify-content-between p-5">
      <h3>Alunos</h3>
      <a href="ger-aluno.php" class="btn btn-success">Novo Aluno</a>
    </div>

    <div class="mb-3 d-flex gap-2 justify-content-center">
      <div class="col-md-6">
        <input type="text" name="campo-filtro" id="campo-filtro" class="form-control"
          placeholder="🔍 Digite para pesquisar" title="Pesquise pelo nome do aluno">
      </div>
    </div>

    <table class="table p-3" id="tabela-alunos">
      <thead>
        <tr>
          <th class="text-center">#</th>
          <th>Nome</th>
          <th>Celular</th>
          <th>E-mail</th>
          <th class="text-center">Ações</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($alunos as $alu): ?>
          <tr>
            <td><?php echo $alu->idaluno ?></td>
            <td><?php echo $alu->nome ?></td>
            <td><?php echo $alu->celular ?></td>
            <td></td>
            <td class="d-flex gap-1 justify-content-center">
              <a href="#" class="btn btn-outline-info btn-sm">
                <i class="bi bi-eye"></i>
              </a>
              <a href="ger-aluno.php?id=<?= $alu->idaluno ?>" class="btn btn-outline-primary btn-sm">
                <i class="bi bi-pencil-square"></i>
              </a>
              <form action="db-aluno.php" method="post">
                <input type="hidden" name="id" value="<?= $alu->idaluno ?? null ?>">
                <button type="submit" class="btn btn-sm btn-outline-danger"
                  onclick="confirm('Deseja excluir o registro?')" name="btn-deletar">
                  <i class="bi bi-trash"></i>
                </button>
              </form>
            </td>
          </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
    <div class="alert alert-info d-flex justify-content-center d-none" id="msg-vazio">
      <i class="bi bi-info-circle mx-2"></i> Nenhum aluno encontrado para o filtro digitado.
    </div>

  </main>



  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

  <script src="js/tb-interativa.js"></script>
  <script src="js/alunos.js"></script>
  <script src="js/utils.js"></script>

</body>

</html>