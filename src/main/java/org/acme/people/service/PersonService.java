package org.acme.people.service;

import java.time.LocalDate;

import javax.enterprise.context.ApplicationScoped;
import javax.transaction.Transactional;

import org.acme.people.model.EyeColor;
import org.acme.people.model.Person;

import io.quarkus.vertx.ConsumeEvent;

@ApplicationScoped
public class PersonService {

    @ConsumeEvent(value = "add-person", blocking = true)
    @Transactional
    public String addPerson(String name) {
        LocalDate birth = LocalDate.now().plusWeeks(Math.round(Math.floor(Math.random() * 20 * 52 * -1)));
        EyeColor color = EyeColor.values()[(int)(Math.floor(Math.random() * EyeColor.values().length))];
        Person p = new Person();
        p.birth = birth;
        p.eyes = color;
        p.name = name;
        Person.persist(p);
        return p.name;
    }

}