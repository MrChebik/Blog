package ru.mrchebik.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.mrchebik.model.Reader;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface ReaderRepository extends JpaRepository<Reader, Long> {
}
