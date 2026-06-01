<!DOCTYPE html>
<html lang="pt-br">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
  <title>Dashboard | PersonalPRO</title>
</head>

<body>
  <?php 
  require_once "_parts/_menu.php"; 
  $grupoMuscular = [
    "Abdômen",
    "Antebraço",
    "Bíceps",
    "Costas",
    "Glúteo",
    "Panturrilha",
    "Peito",
    "Tríceps"
  ];

  $id=null;
  if(filter_has_var(INPUT_GET,"id")) {
    spl_autoload_register(function ($class) {
      require_once "class/{$class}.class.php";
    });
    $edtexec = new Exercicio();
    $id = intval(filter_input(INPUT_GET,"id"));
    $exercicio = $edtexec->search('idexercicio', $id);
  }
  ?>
  <main class="container" style="margin-top: 80px;">
    <div class="mt-5">
        <h4>Cadastro de exercício</h4>
    </div>
    <div class="card">
      <form action="db-exercicio.php" method="post" class="row p-4 g3 mt-3">
        <input type="hidden" name="id" value="<?= $exercicio->idexercicio ?? null; ?>">
        <div class="col-12">
          <label for="nome" class="form-label">Nome</label>
          <input type="text" name="nome" id="nome" class="form-control" value="<?= $exercicio->nome ?? null; ?>">
        </div>
        <div class="col-12">
          <label for="descricao" class="form-label">Descrição</label>
          <textarea name="descricao" id="descricao" class="form-control"><?= $exercicio->descricao ?? null; ?></textarea>
        </div>
        <div class="col-md-6">
          <label for="grupoMuscular" class="form-label">Grupo Muscular</label>
          <?php
             $grupo_sel = $exercicio->grupo_muscular ?? null;
          ?>
          <select name="grupoMuscular" id="grupoMuscular" class="form-select">
            <option value="">Selecione...</option>
            <?php foreach( $grupoMuscular as $grupo ) : ?>
            <option value="<?= $grupo ?>" 
            <?php if($grupo == $grupo_sel) echo 'selected' ?>
            >
              <?= $grupo ?>
            </option>
            <?php endforeach; ?>
          </select>
        </div>

        <div class="mt-3">
          <a href="gmuscular.php" class="btn btn-secondary" >Cancelar</a>
          <button type="submit" class="btn btn-primary" name="btnGravar">Salvar</button>
        </div>
      </form>
    </div>

  </main>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>