# BR ARENA — Bot de Discord para partidas competitivas gratuitas

Projeto pré-final (v0.9) inspirado na estrutura visual mostrada pelo usuário: canais de verificação, filas por modo e formato, ranking, staff e suporte. **Não há carteira em dinheiro, depósito, apostas, saque ou pagamento por vitória.** Os pontos do ranking não têm valor financeiro.

## O que já está implementado

- Instalação automatizada de categorias, canais e cargos com `/instalar` (idempotente para canais e cargos; mensagens dos painéis podem ser republicadas).
- Painel com botões Realistic, Box Fight e Zone Wars, cada um com 1v1, 2v2, 3v3 e 4v4.
- Cargo Competidor por botão no canal de verificação (somente verificação interna do Discord).
- Criação de equipe e convite de amigos com botão Aceitar/Recusar (convite expira em 10 minutos).
- Fila só para equipe completa e capitão verificado; pareamento automático por modo e tamanho.
- Confirmação dos dois capitães com prazo de 5 minutos; quem confirmar é recolocado na fila se o outro não confirmar.
- Canais temporários privados de texto e voz para os participantes da partida e staff.
- Registro de resultados por ambos os capitães, arbitragem para divergências, ranking por pontos virtuais (+10 vitória / +2 derrota).
- Tickets privados de suporte com abertura por botão e encerramento com `/fecharticket`.
- Armazenamento local em `data/state.json`, com gravação atômica. Salas são removidas 24 horas após a partida terminar.

## Requisitos

- Windows 10/11 com Node.js 20 ou superior instalado.
- Um servidor Discord em que você tenha a permissão **Gerenciar Servidor**.
- Uma aplicação com bot criada por você no [Discord Developer Portal](https://discord.com/developers/applications).

## Instalar no Windows

1. Extraia este ZIP em uma pasta no computador.
2. No portal oficial do Discord, crie uma **Application** e habilite o bot.
3. Na seção **Installation**, configure a instalação para o servidor (`Guild Install`) com os escopos `bot` e `applications.commands`.
4. Configure as permissões do bot: **Gerenciar Canais**, **Gerenciar Cargos**, **Ver Canais**, **Enviar Mensagens**, **Inserir Links**, **Ler Histórico de Mensagens** e **Conectar**. O cargo do bot deve estar acima de **Competidor**, **Moderador** e **Árbitro** para gerenciar esses cargos. Nunca compartilhe o token do bot.
5. Convide o bot para seu próprio servidor usando o fluxo de instalação do portal do Discord.
6. Copie `.env.example` e renomeie a cópia para `.env`.
7. Preencha:
   - `DISCORD_TOKEN`: token secreto do seu bot.
   - `CLIENT_ID`: ID da Application.
   - `GUILD_ID`: ID do servidor Discord (ative o modo desenvolvedor nas configurações do Discord para copiar o ID do servidor).
8. Abra `instalar-e-iniciar.bat` no Windows, ou abra um terminal nessa pasta e rode `npm install` e depois `npm start`.
9. No Discord, use `/instalar` **uma vez** para criar as categorias, cargos e painéis. Use `/painel` para republicar o seletor de modos quando precisar.
10. Mantenha o processo do bot em execução enquanto o servidor estiver em uso. Para operação contínua, use uma hospedagem autorizada; este ZIP não inclui hospedagem.

## Comandos disponíveis

| Comando | Quem usa | O que faz |
| --- | --- | --- |
| `/instalar` | Administrador | Cria canais, categorias, cargos e mensagens iniciais |
| `/painel` | Administrador | Publica painel de seleção de modo |
| `/equipe criar` | Competidor | Escolhe modo e tamanho |
| `/equipe convidar` | Capitão | Menciona o amigo, que confirma por botão |
| `/equipe status` | Jogador | Consulta a equipe |
| `/equipe sair` | Jogador | Sai ou encerra equipe fora da partida |
| `/fila entrar` | Capitão | Coloca equipe completa na fila |
| `/fila sair` | Capitão | Remove a equipe da fila |
| `/fila status` | Jogador | Mostra quantas equipes aguardam em cada formato |
| `/placar` | Capitão | Envia vencedor A ou B |
| `/arbitrar` | Staff | Resolve divergência de resultado |
| `/ranking` | Todos | Mostra os dez melhores jogadores |
| `/fecharticket` | Autor ou staff | Fecha atendimento privado |

## Exemplo: 2v2 Realistic

- Capitão A usa o painel e escolhe Realistic → 2v2.
- A usa `/equipe convidar` e marca o Discord do parceiro.
- O amigo aceita o convite no canal de convites.
- A usa `/fila entrar`.
- Outro capitão B forma uma dupla e entra na mesma fila.
- O bot encontra os dois times e pede confirmação aos dois capitães.
- Após as confirmações, o bot abre `partida-N` e duas salas de voz privadas.
- Cada capitão usa `/placar` declarando quem venceu. Se concordarem, o bot registra o resultado; se discordarem, abre uma divergência para arbitragem.

## Administração e segurança

- A área de staff é privada; os canais temporários só deixam entrar jogadores da partida e staff.
- O bot não precisa de **Message Content Intent**; usa comandos e interações.
- `data/state.json` contém os IDs e resultados do servidor: faça backup periódico e não divulgue.
- Salve o `.env` somente na máquina/host do bot. **Nunca publique o token secreto** em prints, repositórios ou no Discord.
- Como protótipo, usa armazenamento JSON em processo único. Para muitos usuários, uma versão de produção deve usar banco SQL, monitoramento, controle de concorrência e testes end-to-end.
- A verificação interna **não** integra autenticação da Epic Games; vincular a conta Epic requer um fluxo de autenticação oficial separado.
- Não há sistema de revanche automática, desempate em série, anticheat, integração com partidas do Fortnite ou site externo nesta versão.

## Limites e estado do projeto

O código foi verificado quanto à **sintaxe JavaScript**, mas não foi testado em um servidor Discord real porque requer suas próprias credenciais e permissões. O programa é um protótipo instalável para partidas gratuitas, e não uma plataforma financeira.
