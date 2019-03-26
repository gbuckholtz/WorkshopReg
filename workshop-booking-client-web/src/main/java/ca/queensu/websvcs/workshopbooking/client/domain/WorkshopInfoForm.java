/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ca.queensu.websvcs.workshopbooking.client.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
/**
 *
 * @author sylvi
 */
public class WorkshopInfoForm implements Serializable{
    private String status;
    private String eventTitle;
    private String location;
    private String teaser;
    private Integer maxParticipant;
    private Integer waitlistLimit;

    // private Date rgStDate;    //Registration Start Date & Time
    // private Date rgStTime;    
    // private Date rgEndDate;   //Registration End Date & Time
    // private Date rgEndTime;   
    // private Date eventStDate; //Event Start Date & Time
    // private Date eventStTime;

    private String rgStDate;    //Registration Start Date & Time - year,month,day
    private String rgStTime;                                       //hour,minute
    private String rgEndDate;   //Registration End Date & Time   - year,month,day
    private String rgEndTime;                                       //hour,minnute
    private String eventStDate; //Event Start Date & Time
    private String eventStTime;

    private int workshopNumber;
    private String department;

    public String startTimeToString(){
        String output = "";
        String[] startTime = rgStTime.split(",");
        
        int hours = Integer.parseInt(startTime[0]);
        int minutes = Integer.parseInt(startTime[1]);
        
        if(minutes == 0)
            output += " : 00";
        else
            output += " : " + minutes;
        
        
        if (hours > 12){
            hours -= 12;
            output = hours + output + " PM";
        }
        else
            output = hours + output + " AM";

        return output;
    }
    
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getEventTitle() {
        return eventTitle;
    }

    public void setEventTitle(String eventTitle) {
        this.eventTitle = eventTitle;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getTeaser() {
        return teaser;
    }

    public void setTeaser(String teaser) {
        this.teaser = teaser;
    }

    public Integer getMaxParticipant() {
        return maxParticipant;
    }

    public void setMaxParticipant(Integer maxParticipant) {
        this.maxParticipant = maxParticipant;
    }

    public Integer getWaitlistLimit() {
        return waitlistLimit;
    }

    public void setWaitlistLimit(Integer waitlistLimit) {
        this.waitlistLimit = waitlistLimit;
    }

    public Date getRgStDate() {
        return rgStDate;
    }

    public void setRgStDate(Date rgStDate) {
        this.rgStDate = rgStDate;
    }

    public Date getRgStTime() {
        return rgStTime;
    }

    public void setRgStTime(Date rgStTime) {
        this.rgStTime = rgStTime;
    }

    public Date getRgEndDate() {
        return rgEndDate;
    }

    public void setRgEndDate(Date rgEndDate) {
        this.rgEndDate = rgEndDate;
    }

    public Date getRgEndTime() {
        return rgEndTime;
    }

    public void setRgEndTime(Date rgEndTime) {
        this.rgEndTime = rgEndTime;
    }

    public Date getEventStDate() {
        return eventStDate;
    }

    public void setEventStDate(Date eventStDate) {
        this.eventStDate = eventStDate;
    }

    public Date getEventStTime() {
        return eventStTime;
    }

    public void setEventStTime(Date eventStTime) {
        this.eventStTime = eventStTime;
    }

    public int getWorkshopNumber() {
        return workshopNumber;
    }

    public void setWorkshopNumber(int workshopNumber) {
        this.workshopNumber = workshopNumber;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }


    
}//end WorkshopInfoBean Class