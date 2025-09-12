package org.example.pdp_2.util;

import jakarta.servlet.http.Cookie;
import org.example.pdp_2.repository.UserDAO;
import org.example.pdp_2.entity.User;

import java.util.*;

public class Utils {
    static UserDAO userDAO = UserDAO.getUserDAO();
    public static Optional<User> getUserFromCookie(Cookie[] cookies){
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("identity")) {
                String identity = new String(Base64.getDecoder().decode(cookie.getValue()));
                String[] split = identity.split(":");
                Optional<User> userByNumber = userDAO.getUserByNumber(split[0]);
                if (userByNumber.isPresent()) {
                    return userByNumber;
                }
            }
        }
        return Optional.empty();
    }
}

