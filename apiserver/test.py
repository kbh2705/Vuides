from datetime import datetime
import pandas as pd
import numpy as np
import pymysql
import requests
import json
import pyowm
import re
import os

rest_api = "67a9642b75f21352fa424953fbec7a7b"  # 카카오 디벨로퍼스


# 사용자 access_token 및 refresh_token 받아오기
def call_token(user_name):
    user_token = {
        "강병화": {
            "access_token": "2qYoFkb7H_jib5DKzwYGFbSPyWdeLvUVw7YKKw0eAAABi_8oPFe2xj-RG-1vuA",
            "token_type": "bearer",
            "refresh_token": "tVATh9nZtRCP5amSS4ROWurNuTfN-i9tvCQKKw0eAAABi_8oPFS2xj-RG-1vuA",
            "expires_in": 21599,
            "scope": "talk_message friends",
            "refresh_token_expires_in": 5183999,
        },
        "권준오": {
            "access_token": "KazA4V-NSY8cey85uNfB9oaNpMA4knupK84KKw0gAAABi_CIVnrHP8VuE1ZNOQ",
            "token_type": "bearer",
            "refresh_token": "442nza8xKkkQ1k8GMDF79pKOopJq7_uOlfUKKw0gAAABi_CIVnfHP8VuE1ZNOQ",
            "expires_in": 21599,
            "scope": "talk_message friends",
            "refresh_token_expires_in": 5183999,
        },
        "김재영": {
            "access_token": "lK3rbmpBXnvDGehCmlnLuAGBt4fmYoOlWnEKKw0gAAABi_CJw9ktjdRiIM79qQ",
            "token_type": "bearer",
            "refresh_token": "qf8nMGuE70SZNtyW6T4OgaXkA4tzH-ojo2YKKw0gAAABi_CJw9YtjdRiIM79qQ",
            "expires_in": 21599,
            "scope": "talk_message friends",
            "refresh_token_expires_in": 5183999,
        },
        "이승준": {
            "access_token": "nfSigKXxrf95bnd7R3uE5M9BaEaUcCp-HVEKPXVcAAABi_B2tRzokopMIboAuA",
            "token_type": "bearer",
            "refresh_token": "Sc4rdNWvafhqNH_DyH6V1K0MXBQ3oGrptSIKPXVcAAABi_B2tRnokopMIboAuA",
            "expires_in": 21599,
            "scope": "talk_message friends",
            "refresh_token_expires_in": 5183999,
        },
        "이정연": {
            "access_token": "-P-kkmXGHin1VMq1ZTAFh26KuzipH8-ZOigKPXTZAAABi_BwII3E017PSiBv1Q",
            "token_type": "bearer",
            "refresh_token": "XPqm0fvsZwfeKF3zPA3sbwN3urB7Aj9T3wsKPXTZAAABi_BwIIvE017PSiBv1Q",
            "expires_in": 21599,
            "scope": "talk_message friends",
            "refresh_token_expires_in": 5183999,
        },
    }
    token = user_token[user_name]
    return token


# 카카오 API 엑세스 토큰 받아오기
def get_access_token(refresh_token):
    url = "https://kauth.kakao.com/oauth/token"
    data = {
        "grant_type": "refresh_token",
        "client_id": rest_api,
        "refresh_token": refresh_token,  # 사용자 정의하기(refresh token 사용)
    }
    response = requests.post(url, data=data)
    tokens = response.json()

    # kakao_code.json 파일 저장
    with open("kakao_code.json", "w") as fp:
        json.dump(tokens, fp)

    # 카카오 API 엑세스 토큰
    with open("kakao_code.json", "r") as fp:
        tokens = json.load(fp)

    return tokens["access_token"]


# 카카오 친구 목록 가져오기
def friends_list(access_token):
    url = "https://kapi.kakao.com/v1/api/talk/friends"  # 친구 목록 가져오기
    header = {"Authorization": "Bearer " + access_token}
    result = json.loads(requests.get(url, headers=header).text)
    friends_list = result.get("elements")
    return friends_list


# 카카오톡 친구 이름 가져오기
def friends_name(friends_list):
    friends_names = []
    for i in range(len(friends_list)):
        friends_names.append(friends_list[i].get("profile_nickname"))
    return friends_names


# 카카오톡 uuid 가져오기
def friends_uuid(friends_list):
    friends_uuids = []
    for i in range(len(friends_list)):
        friends_uuids.append(friends_list[i].get("uuid"))
    return friends_uuids


user = "이정연"  # 운전만해 사용자를 정의
token = call_token(user)  # 토큰 받아오기

# # 토큰 정보 확인하기
# print(
#     f"user: {user}"
#     + str("\n")
#     + f'access token: {token["access_token"]}'
#     + str("\n")
#     + f'refresh token: {token["refresh_token"]}'
# )


