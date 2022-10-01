-- Извлечь данные в json
-- psql -h localhost postgres -d db_labs

\t -- формат вывода: unaligned
\a -- режим вывода только кортежей: включён

\o data\world.json -- перенаправление вывода
select row_to_json(W) from World as W;

\o data\player.json
select row_to_json(P) from Player as P;

\o data\server.json
select row_to_json(S) from Server as S;

\o data\website.json
select row_to_json(W) from Website as W;