import datetime
import MySQLdb
from flask import Flask, jsonify, make_response, request, session, redirect
import time
import pandas as pd
import pymysql
from googletrans import Translator
from summarizer import Summarizer
import re
import os
import test as ts

app = Flask(__name__)
app.config["JSON_AS_ASCII"] = False
db = pymysql.connect(
    host="project-db-stu3.smhrd.com",
    user="Insa4_IOTA_final_3",
    password="aischool3",
    db="Insa4_IOTA_final_3",
    charset="utf8",
    port=3307,
)

# 중복된 아이디인지 확인해줘야해, 아이디 제한길이도 확인해줘야한다.


# @app.before_first_request
# def initialize_db():
#     global db
#     db = pymysql.connect(host='project-db-stu3.smhrd.com', user='Insa4_IOTA_final_3',
#                          password='aischool3', db='Insa4_IOTA_final_3', charset='utf8', port=3307)


# login api
@app.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    mem_email = data.get("mem_email")
    mem_pw = data.get("mem_pw")

    cursor = db.cursor()
    cursor.execute(
        "SELECT * FROM tbl_member WHERE mem_email = %s AND mem_pw = %s",
        (mem_email, mem_pw),
    )
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


@app.route("/kakao_login", methods=["POST"])
def kakao_login():
    data = request.get_json()
    mem_email = data.get("mem_email")
    mem_name = data.get("mem_name")

    cursor = db.cursor()
    cursor.execute(
        "SELECT * FROM tbl_member WHERE mem_email = %s AND mem_name = %s",
        (mem_email, mem_name),
    )
    user = cursor.fetchone()

    if user:
        response = make_response(jsonify({"message": "Login successful"}))
        response.status_code = 200
        cursor.close()
        return response
    else:
        try:
            cursor.execute(
                "INSERT INTO tbl_member (mem_email, mem_name) VALUES (%s,%s)",
                (mem_email, mem_name),
            )
            db.commit()  # Commit the INSERT operation to the database
            response = make_response(jsonify({"message": "Login successful"}))
            response.status_code = 200
        except MySQLdb.connector.Error as err:
            response = make_response(
                jsonify({"message": "Login failed due to a database error"})
            )
            response.status_code = 401

        cursor.close()
        return response


@app.route("/naver_login", methods=["POST"])
def naver_login():
    data = request.get_json()
    mem_email = data.get("mem_email")
    mem_name = data.get("mem_name")
    mem_phone = data.get("mem_phone")

    cursor = db.cursor()
    cursor.execute(
        "SELECT * FROM tbl_member WHERE mem_email = %s AND mem_name =%s",
        (mem_email, mem_name),
    )
    user = cursor.fetchone()

    if user:
        response = make_response(jsonify({"message": "Login successful"}))
        response.status_code = 200
        cursor.close()
        return response
    else:
        try:
            cursor.execute(
                "INSERT INTO tbl_member (mem_email, mem_name, mem_phone) VALUES (%s, %s, %s)",
                (mem_email, mem_name, mem_phone),
            )
            db.commit()  # Commit the INSERT operation to the database
            response = make_response(jsonify({"message": "Login successful"}))
            response.status_code = 200
        except MySQLdb.connector.Error as err:
            response = make_response(
                jsonify({"message": "Login failed due to a database error"})
            )
            response.status_code = 401
        finally:
            cursor.close()
        return response


# 회원가입 api
@app.route("/register", methods=["POST"])
def register():
    data = request.get_json()
    mem_email = data.get("mem_email")
    mem_pw = data.get("mem_pw")
    mem_name = data.get("mem_name")
    mem_phone = data.get("mem_phone")
    joined_at = datetime.datetime.now()
    print(joined_at)
    mem_login_type = data.get("mem_login_type")
    admin_yn = data.get("admin_yn")

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
            cursor.execute(
                "INSERT INTO tbl_member (mem_email, mem_pw, mem_name, mem_phone, joined_at, mem_login_type, admin_yn) VALUES (%s, %s, %s, %s, %s, %s, %s)",
                (
                    mem_email,
                    mem_pw,
                    mem_name,
                    mem_phone,
                    joined_at,
                    mem_login_type,
                    admin_yn,
                ),
            )
            db.commit()
            response = jsonify({"message": "Registration successful"})
            response.status_code = 200
            cursor.close()
            return response


