from peewee import *
import datetime as dt



connect = PostgresqlDatabase(
    database="rk3_prep",
    user="postgres",
    password="postgres",
    host="127.0.0.1",
    port=5432
)


class BaseModel(Model):
    class Meta:
        database = connect


class Employes(BaseModel):
    id = IntegerField(column_name='id')
    fio = CharField(column_name='fio')
    birthdate = DateField(column_name='birth_date')
    department = CharField(column_name='department')

    class Meta:
        table_name = 'employes'


class EmplActions(BaseModel):
    e_id = ForeignKeyField(Employes, backref="e_id", on_delete="cascade")
    date_pass = DateField(column_name='date_pass')
    weekday = CharField(column_name='weekday')
    time_pass = TimeField(column_name='time_pass')
    inout = IntegerField(column_name='inout')

    class Meta:
        table_name = 'emplactions'


# Найти все отделы, в которых работает более 10 сотрудников
def task1():

    # SQL part
    query_res = connect.execute_sql(" \
        select department \
        from Employes \
        group by department \
        having count(*) > 10 \
        ")

    for res in query_res.fetchall():
        print(res)

    print("\n\n---------------------------------\n")

    # Python part
    query = Employes.select(Employes.department).\
        group_by(Employes.department).having(fn.count(Employes.id) > 10)

    for res in query.dicts():
        print(res)


# Найти сотрудников, которые не выходят с рабочего места в течение всего рабочего дня
def task2():

    # SQL part
    query_res = connect.execute_sql(" \
        select FIO \
        from Employes \
        where id not in( \
            select e_id \
            from ( \
                select e_id, date_pass, inout, count(*) \
                from EmplActions \
		        where time_pass < '18:00:00' \
                group by e_id, date_pass, inout \
                having inout=2 and count(*) > 1 \
                ) as tmp); \
        ")

    for res in query_res.fetchall():
        print(res)

    print("\n\n---------------------------------\n")

    # Python part
    in_query = EmplActions\
        .select(EmplActions.e_id, EmplActions.date_pass)\
        .where(EmplActions.inout == 1)\
        .group_by(EmplActions.e_id, EmplActions.date_pass)\
        .having(fn.count(EmplActions.e_id) == 1).alias('in_res')

    out_query = EmplActions.select(EmplActions.e_id, EmplActions.date_pass)\
        .where(EmplActions.inout == 2)\
        .where(EmplActions.time_pass >= '18:00:00')\
        .group_by(EmplActions.e_id, EmplActions.date_pass)\
        .having(fn.count(EmplActions.e_id) == 1).alias('out_res')

    query = Employes.select(Employes.fio).distinct()\
        .join(in_query, on=Employes.id == SQL('in_res.e_id'))\
        .join(out_query, on=Employes.id == SQL('out_res.e_id'))\

    for res in query.dicts():
        print(res)


# Найти все отделы, в которых есть сотрудники, опоздавшие в определенную дату. Дату
# передавать с клавиатуры
def task3():
    date = input("Введите дату (ГГГГ-ММ-ДД): ")

    # SQL part
    query_res = connect.execute_sql(" \
        select distinct department \
        from Employes \
        where id in \
        ( \
            select e_id \
            from \
            ( \
                select e_id, min(time_pass) \
                from EmplActions \
                where inout = 1 and date_pass = '%s' \
                group by e_id \
                having min(time_pass) > '09:00:00' \
            ) as tmp \
        ) \
        " %(date))

    for res in query_res.fetchall():
        print(res)

    print("\n\n---------------------------------\n")

    # Python part
    get_late = EmplActions.select(EmplActions.e_id)\
        .where(EmplActions.inout == 1 and EmplActions.date_pass == date)\
        .group_by(EmplActions.e_id) \
        .having(fn.Min(EmplActions.time_pass) > '09:00:00')
    
    query = Employes.select(Employes.department).distinct()\
        .where(Employes.id.in_(get_late))

    for res in query.dicts():
        print(res)


def main():
    task3()


if __name__ == "__main__":
    main()
    
