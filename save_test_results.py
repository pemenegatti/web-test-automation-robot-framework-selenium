import os
import xml.etree.ElementTree as ET
import psycopg2

def process_robot_report(xml_file):
    tree = ET.parse(xml_file)
    root = tree.getroot()
    
    test_results = []
    for suite in root.findall(".//suite"):
        suite_name = suite.get('name')
        for test in suite.findall(".//test"):
            test_name = test.get('name')
            status = test.find('status').get('status')
            start_time = test.find('status').get('starttime')
            end_time = test.find('status').get('endtime')
            test_results.append((suite_name, test_name, status, start_time, end_time))
    
    return test_results

def insert_test_results(test_results):
    conn = psycopg2.connect(
        dbname=os.getenv('DB_NAME'),
        user=os.getenv('DB_USER'),
        password=os.getenv('DB_PASSWORD'),
        host=os.getenv('DB_HOST'),
        port=os.getenv('DB_PORT')
    )
    
    cursor = conn.cursor()
    
    insert_query = """
    INSERT INTO robot_report_pesoal (suite_name, test_name, status, start_time, end_time)
    VALUES (%s, %s, %s, %s, %s)
    """
    
    for result in test_results:
        cursor.execute(insert_query, result)
    
    conn.commit()
    cursor.close()
    conn.close()

# Process and insert the report data
report_file = './tests/results/output.xml'
test_results = process_robot_report(report_file)
insert_test_results(test_results)
