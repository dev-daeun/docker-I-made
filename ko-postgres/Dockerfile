FROM debian:buster-slim

RUN apt-get update && \
    apt-get -y install locales && \
    sed -i 's/# ko_KR.UTF-8 UTF-8/ko_KR.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

# 1. postgresql, postgis 설치
RUN apt-get update && \
    apt-get -y install gnupg lsb-release wget && \
    sed -i 's/# ko_KR.UTF-8 UTF-8/ko_KR.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -  && \
    apt-get -y install postgresql-11 postgis

# 2. 환경변수 정의
ENV PATH=/usr/lib/postgresql/11/bin:$PATH \
    PGDATA=/pgdata

# 3. postgres 유저에게 데이터 디렉토리 및 로그파일에 접근할 수 있는 권한 부여
RUN mkdir $PGDATA && \
    chown postgres /pgdata && \
    touch /pglog && \
    chown postgres /pglog

# 4. initdb 명령어로 클러스터 만들기
RUN su postgres -c "initdb -D /pgdata"

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5555

ENTRYPOINT ["./entrypoint.sh"]
