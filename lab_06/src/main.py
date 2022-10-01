from faker import Faker
import psycopg2
import config

SQL_DIR = "./sql/"


class DataBase:
    def __init__(self):
        try:
            self.__connection = psycopg2.connect(host = config.DB_HOST, user = config.DB_USER, password = config.DB_PWD, database = config.DB_PWD)

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


    def execute_query(self, file):
        try:
            f = open(file, "r")

            print("\n\n", f.readline(), "\n", f.readline()) # информация по запросу
            str_execute = f.read()

            self.__cursor.execute(str_execute)
            selection = self.__cursor.fetchall()

            print_result(selection)

        except Exception as error:
            print("\nError ocured while executing. Exception: ", error)

    def execute_procedure(self, file):
        try:
            f = open(file, "r")

            print("\n\n", f.readline(), "\n", f.readline()) # информация по запросу
            str_execute = f.read()

            last_notice = len(self.__connection.notices) # отделить предыдущие ненужные сообщения

            self.__cursor.execute(str_execute)

            print("\n")

            for notice in self.__connection.notices[last_notice:]: # получить список сообщений
                print(notice)

            print("\n\nSuccess")
        except Exception as error:
            print("\nError ocured while executing. Exception: ", error)
    
    def query_scalar(self):
        self.execute_query(SQL_DIR + "1_query_scalar.sql")

    def query_multi_join(self):
        self.execute_query(SQL_DIR + "2_query_multi_join.sql")

    def query_window_cte(self):
        self.execute_query(SQL_DIR + "3_query_window.sql")

    def query_meta(self):
        self.execute_query(SQL_DIR + "4_query_meta.sql")

    def func_scalar(self):
        self.execute_query(SQL_DIR + "5_func_scalar.sql")

    def func_table(self):
        self.execute_query(SQL_DIR + "6_func_table.sql")

    def procedure(self):
        self.execute_procedure(SQL_DIR + "7_procedure.sql")

    def func_system(self):
        self.execute_query(SQL_DIR + "8_func_system.sql")

    def create_new_table(self):
        self.execute_procedure(SQL_DIR + "9_create_table.sql")

    def insert_new_table(self):
        self.execute_query(SQL_DIR + "10_insert_new_table.sql")

    def insert_server(self):
        faker = Faker()

        name = input("\nВведите название сервера: ")
        owner = input("\nВведите никнейм создателя сервера: ")
        max_players = input("\nВведите макс кол-во игроков: ")
        version = input("\nВведите версию: ")

        ip = faker.unique.ipv4()
        create_date = faker.date_between(start_date = '-10y', end_date = 'today')

        str_query = """
                insert into server_copy(name, owner, ip, max_players, version, create_date) values
                ('""" + name + """', '""" + owner + """', '""" + str(ip) + """', '""" + str(max_players) + """', '""" + str(version) + """', '""" + str(create_date) + """');

                select *
                from server_copy
                    """

        self.__cursor.execute(str_query)
        selection = self.__cursor.fetchall()

        print_result(selection)

        print("Success")


def print_result(result):
    print("\n")
    
    for i in range(len(result)):
        for j in range (len(result[0])):
            print(result[i][j], "   ", end = "") 
        print("\n")
    print("\n\n")


def print_menu():
    print("\n\n\t1. Выполнить скалярный запрос \
             \n\t2. Выполнить запрос с несколькими соединениями (JOIN) \
             \n\t3. Выполнить запрос с ОТВ(CTE) и оконными функциями \
             \n\t4. Выполнить запрос к метаданным \
             \n\t5. Вызвать скалярную функцию \
             \n\t6. Вызвать многооператорную табличную функцию \
             \n\t7. Вызвать хранимую процедуру \
             \n\t8. Вызвать системную функцию \
             \n\t9. Создать таблицу в базе данных, соответствующую тематике БД \
             \n\t10. Выполнить вставку данных в созданную таблицу с использованием инструкции INSERT \
             \n\t11. Защита: Добавить запись в сервер с вводом \
           \n\n\t0. Выход\n\n")


def main():
    database = DataBase()

    option = -1

    while (option != 0):
        print_menu()

        try:
            option = int(input("Выберите пункт меню: "))
        except:
            print("\nПовторите ввод\n")
            continue

        if (option == 1):
            database.query_scalar()
        elif (option == 2):
            database.query_multi_join()
        elif (option == 3):
            database.query_window_cte()
        elif (option == 4):
            database.query_meta()
        elif (option == 5):
            database.func_scalar()
        elif (option == 6):
            database.func_table()
        elif (option == 7):
            database.procedure()
        elif (option == 8):
            database.func_system()
        elif (option == 9):
            database.create_new_table()
        elif (option == 10):
            database.insert_new_table()
        elif (option == 11):
            database.insert_server()
        else:
            print("\nПовторите ввод\n")


if __name__ == "__main__":
    main()
