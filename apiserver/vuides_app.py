import datetime
import MySQLdb
from flask import Flask, jsonify, make_response, request
from decimal import Decimal
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
    mem_email = data.get('mem_email')
    mem_pw = data.get('mem_pw')

    cursor = db.cursor()
    cursor.execute(
        "SELECT * FROM tbl_member WHERE mem_email = %s AND mem_pw = %s", (mem_email, mem_pw))
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
    mem_email = data.get('mem_email')
    mem_name = data.get('mem_name')

    cursor = db.cursor()
    cursor.execute(
        "SELECT * FROM tbl_member WHERE mem_email = %s AND mem_name = %s", (mem_email, mem_name))
    user = cursor.fetchone()

    if user:
        response = make_response(jsonify({"message": "Login successful"}))
        response.status_code = 200
        cursor.close()
        return response
    else:
        try:
            cursor.execute(
                "INSERT INTO tbl_member (mem_email, mem_name) VALUES (%s,%s)", (mem_email, mem_name))
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
    mem_email = data.get('mem_email')
    mem_name = data.get('mem_name')
    mem_phone = data.get('mem_phone')

    cursor = db.cursor()
    cursor.execute(
        "SELECT * FROM tbl_member WHERE mem_email = %s AND mem_name =%s", (mem_email, mem_name))
    user = cursor.fetchone()

    if user:
        response = make_response(jsonify({"message": "Login successful"}))
        response.status_code = 200
        cursor.close()
        return response
    else:
        try:
            cursor.execute(
                "INSERT INTO tbl_member (mem_email, mem_name, mem_phone) VALUES (%s, %s, %s)", (mem_email, mem_name, mem_phone))
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
    mem_email = data.get('mem_email')
    mem_pw = data.get('mem_pw')
    mem_name = data.get('mem_name')
    mem_phone = data.get('mem_phone')
    joined_at = datetime.datetime.now()
    print(joined_at)
    mem_login_type = data.get('mem_login_type')
    admin_yn = data.get('admin_yn')

    cursor = db.cursor()
    cursor.execute("SELECT * FROM tbl_member WHERE mem_email = %s", (mem_email))
    user = cursor.fetchone()

    if user:
        response = jsonify({"message": "Username already exists"})
        response.status_code = 501  # 400 Bad Request status code
        cursor.close()
        return response

    else:
        # Check username length limit
        if len(mem_email) > 50:  # Replace 50 with your desired limit
            response = jsonify({"message": "Username is too long"})

            response.status_code = 400
            cursor.close()
            return response
        else:
            # 해싱된 비밀번호 생성
            # 패스워드 암호화
            # hashed_pw = generate_password_hash(mem_pw, method='sha256')

            # Register the new user
            cursor.execute("INSERT INTO tbl_member (mem_email, mem_pw, mem_name, mem_phone, joined_at, mem_login_type, admin_yn) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                           (mem_email, mem_pw, mem_name, mem_phone, joined_at, mem_login_type, admin_yn))
            db.commit()
            response = jsonify({"message": "Registration successful"})
            response.status_code = 200
            cursor.close()
            return response


@app.route('/check_id', methods=['POST'])
def check_duplicate_id():
    data = request.get_json()
    mem_email = data.get('mem_email')

    cursor = db.cursor()
    cursor.execute("SELECT * FROM tbl_member WHERE mem_email = %s", (mem_email))
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
    mem_email = data.get('mem_email')

    cursor = db.cursor()

    # 회원 삭제
    cursor.execute("DELETE FROM tbl_member WHERE mem_email = %s", (mem_email))
    db.commit()

    cursor.close()

    response = jsonify({"message": "Member deleted successfully"})
    response.status_code = 200
    return response

@app.route('/update_member', methods=['POST'])
def update_member():
    data = request.get_json()
    mem_email = data.get('mem_email')
    mem_pw = data.get('mem_pw')
    mem_name = data.get('mem_name')
    mem_phone = data.get('mem_phone')

    cursor = db.cursor()

    # 이름, 이메일 및 휴대폰 번호 업데이트
    cursor.execute("UPDATE member SET mem_pw = %s, mem_name = %s, mem_phone = %s WHERE mem_email = %s",
                   (mem_pw, mem_name, mem_phone, mem_email))
    db.commit()

    cursor.close()

    response = jsonify({"message": "Profile updated successfully"})
    response.status_code = 200
    return response

@app.route("/parking_lots", methods=["GET"])
def parkingLot():
    cursor = db.cursor()

    # 주차장 데이터를 가져오는 쿼리
    cursor.execute("SELECT * FROM tbl_parking_lot")

    # 모든 주차장 데이터를 가져와서 리스트에 저장
    parking_lots = []
    for parking_lot in cursor.fetchall():
        parking_lot_dict = {
            'parking_idx': parking_lot[0],
            'parking_name': parking_lot[1],
            'parking_tel': parking_lot[2],
            'parking_addr': parking_lot[3],
            'num_of_parking_lot': parking_lot[4],
            'lat': Decimal(parking_lot[5]),
            'log': Decimal(parking_lot[6]),
            'parking_img': parking_lot[7]
        }
        parking_lots.append(parking_lot_dict)

    cursor.close()
    return jsonify(parking_lots)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')


@app.teardown_appcontext
def close_db(error):
    global db
    if db:
        db.close()
