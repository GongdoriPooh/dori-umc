// temp.service.js

import { tempResponseDTO, flagResponseDTO } from "../dtos/temp.response.dto";
import { BaseError } from "../../config/error.js";
import { status } from "../../config/response.status.js";

export const getTempData = () => {
    return tempResponseDTO("This is TEST! >.0");
}

export function CheckFlag(flag){
    if(flag == 1)
        throw new BaseError(status.BAD_REQUEST);   // BaseError로 에러 발생시키기!
    else{
        return flagResponseDTO(flag);
    }
}