# 회원 아이디 중복 체크하는 api
@app.route("/check_id", methods=["POST"])
def check_duplicate_id():
    data = request.get_json()
    mem_email = data.get("mem_email")

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


# 회원 삭제하는 api
@app.route("/delete_member", methods=["POST"])
def delete_member():
    data = request.get_json()
    mem_email = data.get("mem_email")

    cursor = db.cursor()

    # 회원 삭제
    cursor.execute("DELETE FROM tbl_member WHERE mem_email = %s", (mem_email))
    db.commit()

    cursor.close()

    response = jsonify({"message": "Member deleted successfully"})
    response.status_code = 200
    return response


# 비밀번호 변경 api
@app.route("/update_pwd", methods=["POST"])
def update_member():
    data = request.get_json()
    mem_email = data.get("mem_email")
    mem_pw = data.get("mem_pw")

    cursor = db.cursor()

    # 이름, 이메일 및 휴대폰 번호 업데이트
    cursor.execute(
        "UPDATE tbl_member SET mem_pw = %s WHERE mem_email = %s",
        (mem_pw, mem_email),
    )

    db.commit()

    cursor.close()
    if data:
        return jsonify(data), 200
    else:
        return jsonify({"message": "Profile updated successfully"}), 404


# 주차장 정보 api
@app.route("/parking_lots", methods=["GET"])
def parkingLot():
    cursor = db.cursor()

    # 주차장 데이터를 가져오는 쿼리
    cursor.execute("SELECT * FROM tbl_parking_lot")

    # 모든 주차장 데이터를 가져와서 리스트에 저장
    parking_lots = []
    for parking_lot in cursor.fetchall():
        parking_lot_dict = {
            "parking_idx": parking_lot[0],
            "parking_name": parking_lot[1],
            "parking_tel": parking_lot[2],
            "parking_addr": parking_lot[3],
            "num_of_parking_lot": parking_lot[4],
            "lat": float(parking_lot[5]),
            "log": float(parking_lot[6]),
            "parking_img": parking_lot[7],
        }
        parking_lots.append(parking_lot_dict)

    # 전체 parking_lots를 JSON 형식의 문자열로 변환

    # 이후에 필요한 로직을 추가할 수 있습니다.
    cursor.close()
    return jsonify(parking_lots)


# 회원정보 가져오는 api
@app.route("/getMember", methods=["GET"])
def getMember():
    cursor = db.cursor()
    mem_email = request.args.get("userId")  # 쿼리 매개변수에서 userId를 가져옴
    cursor.execute("SELECT * FROM tbl_member WHERE mem_email = %s", (mem_email))
    data = cursor.fetchall()

    cursor.close()
    return jsonify(data)


# 문의 제출 서버
@app.route("/submit_request", methods=["POST"])
def submit_request():
    data = request.get_json()
    mem_id = data.get("mem_id")
    req_title = data.get("req_title")
    req_content = data.get("req_content")
    req_file = data.get("req_file")

    cursor = db.cursor()
    try:
        cursor.execute(
            "INSERT INTO tbl_request (mem_id, req_title, req_content, received_at, req_file) VALUES (%s, %s, %s, NOW(), %s)",
            (mem_id, req_title, req_content, req_file),
        )
        db.commit()

        response = jsonify({"message": "Submit Successfully"})
        response.status_code = 200
        return response

    except Exception as e:
        print(f"Error submitting request: {e}")
        db.rollback()
        response = jsonify({"message": "Submit Failed"})
        response.status_code = 400
        return response
    finally:
        cursor.close()


