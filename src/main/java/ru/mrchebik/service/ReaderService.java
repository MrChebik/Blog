package ru.mrchebik.service;

import org.springframework.security.access.prepost.PreAuthorize;
import ru.mrchebik.model.Reader;

import java.util.List;

/**
 * Created by mrchebik on 03.02.17.
 */
public interface ReaderService {
    @PreAuthorize("hasRole('ROLE_USER')")
    Reader add(Reader reader);

    @PreAuthorize("hasRole('ROLE_USER')")
    Reader findOne(long userIdMain, long userIdFollower);

    @PreAuthorize("hasRole('ROLE_USER')")
    List<Reader> findAllMain(long userIdMain);

    @PreAuthorize("hasRole('ROLE_USER')")
    List<Reader> findAllFollower(long userIdMain);

    @PreAuthorize("hasRole('ROLE_USER')")
    void remove(long id);
}
