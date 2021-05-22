#!/bin/bash

# postgresql 서버 시작
su postgres -c "pg_ctl start -l /pglog -D /pgdata"

# 한국어를 기준으로 정렬하는 korean-db 생성
su postgres -c "createdb -U postgres korean-db --encoding='utf-8' --lc-collate=ko_KR.UTF-8 --template=template0"

# postgresql 접속
psql -U postgres