# 이름 텍스트 전처리
def text_preprocess(friends_names):
    cleaned_names = [re.sub(r"[^가-힣]", "", name) for name in friends_names]
    result = ", ".join(cleaned_names)
    result_list = result.split(", ")
    return result_list


# 친구 불러오기
def call_friends_uuid(refresh_token):
    names = text_preprocess(friends_name(friends_list(get_access_token(refresh_token))))
    uuids = friends_uuid(friends_list(get_access_token(refresh_token)))
    kakao_friends_uuid = dict(zip(names, uuids))
    return kakao_friends_uuid


print(call_friends_uuid(token["refresh_token"]).keys())  # 친구 이름 및 uuid를 받아옴


# 카카오톡 프로필 이미지 가져오기
def friends_image(friends_list):
    friends_imgs = []
    for i in range(len(friends_list)):
        friends_imgs.append(friends_list[i].get("profile_thumbnail_image"))
    return friends_imgs


# 친구 프로필 이미지 불러오기
def call_friends_image(refresh_token):
    names = text_preprocess(friends_name(friends_list(get_access_token(refresh_token))))
    imgs = friends_image(friends_list(get_access_token(refresh_token)))
    kakao_friends_img = dict(zip(names, imgs))
    return kakao_friends_img


### 기능 함수 정의 ###
def answer(input_text):
    greeting_response = "안녕하세요! 저는 운전자의 안전운전을 책임지는 운전만해 가이드 브이즈에요"
    common_thanks_response = "별 말씀을요."
    responses = {
        "안녕": greeting_response,
        "하이": greeting_response,
        "시간": get_current_time(),
        "날씨": get_weather(),
        "습도": get_outdoorSTATE(),
        "온도": get_outdoorSTATE(),
        "주차장": find_closest_parking(current_lat, current_log, parking),
        "카카오톡": lambda: send_msg_friends(token["refresh_token"]),
        "고마워": common_thanks_response,
    }

    if input_text in responses:
        if callable(responses[input_text]):
            answer_text = responses[input_text]()
        else:
            answer_text = responses[input_text]
    else:
        answer_text = "죄송합니다. 질문을 듣지 못했어요."

    print(answer_text)
    return answer_text


# 현재 시간 데이터 가져오기
def get_current_time():
    now = datetime.now()
    current_time = now.strftime("%H:%M:%S")
    answer = f"현재 시간은 {current_time}입니다."
    return answer


# 날씨 정보 리스트
def translate_status_to_korean(status):
    # 날씨 상태에 대한 한글 번역
    translation_dict = {
        "Clear": "푸른 하늘과 함께하는 맑은 날씨입니다. 소풍을 가보는건 어떠실까요?",
        "Clouds": "구름이 많고 우중충한 날씨입니다. 비가 올지도 모르겠네요.",
        "Rain": "하늘에서 비가 내립니다. 외출시 우산을 꼭 챙기세요.",
        "Snow": "소복소복 눈이 옵니다. 길이 미`끄러울수 있으니 주의하세요!",
        "Thunderstorm": "우르릉 쾅쾅! 천둥 번개가 치니 집에 있는게 좋겠어요.",
        "Drizzle": "이슬비가 내립니다. 송글송글 맺히는 물방울이 예쁘네요.",
        "Mist": "안개가 끼는 날씨이니 주위를 잘 살피세요.",
        "Fog": "안개가 자욱하게 끼는 날씨입니다. 이동시 시야를 확실하게 확보하세요.",
        "Haze": "아지랑이가 생기는 날씨입니다.",
        "Smoke": "연기가 나는데요, 주변에 불이 났다면 119로 신고하세요!",
        "Dust": "먼지가 많은 날씨입니다. 외출시 마스크는 필수!",
        "Sand": "중국발 황사가 발발하였습니다. 집에 있는게 좋을지도? 모르겠네요.",
        "Ash": "화산이 분화하고 화산재가 내립니다.",
        "Squall": "세찬 바람이 불어오는 날씨네요. 돌풍에 휩쓸리지 않게 주의하세요.",
        "Tornado": "토네이도가 옵니다. 예상경로에서 대피하세요!",
    }

    return translation_dict.get(status, status)


# 현재 날씨 정보 가져오기
def get_weather():
    owm = pyowm.OWM(owm_api)  # 여기에 자신의 OpenWeatherMap API 키를 넣어주세요.

    observation = owm.weather_manager().weather_at_place("Gwangju,kr")
    w = observation.weather

    temperature = w.temperature("celsius")["temp"]
    status = w.status

    korean_status = translate_status_to_korean(status)

    return f"현재 광주의 날씨는 {korean_status}"


