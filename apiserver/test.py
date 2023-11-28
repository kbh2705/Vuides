import numpy as np
import pandas as pd
import requests
import json
import re

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
        "closest_lat": closest_location["lat"],  # 가장 가까운 주차장의 위도
        "closest_lon": closest_location["log"],  # 가장 가까운 주차장의 경도
    }
    if parking_data["parking_distance"] <= 100:
        msg = f"근처 {parking_data['parking_distance']}미터 부근에 주차장이 있습니다. {parking_data['parking_name']}입니다."
    elif parking_data["parking_distance"] <= 500:
        msg = f"{parking_data['parking_distance']}미터에 주차장이 있습니다. {parking_data['parking_name']}입니다."
    else:
        msg = "근처에 주차장이 없습니다."
    return msg, closest_location["lat"], closest_location["log"]


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


# parking_location = find_closest_parking(current_lat, current_log, parking)
# print(parking_location) # 메시지, 위도, 경도 순으로 출력됨
