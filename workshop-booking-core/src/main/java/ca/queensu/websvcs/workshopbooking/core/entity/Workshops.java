/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ca.queensu.websvcs.workshopbooking.core.entity;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Vincent
 */
@Entity
@Table(name = "workshops")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Workshops.findAll", query = "SELECT w FROM Workshops w")
    , @NamedQuery(name = "Workshops.findByWorkshopId", query = "SELECT w FROM Workshops w WHERE w.workshopId = :workshopId")
    , @NamedQuery(name = "Workshops.findByWorkshopCreatorId", query = "SELECT c FROM Workshops c WHERE c.workshopCreatorId.netId = :netId")
    , @NamedQuery(name = "Workshops.findByTitle", query = "SELECT w FROM Workshops w WHERE w.title = :title")
    , @NamedQuery(name = "Workshops.findByDetails", query = "SELECT w FROM Workshops w WHERE w.details = :details")
    , @NamedQuery(name = "Workshops.findByLocation", query = "SELECT w FROM Workshops w WHERE w.location = :location")
    , @NamedQuery(name = "Workshops.findByMaxParticipants", query = "SELECT w FROM Workshops w WHERE w.maxParticipants = :maxParticipants")
    , @NamedQuery(name = "Workshops.findByWaitlistLimit", query = "SELECT w FROM Workshops w WHERE w.waitlistLimit = :waitlistLimit")
    , @NamedQuery(name = "Workshops.findByRegistrationStart", query = "SELECT w FROM Workshops w WHERE w.registrationStart = :registrationStart")
    , @NamedQuery(name = "Workshops.findByRegistrationEnd", query = "SELECT w FROM Workshops w WHERE w.registrationEnd = :registrationEnd")
    , @NamedQuery(name = "Workshops.findByEventStart", query = "SELECT w FROM Workshops w WHERE w.eventStart = :eventStart")
    , @NamedQuery(name = "Workshops.findByEventEnd", query = "SELECT w FROM Workshops w WHERE w.eventEnd = :eventEnd")
    , @NamedQuery(name = "Workshops.findByEmailNotificationName", query = "SELECT w FROM Workshops w WHERE w.emailNotificationName = :emailNotificationName")
    , @NamedQuery(name = "Workshops.findByEmailConfirmationMsg", query = "SELECT w FROM Workshops w WHERE w.emailConfirmationMsg = :emailConfirmationMsg")
    , @NamedQuery(name = "Workshops.findByEmailWaitlistMsg", query = "SELECT w FROM Workshops w WHERE w.emailWaitlistMsg = :emailWaitlistMsg")
    , @NamedQuery(name = "Workshops.findByEmailCancellationMsg", query = "SELECT w FROM Workshops w WHERE w.emailCancellationMsg = :emailCancellationMsg")
    , @NamedQuery(name = "Workshops.findByEmailEvaluationMsg", query = "SELECT w FROM Workshops w WHERE w.emailEvaluationMsg = :emailEvaluationMsg")
})

