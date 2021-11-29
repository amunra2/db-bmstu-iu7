-- Определяемая пользователем скалярная функция CLR
-- Подходит ли мир игроку, который хочет играть в режиме
-- креатив на плоском мире


-- create extension plpython3u;

create or replace function is_good(type varchar, mode varchar)
returns varchar as
$$
    if (type == "superflat" and mode == "creative"):
        return "Yes"
    else:
        return "No"
$$ language plpython3u;


select name, type, mode, is_good(type, mode)
from World
where mode = 'creative';