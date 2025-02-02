//
//  LCE.swift
//  Monadic
//
//  Created by Pavel Annin on 02.02.2025.
//


/// ###### EN:
/// The `LCE` type is a functional construct used to handle the state of an asynchronous
/// operation (network request, database operation, or file storage operation).
/// Contains the values `loading` (for loading), `content` (for a successful value) and `error` (for errors).
///
/// The `LCE` type allows you to process all the values of an asynchronous operation in one type,
/// applicable to the View state in MVI approaches.
///
/// ###### RU:
/// Тип `LCE` - это функциональная конструкция, используемая для обработки состояния асинхронной
/// операции (сетевой запрос, работа с БД или работа с файловым хранилищем).
/// Собержит значения `loading` (для загрузки), `content` (для успешного значения) и `error` (для ошибок).
///
/// Тип `LCE` позволяет обрабатывать все значения асинхронной операции в одном типе, применим для состояния View в MVI подходах.
public enum LCE<Loading, Content, Failure> {
    case loading(Loading)
    case content(Content)
    case error(Failure)
}
