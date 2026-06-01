document.addEventListener('DOMContentLoaded',()=>{
    const tabela = new TabelaInterativa({
        tabelaId: 'tabela-exercicios',
        filtroId: 'campo-filtro',
        msgVazioId: 'msg-vazio'
    });
    tabela.iniciar();
});