public class Workshops implements Serializable {

    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "workshop_id")
    private Integer workshopId;
    
    @Basic(optional = false)
    @Column(name = "title")
    private String title;
    
    @Basic(optional = false)
    @Column(name = "details")
    private String details;
    
    @Basic(optional = false)
    @Column(name = "location")
    private String location;
    
    @Basic(optional = false)
    @Column(name = "max_participants")
    private Integer maxParticipants;
    
    @Basic(optional = false)
    @Column(name = "waitlist_limit")
    private Integer waitlistLimit;
    
    @Basic(optional = false)
    @Column(name = "registration_start")
    @Temporal(TemporalType.TIMESTAMP)
    private Date registrationStart;
    
    @Basic(optional = false)
    @Column(name = "registration_end")
    @Temporal(TemporalType.TIMESTAMP)
    private Date registrationEnd;
    
    @Basic(optional = false)
    @Column(name = "event_start")
    @Temporal(TemporalType.TIMESTAMP)
    private Date eventStart;
    
    @Basic(optional = false)
    @Column(name = "event_end")
    @Temporal(TemporalType.TIMESTAMP)
    private Date eventEnd;
    
    @Column(name = "email_notification_name")
    private String emailNotificationName;
    
    @Column(name = "email_confirmation_msg")
    private String emailConfirmationMsg;
    
    @Column(name = "email_waitlist_msg")
    private String emailWaitlistMsg;
    
    @Column(name = "email_cancellation_msg")
    private String emailCancellationMsg;
    
    @Column(name = "email_evaluation_msg")
    private String emailEvaluationMsg;
    
    @JoinTable(name = "waitlist", joinColumns = {
        @JoinColumn(name = "workshop_id", referencedColumnName = "workshop_id")}, inverseJoinColumns = {
        @JoinColumn(name = "net_id", referencedColumnName = "net_id")})
    @ManyToMany
    private Collection<Person> personCollection2;
    
    @JoinColumn(name = "department_id", referencedColumnName = "department_id")
    @ManyToOne(optional = false)
    private Departments departmentId;
    
    @JoinColumn(name = "event_status", referencedColumnName = "event_status")
    @ManyToOne(optional = false)
    private EventStatus eventStatus;
    
    @JoinColumn(name = "workshop_creator_id", referencedColumnName = "net_id")
    @ManyToOne(optional = false)
    private Person workshopCreatorId;
    
    // a list of people who are registered for this workshop
    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "REGISTRATIONS", joinColumns = {
        @JoinColumn(name = "workshop_id", referencedColumnName = "workshop_id")}, inverseJoinColumns = {
        @JoinColumn(name = "net_id", referencedColumnName = "net_id")})
    private List<Person> myRegistrants;
    
    // a list of facilitators for this workshop
    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinTable(name = "FACILITATORS", joinColumns = {
        @JoinColumn(name = "workshop_id", referencedColumnName = "workshop_id")}, inverseJoinColumns = {
        @JoinColumn(name = "facilitator_id", referencedColumnName = "net_id")})
    private List<Person> myFacilitators;
    
    // an attendance for this workshop
    @OneToMany(mappedBy = "workshops", cascade = CascadeType.ALL)
    private List<Attendance> myAttendance;
    
    // a wait list for this workshop
    @OneToMany(mappedBy = "workshops", cascade = CascadeType.ALL)
    private List<Waitlist> myWaitlist;
    
    // a list of reviews for this workshop
    @OneToMany(mappedBy = "workshops", cascade = CascadeType.ALL)
    private List<Reviews> myReviews;

    
    public Workshops() {
    }

    public Workshops(Integer workshopId) {
        this.workshopId = workshopId;
    }

    public Workshops(Person workshopCreatorId, Departments departmentId, String title, String details, 
            String location, Integer maxParticipants, Integer waitlistLimit, Date registrationStart, 
            Date registrationEnd, Date eventStart, Date eventEnd, EventStatus eventStatus) {
        this.workshopId = null;
        this.workshopCreatorId = workshopCreatorId;
        this.departmentId = departmentId;
        this.title = title;
        this.details = details;
        this.location = location;
        this.maxParticipants = maxParticipants;
        this.waitlistLimit = waitlistLimit;
        this.registrationStart = registrationStart;
        this.registrationEnd = registrationEnd;
        this.eventStart = eventStart;
        this.eventEnd = eventEnd;
        this.eventStatus = eventStatus;
        this.emailNotificationName = "";
        this.emailConfirmationMsg = "";
        this.emailWaitlistMsg = "";
        this.emailCancellationMsg = "";
        this.emailEvaluationMsg = "";
    }

    public Integer getWorkshopId() {
        return workshopId;
    }

    public void setWorkshopId(Integer workshopId) {
        this.workshopId = workshopId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Integer getMaxParticipants() {
        return maxParticipants;
    }

    public void setMaxParticipants(Integer maxParticipants) {
        this.maxParticipants = maxParticipants;
    }
    
    public Integer getWaitlistLimit() {
        return this.waitlistLimit;
    }
    
    public void setWaitlistLimit(Integer waitlistLimit) {
        this.waitlistLimit = waitlistLimit;
    }

    public Date getRegistrationStart() {
        return registrationStart;
    }

    public void setRegistrationStart(Date registrationStart) {
        this.registrationStart = registrationStart;
    }

    public Date getRegistrationEnd() {
        return registrationEnd;
    }

    public void setRegistrationEnd(Date registrationEnd) {
        this.registrationEnd = registrationEnd;
    }

    public Date getEventStart() {
        return eventStart;
    }

    public void setEventStart(Date eventStart) {
        this.eventStart = eventStart;
    }

    public Date getEventEnd() {
        return eventEnd;
    }

    public void setEventEnd(Date eventEnd) {
        this.eventEnd = eventEnd;
    }

    public String getEmailNotificationName() {
        return emailNotificationName;
    }

    public void setEmailNotificationName(String emailNotificationName) {
        this.emailNotificationName = emailNotificationName;
    }

    public String getEmailConfirmationMsg() {
        return emailConfirmationMsg;
    }

    public void setEmailConfirmationMsg(String emailConfirmationMsg) {
        this.emailConfirmationMsg = emailConfirmationMsg;
    }

    public String getEmailWaitlistMsg() {
        return emailWaitlistMsg;
    }

    public void setEmailWaitlistMsg(String emailWaitlistMsg) {
        this.emailWaitlistMsg = emailWaitlistMsg;
    }

    public String getEmailCancellationMsg() {
        return emailCancellationMsg;
    }

    public void setEmailCancellationMsg(String emailCancellationMsg) {
        this.emailCancellationMsg = emailCancellationMsg;
    }

    public String getEmailEvaluationMsg() {
        return emailEvaluationMsg;
    }

    public void setEmailEvaluationMsg(String emailEvaluationMsg) {
        this.emailEvaluationMsg = emailEvaluationMsg;
    }

    @XmlTransient
    public Collection<Person> getPersonCollection2() {
        return personCollection2;
    }

    public void setPersonCollection2(Collection<Person> personCollection2) {
        this.personCollection2 = personCollection2;
    }
    
    public Departments getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(Departments departmentId) {
        this.departmentId = departmentId;
    }

    public EventStatus getEventStatus() {
        return eventStatus;
    }

    public void setEventStatus(EventStatus eventStatus) {
        this.eventStatus = eventStatus;
    }

    public Person getWorkshopCreatorId() {
        return workshopCreatorId;
    }

    public void setWorkshopCreatorId(Person workshopCreatorId) {
        this.workshopCreatorId = workshopCreatorId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (workshopId != null ? workshopId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Workshops)) {
            return false;
        }
        Workshops other = (Workshops) object;
        if ((this.workshopId == null && other.workshopId != null) || (this.workshopId != null && !this.workshopId.equals(other.workshopId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "ca.queensu.websvcs.workshopbooking.Workshops[ workshopId=" + workshopId + " ]";
    }
    
    
    @XmlTransient
    public List<Person> getMyRegistrants() {
        return myRegistrants;
    }

    public void setMyRegistrants(List<Person> registrants) {
        this.myRegistrants = registrants;
    }
    
    public void addRegistrant(Person p) {
        this.myRegistrants.add(p);
        p.getAllWorkshops().add(this);
    }
    
    public void removeRegistrant(Person p) {
        this.myRegistrants.remove(p);
        p.getAllWorkshops().remove(this);
    }
    
    @XmlTransient
    public List<Person> getMyFacilitators() {
        return myFacilitators;
    }

    public void setMyFacilitators(List<Person> myFacilitators) {
        this.myFacilitators = myFacilitators;
    }
    
    public void addFacilitator(Person p) {
        this.myFacilitators.add(p);
        p.getOwnedWorkshops().add(this);
    }
    
    public void removeFacilitator(Person p) {
        this.myFacilitators.remove(p);
        p.getOwnedWorkshops().remove(this);
    }
    
    @XmlTransient
    public List<Attendance> getMyAttendance() {
        return myAttendance;
    }

    public void setMyAttendance(List<Attendance> myAttendance) {
        this.myAttendance = myAttendance;
    }
    
    @XmlTransient
    public List<Waitlist> getMyWaitlist() {
        return myWaitlist;
    }

    public void setMyWaitlist(List<Waitlist> myWaitlist) {
        this.myWaitlist = myWaitlist;
    }
    
    @XmlTransient
    public List<Reviews> getMyReviews() {
        return myReviews;
    }

    public void setMyReviews(List<Reviews> myReviews) {
        this.myReviews = myReviews;
    }
    
}
