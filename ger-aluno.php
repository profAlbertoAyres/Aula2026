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
  $estados = [
    'AC' => 'Acre',
    'AL' => 'Alagoas',
    'AP' => 'Amapá',
    'AM' => 'Amazonas',
    'BA' => 'Bahia',
    'CE' => 'Ceará',
    'DF' => 'Distrito Federal',
    'ES' => 'Espirito Santo',
    'GO' => 'Goiás',
    'MA' => 'Maranhão',
    'MS' => 'Mato Grosso do Sul',
    'MT' => 'Mato Grosso',
    'MG' => 'Minas Gerais',
    'PA' => 'Pará',
    'PB' => 'Paraíba',
    'PR' => 'Paraná',
    'PE' => 'Pernambuco',
    'PI' => 'Piauí',
    'RJ' => 'Rio de Janeiro',
    'RN' => 'Rio Grande do Norte',
    'RS' => 'Rio Grande do Sul',
    'RO' => 'Rondônia',
    'RR' => 'Roraima',
    'SC' => 'Santa Catarina',
    'SP' => 'São Paulo',
    'SE' => 'Sergipe',
    'TO' => 'Tocantins',
  ];

  $sexos = [
    'F' => 'Feminino',
    'M' => 'Masculino'
  ];
  $id = null;
  if (filter_has_var(INPUT_GET, "id")) {
    spl_autoload_register(function ($class) {
      require_once "class/{$class}.cl ass.php";
    });
    $edtAlu = new Aluno();
    $id = intval(filter_input(INPUT_GET, "id"));
    $aluno = $edtAlu->search('idaluno', $id);
  }
  ?>
  <main class="container" style="margin-top: 80px;">
    <div class="mt-5">
      <h4>Cadastro de Aluno</h4>
    </div>
      <form action="db-aluno.php" method="post">
        <input type="hidden" name="id" value="<?= $aluno->idaluno ?? null; ?>">
        <fieldset class="border p-3 mb-3">
          <legend class="w-auto px-2 h6">Dados de Acesso</legend>
          <div class="row">
            <div class="col-md-5">
              <label for="email" class="form-label">E-mail</label>
              <input type="email" name="email" id="email" class="form-control" placeholder="exemplo@email.com">
            </div>
            <div class="col-md-3">
              <label for="username" class="form-label">Usuário</label>
              <input type="text" name="username" id="username" class="form-control">
            </div>
            <div class="col-md-2">
              <label for="senha" class="form-label">Senha</label>
              <input type="password" name="senha" id="senha" class="form-control">
            </div>
            <div class="col-md-2">
              <label for="confirma_senha" class="form-label">Confirmar Senha</label>
              <input type="password" name="confirma_senha" id="confirma_senha" class="form-control" required>
            </div>
          </div>
        </fieldset>
        <fieldset class="border p-3 mb-3">
          <legend class="w-auto px-2 h6">Dados do Aluno</legend>
          <div class="row">

            <div class="col-12">
              <label for="nome" class="form-label">Nome</label>
              <input type="text" name="nome" id="nome" class="form-control" value="<?= $aluno->nome ?? null; ?>">
            </div>
            <div class="col-md-4">
              <label for="sexo" class="form-label">Sexo</label>
              <?php
              $sexo_sel = $aluno->sexo ?? null;
              ?>
              <select name="sexo" id="sexo" class="form-select">
                <option value="">Selecione...</option>
                <?php foreach ($sexos as $sigla => $nome): ?>
                  <option value="<?= $sigla ?>" <?php if ($sigla == $sexo_sel)
                      echo 'selected' ?>>
                    <?= $nome ?>
                  </option>
                <?php endforeach; ?>
              </select>
            </div>
            <div class="col-md-4">
              <label for="nascimento" class="form-label">Nascimento</label>
              <input type="date" name="nascimento" id="nascimento" class="form-control"
                value="<?= $aluno->nascimento ?? null; ?>">
            </div>
            <div class="col-md-4">
              <label for="celular" class="form-label">Celular</label>
              <input type="text" name="celular" id="celular" class="form-control"
                value="<?= $aluno->celular ?? null; ?>">
            </div>
            <div class="col-md-3">
              <label for="cep" class="form-label">Cep</label>
              <input type="text" name="cep" id="cep" class="form-control" value="<?= $aluno->cep ?? null; ?>" data-mascara="00000-000">
            </div>
            <div class="col-md-9">
              <label for="logradouro" class="form-label">Logradouro</label>
              <input type="text" name="logradouro" id="logradouro" class="form-control"
                value="<?= $aluno->cep ?? null; ?>">
            </div>
            <div class="col-md-5">
              <label for="bairro" class="form-label">Bairro</label>
              <input type="text" name="bairro" id="bairro" class="form-control" value="<?= $aluno->bairro ?? null; ?>">
            </div>
            <div class="col-md-5">
              <label for="cidade" class="form-label">Cidade</label>
              <input type="text" name="cidade" id="cidade" class="form-control" value="<?= $aluno->cidade ?? null; ?>">
            </div>

            <div class="col-md-2">
              <label for="estado" class="form-label">Estado</label>
              <?php
              $estado_sel = $aluno->estado ?? null;
              ?>
              <select name="estado" id="estado" class="form-select">
                <option value="">Selecione...</option>
                <?php foreach ($estados as $sigla => $nome): ?>
                  <option value="<?= $sigla ?>" <?php if ($sigla == $estado_sel)
                      echo 'selected' ?>>
                    <?= $nome ?>
                  </option>
                <?php endforeach; ?>
              </select>
            </div>
            <div class="col-12">
              <label for="objetivo" class="form-label">Objetivo</label>
              <textarea name="objetivo" id="objetivo" class="form-control"><?= $aluno->objetivo ?? null; ?></textarea>
            </div>
          </div>
        </fieldset>

        <div class="mt-3 p-3">
          <a href="alunos.php" class="btn btn-secondary">Cancelar</a>
          <button type="submit" class="btn btn-primary" name="btnGravar">Salvar</button>
        </div>
      </form>

  </main>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
  <script src="js/utils.js"></script>
</body>

</html>