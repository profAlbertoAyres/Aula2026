document.addEventListener('DOMContentLoaded',()=>{
    const tabela = new TabelaInterativa({
        tabelaId: 'tabela-alunos',
        filtroId: 'campo-filtro',
        msgVazioId: 'msg-vazio'
    });
    tabela.iniciar();
});