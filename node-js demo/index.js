// const express = require('express')   // 기존 JS
import express from 'express';          // ES6 - import를 통해 불러오는 방식
import { tempRouter } from './src/routes/temp.route.js'; // 라우터 모듈화 함수 불러오기 위해 import
import { status } from './config/response.status.js';    // status 사용
import { BaseError } from './config/error.js';            // 사용자 정의 에러 사용
import { response } from './config/response.js';          // response 사용

const app = express();
const port = 3000;

app.use('/temp', tempRouter); // router setting

// 내가 만든 에러 핸들러가 잡지 못한 에러를 다음 에러 핸들러로 넘김
app.use((req, res, next) => {
  const err = new BaseError(status.NOT_FOUND);
  next(err);
});

app.use((err, req, res, next) => {
  console.log(err.data.status);
  console.log(err.data.message);

  // 템플릿 엔진 변수 설정
  res.locals.message = err.message;   

  // 개발환경이면 에러를 출력하고 아니면 출력하지 않기
  res.locals.error = process.env.NODE_ENV !== 'production' ? err : {}; 
  res.status(err.data.status).send(response(err.data));
});

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`);
});