class TabelaInterativa{
    #config;
    #tabela;
    #corpoTabela;
    #campoFiltro;
    #msgVazio;

    constructor(config){
        this.#config = config;
    }

    iniciar(){
        this.#tabela = document.getElementById(this.#config.tabelaId);
        this.#campoFiltro = document.getElementById(this.#config.filtroId);
        this.#corpoTabela = this.#tabela.querySelector('tbody');
        this.#msgVazio = document.getElementById(this.#config.msgVazioId);

        this.#campoFiltro.addEventListener('input',()=>{
            this.#filtrar();
        });
    }

    #filtrar(){
        const termo = this.#campoFiltro.value.toLowerCase();
        const linhas = this.#corpoTabela.querySelectorAll('tr');

        linhas.forEach((linha)=>{
            let texto = linha.textContent.toLowerCase();
            if(texto.includes(termo)){
                linha.classList.remove('d-none');
            }else{
                linha.classList.add('d-none');
            }
        });

        const visiveis = this.#corpoTabela.querySelectorAll('tr:not(.d-none)');
        this.#msgVazio.classList.toggle('d-none',visiveis.length>0);
    }
}