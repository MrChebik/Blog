package ru.mrchebik.service;

import ru.mrchebik.model.Reader;

import java.util.List;

/**
 * Created by mrchebik on 03.02.17.
 */
public interface ReaderService {
    void add(Reader reader);
    Reader findOne(long userIdMain, long userIdFollower);
    List<Reader> findAllMain(long userIdMain);
    List<Reader> findAllFollower(long userIdMain);
    void delete(long id);
}
