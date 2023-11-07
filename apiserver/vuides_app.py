import datetime
import MySQLdb
from flask import Flask, jsonify, make_response, request
import time
import pymysql

app = Flask(__name__)
db = None
# 중복된 아이디인지 확인해줘야해, 아이디 제한길이도 확인해줘야한다.


@app.before_first_request
def initialize_db():
    global db
    db = pymysql.connect(host='project-db-stu3.smhrd.com', user='Insa4_IOTA_final_3',
                         password='aischool3', db='Insa4_IOTA_final_3', charset='utf8', port=3307)


@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    mem_id = data.get('mem_id')
    mem_pw = data.get('mem_pw')

    cursor = db.cursor()
    cursor.execute(
        "SELECT * FROM member WHERE mem_id = %s AND mem_pw = %s", (mem_id, mem_pw))
    user = cursor.fetchone()
    cursor.close()

    if user:
        response = make_response(jsonify({"message": "Login successful"}))
        response.status_code = 200
        return response
    else:
        response = make_response(jsonify({"message": "Login failed"}))
        response.status_code = 401
        return response


@app.route('/kakao_login', methods=['POST'])
def kakao_login():
    data = request.get_json()
    social_id = data.get('social_id')
    social_email = data.get('social_email')
    social_name = data.get('social_name')

    cursor = db.cursor()
    cursor.execute(
        "SELECT * FROM social_login WHERE social_id = %s AND social_email = %s", (social_id, social_email))
    user = cursor.fetchone()

    if user:
        response = make_response(jsonify({"message": "Login successful"}))
        response.status_code = 200
        cursor.close()
        return response
    else:
        try:
            cursor.execute(
                "INSERT INTO social_login (social_id, social_email,social_name) VALUES (%s, %s,%s)", (social_id, social_email,social_name))
            db.commit()  # Commit the INSERT operation to the database
            response = make_response(jsonify({"message": "Login successful"}))
            response.status_code = 200
        except MySQLdb.connector.Error as err:
            response = make_response(
                jsonify({"message": "Login failed due to a database error"}))
            response.status_code = 401

        cursor.close()
        return response

@app.route('/naver_login', methods=['POST'])
def naver_login():
    data = request.get_json()
    social_id = data.get('social_id')
    social_email = data.get('social_email')
    social_phone = data.get('social_phone')
    social_name = data.get('social_name')

    cursor = db.cursor()
    cursor.execute(
        "SELECT * FROM social_login WHERE social_id = %s AND social_email = %s AND social_name =%s", (social_id, social_email, social_name))
    user = cursor.fetchone()

    if user:
        response = make_response(jsonify({"message": "Login successful"}))
        response.status_code = 200
        cursor.close()
        return response
    else:
        try:
            cursor.execute(
                "INSERT INTO social_login (social_id, social_email, social_phone, social_name) VALUES (%s, %s, %s, %s)", (social_id, social_email,social_phone, social_name))
            db.commit()  # Commit the INSERT operation to the database
            response = make_response(jsonify({"message": "Login successful"}))
            response.status_code = 200
        except MySQLdb.connector.Error as err:
            response = make_response(
                jsonify({"message": "Login failed due to a database error"}))
            response.status_code = 401

        cursor.close()
        return response

@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    mem_id = data.get('mem_id')
    mem_pw = data.get('mem_pw')
    mem_name = data.get('mem_name')
    mem_p_number = data.get('mem_p_number')
    mem_email = data.get('mem_email')
    mem_s_date = datetime.datetime.now()

    cursor = db.cursor()
    cursor.execute("SELECT * FROM member WHERE mem_id = %s", (mem_id))
    user = cursor.fetchone()

    if user:
        response = jsonify({"message": "Username already exists"})
        response.status_code = 501  # 400 Bad Request status code
        cursor.close()
        return response

    else:
        # Check username length limit
        if len(mem_id) > 20:  # Replace 20 with your desired limit
            response = jsonify({"message": "Username is too long"})

            response.status_code = 400
            cursor.close()
            return response
        else:

            # Register the new user
            cursor.execute("INSERT INTO member (mem_id, mem_pw, mem_name, mem_p_number, mem_email, mem_s_date) VALUES (%s, %s, %s, %s, %s,%s)", (mem_id,
                                                                                                                                                 mem_pw, mem_name,
                                                                                                                                                 mem_p_number,
                                                                                                                                                 mem_email,
                                                                                                                                                 mem_s_date))
            db.commit()
            response = jsonify({"message": "Registration successful"})
            response.status_code = 200
            cursor.close()
            return response


@app.route('/check_id', methods=['POST'])
def check_duplicate_id():
    data = request.get_json()
    mem_id = data.get('mem_id')

    cursor = db.cursor()
    cursor.execute("SELECT * FROM member WHERE mem_id = %s", (mem_id,))
    existing_user = cursor.fetchone()

    if existing_user:
        response = jsonify({"message": "Username already exists"})
        response.status_code = 400  # 400 Bad Request status code
    else:
        response = jsonify({"message": "Username is available"})
        response.status_code = 200
    cursor.close()
    return response

@app.route('/delete_member', methods=['POST'])
def delete_member():
    data = request.get_json()
    mem_id = data.get('mem_id')

    cursor = db.cursor()

    # 회원 삭제
    cursor.execute("DELETE FROM member WHERE mem_id = %s", (mem_id))
    db.commit()

    cursor.close()

    response = jsonify({"message": "Member deleted successfully"})
    response.status_code = 200
    return response

@app.route('/update_member', methods=['POST'])
def update_member():
    data = request.get_json()
    mem_id = data.get('mem_id')
    mem_pw = data.get('mem_pw')
    mem_name = data.get('mem_name')
    mem_email = data.get('mem_email')
    mem_p_number = data.get('mem_p_number')

    cursor = db.cursor()

    # 이름, 이메일 및 휴대폰 번호 업데이트
    cursor.execute("UPDATE member SET mem_pw = %s, mem_name = %s, mem_email = %s, mem_p_number = %s WHERE mem_id = %s",
                   (mem_pw, mem_name, mem_email, mem_p_number, mem_id))
    db.commit()

    cursor.close()

    response = jsonify({"message": "Profile updated successfully"})
    response.status_code = 200
    return response

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')


@app.teardown_appcontext
def close_db(error):
    global db
    if db:
        db.close()
