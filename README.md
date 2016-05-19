# Druid cluster

## Estrutura escalável do  Druid


O que é o Druid?

O druid é uma composição dos seguintes componentes:

- [Historical](http://druid.io/docs/latest/design/historical.html) Os nós são os burros de carga que lidam com o armazenamento e consulta de dados "históricos" (non-realtime). Historical nodes baixa segmentos de armazenagem "deep storage", e responde ao broker respondendo pelos segmentos, e retornar resultados para os gânglios corretor. Eles anunciam-se e os segmentos que estão servindo em Zookeeper, e também usa Zookeeper para monitorar sinais para carregar ou descartar novos segmentos.
- [Broker](http://druid.io/docs/latest/design/broker.html) Os nós recebem consultas de clientes externos e encaminhar essas consultas para Realtime e nós históricos. Quando o Broker receber os resultados, eles se fundem e devolve ao chamador. Para saber topologia, os nós "Broker" usam Zookeeper para determinar o que existe em tempo real e nós históricos.
- [Serviço de indexação (Overlord)](http://druid.io/docs/latest/design/indexing-service.html) nós de um grupo de workers para carregar dados em lote e em tempo real no sistema, bem como permitir alterações aos os dados armazenados no sistema.
- [Realtime](http://druid.io/docs/latest/design/realtime.html) nós em tempo real também carregar dados em tempo real para o sistema. Eles são mais simples de configurar do que o serviço de indexação, ao custo de várias limitações para uso em produção.



![flow-part-1](http://druid.io/docs/img/druid-dataflow-3.png)

![flow-part-2](http://druid.io/docs/img/druid-manage-1.png)


Como gerenciar memória do Druid

- [Gerenciando memória do Druid](http://druid.io/docs/latest/operations/performance-faq.html)


Como baixar e usar

```sh
docker compose up
```

Espere um pouco que estará habilitado os serviços


- Lista de datasources (irá começar vazio)

```
curl http://localhost:3000/druid/v2/datasources
```

- coordinator console

```
open http://localhost:3001/
```


Cada pasta contém a imagem em caso de necessidade de personalização.