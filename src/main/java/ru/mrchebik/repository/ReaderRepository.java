package ru.mrchebik.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import ru.mrchebik.model.Reader;

import java.util.List;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface ReaderRepository extends JpaRepository<Reader, Long> {
    @Query("select reader.id from ru.mrchebik.model.Reader reader where reader.user.userId = :userIdMain and reader.readerId = :userIdFollower")
    Object findOne(@Param("userIdMain") long userIdMain, @Param("userIdFollower") long userIdFollower);

    @Query("select reader.id, reader.readerId from ru.mrchebik.model.Reader reader where reader.user.userId = :userIdMain")
    List<Object[]> findAllMain(@Param("userIdMain") long userIdMain);

    @Query("select reader.id, reader.user.userId from ru.mrchebik.model.Reader reader where reader.readerId = :userIdFollower")
    List<Object[]> findAllFollower(@Param("userIdFollower") long userIdFollower);
}
