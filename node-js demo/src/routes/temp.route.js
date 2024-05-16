// temp.route.js

import express from 'express';
import { tempTest, tempException } from '../controllers/temp.controller.js';

export const tempRouter = express.Router();

tempRouter.get('/test', tempTest);                      // GET /temp/test
tempRouter.get('/exception/:flag',tempException);       // GET /temp/exception/:flag
