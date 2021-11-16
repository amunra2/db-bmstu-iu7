from faker import Faker
from random import choice, randint

import psycopg2


SERVER_FILE = "server_info.csv"
PLAYER_FILE = "player_info.csv"
WORLD_FILE = "world_info.csv"
WEBSITE_FILE = "website_info.csv"

CREATE_SQL = "create_tables.sql"
DROP_SQL = "drop_tables.sql"
COPY_SQL = "copy_tables.sql"
LIMITATIONS_SQL = "limitations.sql"

AMOUNT = 1000

WORLD_MODE = ["survival", "creative", "hardcore", "spectator", "adventure"]
WORLD_TYPE = ["default", "superflat", "single biome", "large biomes", "caves"]
PLAYER_STATUS = ["player", "owner", "premiuim", "moder", "vip"]



class DataBase:
    
    def __init__(self):

        try:
            self.__connection = psycopg2.connect(host = 'localhost', user = 'postgres', password = 'postgres', database = 'db_labs')

            self.__connection.autocommit = True
            self.__cursor = self.__connection.cursor()

            print("\nPostgreSQL: Connection opened\n")

        except Exception as error:
            print("\nError ocured while init. Exception: ", error)

    def __del__(self):

        if self.__connection:
            self.__cursor.close()
            self.__connection.close()

            print("\nPostgreSQL: Connection closed\n")

    def create_tables(self):
        try:
            f = open(CREATE_SQL, "r")
            str_execute = f.read()
            self.__cursor.execute(str_execute)

            f = open(LIMITATIONS_SQL, "r")
            str_execute = f.read()
            self.__cursor.execute(str_execute)

            print("\nSuccess: Tables are created\n")

        except Exception as error:
            print("\nError ocured while create. Exception: ", error)


    def drop_tables(self):
        try:
            f = open(DROP_SQL, "r")
            str_execute = f.read()

            self.__cursor.execute(str_execute)

            print("\nSuccess: Tables are dropped\n")

        except Exception as error:
            print("\nError ocured while delete. Exception: ", error)


    def copy_data(self):
        f = open(COPY_SQL, "r")
        str_execute = f.read()

        self.__cursor.execute(str_execute)


def generate_website_info():

    f = open(WEBSITE_FILE, "w")

    faker = Faker()

    players_list = [i for i in range(1, AMOUNT + 1)]
    servers_list = [i for i in range(1, AMOUNT + 1)]
    worlds_list = [i for i in range(1, AMOUNT + 1)]

    for i in range(0, AMOUNT):
        player_id = choice(players_list)
        players_list.remove(player_id)

        world_id = choice(worlds_list)
        worlds_list.remove(world_id)

        server_id = choice(servers_list)
        servers_list.remove(server_id)

        # url = faker.url()
        hours = randint(0, 100)

        line = "{0};{1};{2};{3}\n".format(player_id, world_id, server_id, hours)

        f.write(line)

    print("Website information created")

    f.close() 


def genereate_player_info():

    f = open(PLAYER_FILE, "w")

    faker = Faker()

    friends_list = [i for i in range(1, AMOUNT + 1)]

    for i in range(0, AMOUNT):
        nickname = faker.unique.user_name()
        password = faker.password()
        status = choice(PLAYER_STATUS)
        hours_all = randint(0, 100)
        email = faker.unique.ascii_email()
        is_admin = faker.boolean(chance_of_getting_true = 50)

        friend_id = i + 1

        while (friend_id == i + 1):
            friend_id = choice(friends_list)
 
        friends_list.remove(friend_id)

        line = "{0};{1};{2};{3};{4};{5};{6}\n".format(nickname, password, status, hours_all, email, is_admin, friend_id)

        f.write(line)

    print("Player information created")

    f.close() 


def genereate_server_info():

    f = open(SERVER_FILE, "w")

    faker = Faker()

    for i in range(0, AMOUNT):
        server_name = faker.company() # better choise?
        owner_nickname = faker.unique.user_name()
        ip = faker.unique.ipv4()
        num = randint(10, 1000)
        max_players = num - (num % 10)
        version = faker.bothify(text = "1.1#.#")
        create_date = faker.date_between(start_date = '-10y', end_date = 'today')

        line = "{0};{1};{2};{3};{4};{5}\n".format(server_name, owner_nickname, ip, max_players, version, create_date)

        f.write(line)

    print("Server information created")

    f.close()


def genereate_world_info():

    f = open(WORLD_FILE, "w")

    faker = Faker()

    for i in range(0, AMOUNT):
        name_str = choice(faker.paragraph(nb_sentences = 1).split())
        name = name_str if name_str[-1] != '.' else name_str[:-1]
        world_type = choice(WORLD_TYPE)
        mode = choice(WORLD_MODE)
        seed = faker.unique.random_number(digits = 15)
        cheats_allowed = faker.boolean(chance_of_getting_true = 50)

        line = "{0};{1};{2};{3};{4}\n".format(name, world_type, mode, seed, cheats_allowed)

        f.write(line)

    print("World information created")

    f.close()



def main():
    # test_faker()

    database = DataBase()

    database.drop_tables()
    database.create_tables()

    genereate_world_info()
    genereate_server_info()
    genereate_player_info()
    generate_website_info()

    database.copy_data()




if __name__ == "__main__":
    main()