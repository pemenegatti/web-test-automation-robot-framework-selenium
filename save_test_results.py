import os
import xml.etree.ElementTree as ET
import psycopg2


def process_robot_report(xml_file: str) -> list[tuple]:
    """Lê o output.xml do Robot Framework e retorna os resultados dos testes."""
    tree = ET.parse(xml_file)
    root = tree.getroot()

    test_results = []
    for suite in root.findall(".//suite"):
        suite_name = suite.get("name")
        for test in suite.findall(".//test"):
            test_name = test.get("name")
            status_el = test.find("status")
            status = status_el.get("status")
            start_time = status_el.get("starttime")
            end_time = status_el.get("endtime")
            test_results.append((suite_name, test_name, status, start_time, end_time))

    return test_results


def insert_test_results(test_results: list[tuple]) -> None:
    """Insere os resultados dos testes no banco de dados PostgreSQL."""
    conn = psycopg2.connect(
        dbname=os.environ["DB_NAME"],
        user=os.environ["DB_USER"],
        password=os.environ["DB_PASSWORD"],
        host=os.environ["DB_HOST"],
        port=os.environ["DB_PORT"],
    )

    try:
        cursor = conn.cursor()
        insert_query = """
            INSERT INTO robot_report_pesoal (suite_name, test_name, status, start_time, end_time)
            VALUES (%s, %s, %s, %s, %s)
        """
        cursor.executemany(insert_query, test_results)
        conn.commit()
        print(f"{len(test_results)} resultado(s) inserido(s) com sucesso.")
    except Exception as e:
        conn.rollback()
        raise e
    finally:
        cursor.close()
        conn.close()


if __name__ == "__main__":
    report_file = "./tests/results/output.xml"
    results = process_robot_report(report_file)
    insert_test_results(results)