def get_outdoorSTATE():
    owm = pyowm.OWM(
        "3bd219715fddd2551654637f3df641db"
    )  # 여기에 자신의 OpenWeatherMap API 키를 넣어주세요.

    observation = owm.weather_manager().weather_at_place("Busan,kr")
    w = observation.weather

    temperature = w.temperature("celsius")["temp"]
    humidity = w.humidity
    status = w.status

    answer = f"현재 온도: {temperature}℃ 이며, 습도는 {humidity}% 입니다."
    return answer


# 친구에게 메시지 보내기
def send_msg_friends(refresh_token):
    friends_dict = call_friends_uuid(refresh_token)
    print("누구에게 메시지를 보낼까요?")
    friend_name = input()
    if friend_name in friends_dict:
        friend_uuid = friends_dict[friend_name]

    else:
        answer = f"친구를 찾을 수 없습니다."
        return answer

    print("전송할 메시지 내용을 말씀해주세요.")
    send_msg = input()
    url = "https://kapi.kakao.com/v1/api/talk/friends/message/default/send"
    header = {"Authorization": "Bearer " + get_access_token(refresh_token)}
    data = {
        "receiver_uuids": '["{}"]'.format(friend_uuid),
        "template_object": json.dumps(
            {
                "object_type": "text",
                "text": send_msg,
                "link": {
                    "web_url": "https://www.google.co.kr/search?q=deep+learning&source=lnms&tbm=nws",
                    "mobile_web_url": "https://www.google.co.kr/search?q=deep+learning&source=lnms&tbm=nws",
                },
                "button_title": "운전만해",
            }
        ),
    }
    response = requests.post(url, headers=header, data=data)
    response.status_code
    if response.status_code == 200:
        answer = f"{friend_name}에게 {send_msg} 의 메시지를 전송했습니다."
        return answer
    else:
        awswer = f"메시지 전송에 실패했습니다."
        return answer


# 주차장 위치 안내
def find_closest_parking(current_lat, current_lon, parking_df):
    # Haversine 거리를 계산하는 함수
    def haversine(lat1, log1, lat2, log2):
        R = 6371  # 지구 반지름 (킬로미터 단위)
        lat1, log1, lat2, log2 = map(np.radians, [lat1, log1, lat2, log2])
        dlat = lat2 - lat1
        dlog = log2 - log1
        a = np.sin(dlat / 2) ** 2 + np.cos(lat1) * np.cos(lat2) * np.sin(dlog / 2) ** 2
        c = 2 * np.arcsin(np.sqrt(a))
        distance = R * c * 1000  # 미터로 변환
        return distance

    # 거리를 계산하고 최소 거리에 해당하는 행 찾기
    parking_df["distance"] = parking_df.apply(
        lambda row: haversine(current_lat, current_lon, row["lat"], row["log"]), axis=1
    )
    closest_location = parking_df.loc[parking_df["distance"].idxmin()]

    # 'distance' 열은 필요 없으면 삭제
    parking_df = parking_df.drop(columns=["distance"])

    # 주차장 데이터를 담을 딕셔너리
    parking_data = {
        "parking_name": closest_location["parking_name"],
        "parking_addr": closest_location["parking_addr"],
        "parking_distance": int(round(closest_location["distance"])),
        "num_of_parking_lot": closest_location["num_of_parking_lot"],
        "closest_lat": closest_location["lat"],  # 가장 가까운 주차장의 위도
        "closest_lon": closest_location["log"],  # 가장 가까운 주차장의 경도
    }
    if parking_data["parking_distance"] <= 200:
        msg = f"현재 위치에서 {parking_data['parking_distance']}미터 거리에 주차장이 있습니다. 주차장의 이름은 {parking_data['parking_name']}이며, 이 곳의 주차공간은 총 {parking_data['num_of_parking_lot']}개 입니다."
    elif parking_data["parking_distance"] <= 500:
        msg = f"현재 위치에서 {parking_data['parking_distance']}미터 거리에주차장이 있습니다. 주차장의 이름은 {parking_data['parking_name']}입니다."
    else:
        msg = "죄송합니다. 근처에 발견된 주차장이 없습니다."
    return msg, closest_location["lat"], closest_location["log"]


def handle_call():
    while True:
        spoken_text = input()
        if spoken_text:
            answer_text = answer(spoken_text)
            if answer_text != "브이즈":
                break  # '호출' 이외의 키워드에 대한 응답을 받으면 루프를 빠져나감


def main(text):
    while True:
        spoken_text = text
        if spoken_text == "브이즈":
            print("무엇을 도와드릴까요?")
            handle_call()


# parking_location = find_closest_parking(current_lat, current_log, parking)
# print(parking_location) # 메시지, 위도, 경도 순으로 출력됨
