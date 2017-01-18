package ru.mrchebik.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import ru.mrchebik.model.Role;

/**
 * Created by mrchebik on 14.01.17.
 */
public interface RoleRepository extends JpaRepository<Role, Long> {
}
