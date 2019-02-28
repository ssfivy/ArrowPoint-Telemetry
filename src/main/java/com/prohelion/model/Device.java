package com.prohelion.model;

// Generated 07/08/2013 11:47:52 PM by Hibernate Tools 4.0.0

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * Device generated by hbm2java
 */
@Entity
@Table(name = "dev", schema = "public")
public class Device implements java.io.Serializable {

    private static final long serialVersionUID = 1224811522234193926L;
	
	private long id;
    private String name;
    private String abbreviation;
    private Set<Measurement> measurements = new HashSet<Measurement>(0);

    public Device() {
    }

    public Device(long Id) {
        this.id = Id;
    }

    public Device(long Id, String name, String abbreviation, Set<Measurement> measurements) {
        this.id = Id;
        this.name = name;
        this.abbreviation = abbreviation;
        this.measurements = measurements;
    }

    @Id
    @Column(name = "dev_id", unique = true, nullable = false)
    public long getId() {
        return this.id;
    }

    public void setId(long Id) {
        this.id = Id;
    }

    @Column(name = "dev_name")
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "dev_abbrev", length = 10)
    public String getAbbreviation() {
        return this.abbreviation;
    }

    public void setAbbreviation(String abbreviation) {
        this.abbreviation = abbreviation;
    }

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "device")
    @JsonIgnore
    public Set<Measurement> getMeasurements() {
        return this.measurements;
    }

    public void setMeasurements(Set<Measurement> measurements) {
        this.measurements = measurements;
    }

}