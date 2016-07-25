/*
*   Менеджер, управляющий данными.
*   Отвечает за создание, получение, удаление сущностей и атрибутов
*   Данные операции осуществляются в отдельном потоке с помощью транзакций
*/
interface IEntityManager : Object {

    /*
    *   Создает задание на создание сущности
    */
    public Entity CreateEntity ();

    /*
    *   Возвращает сущность по её идентификатору
    */
    public Entity GetEntity (string id);

    /*
    *   Создает атрибут по имени
    */
    public CreateAttribute (string name);

    /*
    *   Возвращает атрибут сущности по имени
    */    
    public Attribute GetAttribute (Entity entity, string name);

    /*
    *   Возвращает значение атрибута в виде string
    *   Если у атрибута тип не string кидает ошибку  
    */
    public string GetString (Attribute attribute);

    /*
    *   Возвращает значение атрибута в виде int
    *   Если у атрибута тип не int кидает ошибку
    */
    public int GetInt (Attribute attribute);

    /*
    *   Возвращает значение атрибута в виде double
    *   Если у атрибута тип не double кидает ошибку
    */
    public double GetDouble (Attribute attribute);

    /*
    *   Возвращает значение атрибута в виде bool
    *   Если у атрибута тип не bool кидает ошибку
    */
    public bool GetBool (Attribute attribute);
}