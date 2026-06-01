document.addEventListener('DOMContentLoaded', () => {
    // Seleção dos elementos principais da nossa interface
    const form = document.querySelector('form');
    const campoCep = document.querySelector('#cep');
    const senha = document.querySelector('#senha');
    const confirma = document.querySelector('#confirma_senha');
    const btnSalvar = document.querySelector('button[name="btnGravar"]');

    // 1. MÁSCARA DINÂMICA: Aplica formatação automática baseada no HTML
    document.querySelectorAll('[data-mascara]').forEach(input => {
        input.addEventListener('input', (e) => {
            const padrao = e.target.dataset.mascara;
            let valor = e.target.value.replace(/\D/g, '');
            let res = "", idx = 0;
            for (let i = 0; i < padrao.length && idx < valor.length; i++) {
                res += padrao[i] === '0' ? valor[idx++] : padrao[i];
            }
            e.target.value = res;
        });
    });

    // 2. BUSCA DE CEP: Consulta a API ViaCEP quando o campo perde o foco
    campoCep.addEventListener('blur', async () => {
        let cep = campoCep.value.replace(/\D/g, '');
        if (cep.length !== 8) return;

        const res = await fetch(`https://viacep.com.br/ws/${cep}/json/`);
        const dados = await res.json();
        if (!dados.erro) {
            document.querySelector('#logradouro').value = dados.logradouro;
            document.querySelector('#bairro').value = dados.bairro;
            document.querySelector('#cidade').value = dados.localidade;
            document.querySelector('#estado').value = dados.uf;
        }
    });

    // 3. VALIDAÇÃO DE SENHA: Garante que as senhas coincidem e não estão vazias
    const validar = () => {
        const erro = senha.value === "" || senha.value !== confirma.value;
        confirma.style.borderColor = erro ? 'red' : 'green';
        btnSalvar.disabled = erro;
    };
    senha.addEventListener('input', validar);
    confirma.addEventListener('input', validar);

    // 4. VALIDAÇÃO BOOTSTRAP: O "juiz" final antes do envio ao banco
    form.addEventListener('submit', (e) => {
        if (!form.checkValidity()) {
            e.preventDefault();
            form.classList.add('was-validated');
        }
    });
});