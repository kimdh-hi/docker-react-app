# --- Builder Stage --- #
# as: 다음 FROM절 까지 as로 지정한 이름의 stage임을 명시
FROM node:alpine as builder 
WORKDIR '/usr/src/app'
COPY package.json .
RUN npm install
COPY ./ ./
# working directory에 build 파일 생성
CMD npm run build

# --- Run Stage --- #
FROM nginx
# builder 스테이지에사 생성한 build파일을 nginx가 사용할 수 있는 경로로 복사
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