# 사용자가 제출한 문의사항 리스트 보기
@app.route("/user_requests", methods=["GET"])
def user_requests():
    try:
        # 사용자의 이메일 주소를 어딘가에서 가져와서 사용
        # mem_email = get_current_user_email()  # 이 함수는 실제로 사용자의 이메일을 가져오는 함수일 것입니다.
        mem_email = request.args.get("mem_email")
        # req_idx = request.args.get('req_idx')
        if not mem_email:
            return jsonify({"message": "Email is required"}), 400

        cursor = db.cursor(pymysql.cursors.DictCursor)
        cursor.execute("SELECT * FROM tbl_request WHERE mem_id = %s", (mem_email,))
        # cursor.execute("SELECT * FROM tbl_request WHERE mem_id = %s && req_idx = %s", (mem_email, req_idx))
        user_requests = cursor.fetchall()

        response = jsonify({"user_requests": user_requests})
        response.status_code = 200
        return response

    except Exception as e:
        print(f"Error retrieving user requests: {e}")
        response = jsonify({"message": "Failed to retrieve user requests"})
        response.status_code = 500
        return response

    finally:
        cursor.close()


# 특정 문의사항의 상세 정보를 검색하는 라우트
@app.route("/user_request_detail", methods=["GET"])
def user_request_detail():
    inquiry_id = request.args.get("inquiry_id")
    mem_email = request.args.get("mem_email")
    if not inquiry_id:
        return jsonify({"message": "Inquiry ID is required"}), 400

    try:
        with db.cursor(pymysql.cursors.DictCursor) as cursor:
            # cursor.execute("SELECT * FROM tbl_request WHERE req_idx = %s", (inquiry_id,))
            cursor.execute(
                "SELECT * FROM Insa4_IOTA_final_3.tbl_request WHERE mem_id = %s AND req_idx = %s",
                (mem_email, inquiry_id),
            )
            inquiry_detail = cursor.fetchone()
            if inquiry_detail:
                return jsonify(inquiry_detail), 200
            else:
                return jsonify({"message": "Inquiry not found"}), 404

    except Exception as e:
        return jsonify({"message": f"Failed to retrieve inquiry detail: {e}"}), 500

    finally:
        db.close()


# # 아직 구현되지 않은 함수
# # 현재 로그인한 사용자의 이메일을 가져오는 함수
# def get_current_user_email():
#     # 세션에서 사용자 정보를 가져오는 예시
#     if 'user_email' in session:
#         return session['user_email']
#     else:
#         # 로그인되어 있지 않은 경우 처리 (예를 들어, 로그인 페이지로 리다이렉트)
#         return None


# 답변 제출하기
@app.route("/submit_answer", methods=["POST"])
def submit_answer():
    data = request.get_json()
    req_idx = data.get("req_idx")
    req_title = data.get("req_title")
    admin_id = data.get("admin_id")
    ans_content = data.get("ans_content")
    ans_file = data.get("ans_file")

    cursor = db.cursor()
    try:
        cursor.execute(
            "INSERT INTO tbl_answer (req_idx, req_title, admin_id, ans_content, ans_file, answered_at) VALUES (%s, %s, %s, %s, %s, NOW())",
            (req_idx, req_title, admin_id, ans_content, ans_file),
        )
        db.commit()

        response = jsonify({"message": "Answer Submitted Successfully"})
        response.status_code = 200
        return response

    except Exception as e:
        print(f"Error submitting answer: {e}")
        db.rollback()
        response = jsonify({"message": "Answer Submission Failed"})
        response.status_code = 400
        return response
    finally:
        cursor.close()


# 사용자에게 답변 선택 화면 제공
@app.route("/select_answer/<int:req_idx>")
def select_answer(req_idx):
    # 현재 로그인한 사용자의 ID를 어딘가에서 가져와서 사용
    current_user_id = get_current_user_id()  # 이 함수는 실제로 사용자의 ID를 가져오는 함수일 것입니다.

    # 사용자가 선택할 수 있는 답변 목록 가져오기
    user_answers = get_user_answers(current_user_id, req_idx)

    # 여기서는 JSON 형태로 답변 목록을 반환합니다.
    response_data = {
        "message": "Success",
        "user_answers": user_answers,  # 사용자의 답변 목록을 가공하여 필요한 형식으로 반환하면 됩니다.
    }

    return jsonify(response_data)


