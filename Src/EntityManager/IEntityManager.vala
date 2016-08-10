/*
*   Менеджер, управляющий данными.
*   Отвечает за создание, получение, удаление сущностей и атрибутов
*   Данные операции осуществляются в отдельном потоке с помощью транзакций
*/
interface IEntityManager : Object {

    /*
    *   Создает задание на создание сущности
    */
    public abstract Entity CreateEntity ();

    /*
    *   Возвращает сущность по её идентификатору
    */
 //   public abstract Entity GetEntity (string id);

    /*
    *   Создает атрибут по имени
    */
 //   public abstract Attribute CreateAttribute (string name);

    /*
    *   Возвращает атрибут сущности по имени
    */    
 //   public abstract Attribute GetAttribute (Entity entity, string name);

    /*
    *   Возвращает значение атрибута в виде string
    *   Если у атрибута тип не string кидает ошибку  
    */
 //   public abstract string GetString (Attribute attribute);

    /*
    *   Возвращает значение атрибута в виде int
    *   Если у атрибута тип не int кидает ошибку
    */
 //   public abstract int GetInt (Attribute attribute);

    /*
    *   Возвращает значение атрибута в виде double
    *   Если у атрибута тип не double кидает ошибку
    */
 //   public abstract double GetDouble (Attribute attribute);

    /*
    *   Возвращает значение атрибута в виде bool
    *   Если у атрибута тип не bool кидает ошибку
    */
 //   public abstract bool GetBool (Attribute attribute);
}