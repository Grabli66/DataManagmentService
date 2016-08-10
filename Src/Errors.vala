/*
*   Ошибки возникающие при разборе данных
*/
public errordomain ParseError {
    NO_DATA,
    WRONG_DATA;
}

/*
*   Ошибки возникающие при работе с базой данных
*/
public errordomain DatabaseError {
    CANT_OPEN,
    SQL_ERROR;
}

/*
*   Ошибки не подподающие под другие описания
*/
public errordomain CommonError {
    NOT_FOUND;
}