# 사용자가 선택한 답변 정보 가져오기
def get_selected_answer(mem_id, ans_idx):
    try:
        with db.cursor() as cursor:
            # 현재 로그인한 사용자가 선택한 특정 답변 가져오기
            sql = "SELECT * FROM tbl_answer WHERE ans_idx = %s AND mem_id = %s"
            cursor.execute(sql, (ans_idx, mem_id))
            result = cursor.fetchone()
            return result
    except Exception as e:
        print(f"Error retrieving selected answer: {e}")
        return None


# 답변 선택 후 처리 / 구체적으로 답변 보는 페이지
@app.route("/process_answer_selection/<int:ans_idx>")
def process_answer_selection(ans_idx):
    # 현재 로그인한 사용자의 ID를 어딘가에서 가져와서 사용
    current_user_id = get_current_user_id()  # 이 함수는 실제로 사용자의 ID를 가져오는 함수일 것입니다.

    # 선택한 답변 정보 가져오기
    selected_answer = get_selected_answer(current_user_id, ans_idx)

    # JSON 형태로 데이터 반환
    if selected_answer:
        # 여기서 선택한 답변 정보를 필요한 형식으로 가공하여 반환하면 됩니다.
        response_data = {
            "message": "Success",
            "selected_answer": {
                "ans_idx": selected_answer[0],
                "req_idx": selected_answer[1],
                "req_title": selected_answer[2],
                "admin_id": selected_answer[3],
                "ans_content": selected_answer[4],
                "ans_file": selected_answer[5],
                "answered_at": selected_answer[6].strftime(
                    "%Y-%m-%d %H:%M:%S"
                ),  # 시간을 문자열로 변환
            },
        }
        return jsonify(response_data)
    else:
        return jsonify({"message": "Error", "error": "Selected answer not found"})


# 업데이트 추가 엔드포인트
@app.route("/add_update", methods=["POST"])
def add_update():
    try:
        # 관리자가 직접 서버에 업데이트 내용을 추가
        update_title = request.form.get("up_title")
        update_content = request.form.get("up_content")
        admin_id = request.form.get("admin_id")

        # 업데이트 테이블에 데이터 추가
        with db.cursor() as cursor:
            sql = "INSERT INTO tbl_update (up_title, up_content, updated_at, admin_id) VALUES (%s, %s, NOW(), %s)"
            cursor.execute(sql, (update_title, update_content, admin_id))
            db.commit()

        return jsonify({"message": "Update added successfully"}), 200

    except Exception as e:
        return jsonify({"message": "Failed to add update", "error": str(e)}), 500


# 현재 업데이트 내용 확인 엔드포인트
@app.route("/get_updates", methods=["GET"])
def get_updates():
    try:
        # 업데이트 테이블에서 모든 업데이트 내역 가져오기
        with db.cursor() as cursor:
            sql = "SELECT * FROM tbl_update ORDER BY updated_at DESC"
            cursor.execute(sql)
            results = cursor.fetchall()

        if results:
            updates_list = []
            for result in results:
                update_data = {
                    "up_idx": result[0],
                    "up_title": result[1],
                    "up_content": result[2],
                    "updated_at": result[3].strftime("%Y-%m-%d %H:%M:%S"),
                    "admin_id": result[4],
                }
                updates_list.append(update_data)

            return jsonify({"updates": updates_list})
        else:
            return jsonify({"message": "No updates available"})

    except Exception as e:
        return jsonify({"message": "Failed to get updates", "error": str(e)}), 500


