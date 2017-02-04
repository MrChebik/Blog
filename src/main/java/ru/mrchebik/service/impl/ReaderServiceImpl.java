package ru.mrchebik.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ru.mrchebik.model.Reader;
import ru.mrchebik.repository.ReaderRepository;
import ru.mrchebik.service.ReaderService;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by mrchebik on 03.02.17.
 */
@Service
@Repository
@Transactional
public class ReaderServiceImpl implements ReaderService {
    @Autowired
    private ReaderRepository readerRepository;

    @Override
    public void add(Reader reader) {
        readerRepository.saveAndFlush(reader);
    }

    @Override
    public Reader findOne(long userIdMain, long userIdFollower) {
        if (readerRepository.findOne(userIdMain, userIdFollower) == null) {
            return null;
        } else {
            long id = Long.parseLong(String.valueOf(readerRepository.findOne(userIdMain, userIdFollower)));

            return new Reader(id, userIdMain, userIdFollower);
        }
    }

    @Override
    public List<Reader> findAllMain(long userIdMain) {
        List<Reader> readers = new ArrayList<>();
        for(Object[] object : readerRepository.findAllMain(userIdMain)) {
            long id = Long.parseLong(String.valueOf(object[0]));
            long readerId = Long.parseLong(String.valueOf(object[1]));

            readers.add(new Reader(id, userIdMain, readerId));
        }
        return readers;
    }

    @Override
    public List<Reader> findAllFollower(long userIdFollower) {
        List<Reader> readers = new ArrayList<>();
        for(Object[] object : readerRepository.findAllFollower(userIdFollower)) {
            long id = Long.parseLong(String.valueOf(object[0]));
            long userId = Long.parseLong(String.valueOf(object[1]));

            readers.add(new Reader(id, userId, userIdFollower));
        }
        return readers;
    }

    @Override
    public void delete(long id) {
        readerRepository.delete(id);
    }
}