# ---------------------------------------------------------------------------------------
# 1. 문장 전처리 함수
def preprocess_sentence(sentence):
    cleaned_sentence = re.sub(r"[^\w\s.,?!ㄱ-ㅎㅏ-ㅣ가-힣]", "", sentence)
    return cleaned_sentence


# 2. 번역 함수
def google_translate_eng(text):
    translator = Translator()
    result = translator.translate(text, src="ko", dest="en").text
    return result


def google_translate_kor(text):
    translator = Translator()
    result = translator.translate(text, src="en", dest="ko").text
    return result


# 3. 요약 함수
def extractive_summary(text, ratio):
    summarizer = Summarizer()
    summary = summarizer(text, ratio)
    return summary if summary else text


def removeFile(fileName):
    file_path = "파일의_경로/파일명.txt"
    try:
        os.remove(file_path)
        print(f"{file_path}가 삭제되었습니다.")
    except FileNotFoundError:
        print(f"{file_path}를 찾을 수 없습니다.")
    except PermissionError:
        print(f"{file_path}를 삭제할 권한이 없습니다.")
    except Exception as e:
        print(f"오류 발생: {e}")


def transToTTS(user_name, kko_msg):
    # 문장 요약 단위 조절
    ratio = 0.2  # 20%로 문장 요약

    # 전처리 적용
    cleaned_msg = preprocess_sentence(kko_msg)

    # 요약처리를 위한 받아온 메시지를 번역
    translated_text = google_translate_eng(cleaned_msg)

    # 메시지 요약
    summary_eng_text = extractive_summary(translated_text, ratio)

    # 문장을 다시 번역
    summary_kor_text = google_translate_kor(summary_eng_text)

    return user_name, summary_kor_text


@app.route("/tts", methods=["POST"])
def text_to_speech():
    data = request.get_json()
    userName = data.get("userName")
    kko_msg = data.get("kko_msg")

    # TTS 함수 호출
    text_file = transToTTS(userName, kko_msg)

    # text_file[0]: userName
    # text_file[1]: kko_msg
    vuides = "카카오톡의 알림입니다. "
    call_name = text_file[0] + str(". ")
    intro = vuides + call_name

    send_msg = text_file[1]

    report = " 라고 메시지가 도착했습니다."

    final_message = intro + send_msg + report
    return jsonify({"message": final_message})


@app.route("/api/get_friends", methods=["GET"])
def api_get_friends():
    user_name = request.args.get("userName")
    token = ts.call_token(user_name)
    friends = ts.call_friends_uuid(token["refresh_token"])
    print(friends)
    return jsonify(friends)


# 데이터베이스에서 데이터 가져오기

query = "SELECT * FROM tbl_parking_lot"
parking = pd.read_sql(query, con=db)


@app.route("/find_closest_parking", methods=["GET"])
def find_closest_parking_api():
    current_lat = float(request.args.get("current_lat"))
    current_log = float(request.args.get("current_log"))

    # 주차장 위치 찾기
    msg, closest_lat, closest_log = ts.find_closest_parking(
        current_lat, current_log, parking  # DataFrame을 함수에 전달
    )

    # API 응답을 위한 JSON 데이터 생성
    response_data = {
        "message": msg,
        "closest_lat": closest_lat,
        "closest_log": closest_log,
    }

    return jsonify(response_data)


# 친구 이미지 불러오기
@app.route("/find_friend_img", methods=["GET"])
def find_friend_img():
    try:
        # POST 요청의 본문에서 데이터를 가져옵니다.
        user_name = request.args.get("userName")

        # 사용자 이름으로 토큰을 요청합니다.
        token = ts.call_token(user_name)

        # 토큰을 사용하여 친구의 이미지를 불러옵니다.
        img_src = ts.call_friends_image(token["refresh_token"])
        print(img_src)
        return jsonify(img_src), 200
    except Exception as e:
        # 에러 처리
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0")


# @app.teardown_appcontext
# def close_db(error):
#     global db
#     if db:
#         db.close()
@app.teardown_appcontext
def close_db(error):
    if hasattr(db, "close"):
        db.close()
