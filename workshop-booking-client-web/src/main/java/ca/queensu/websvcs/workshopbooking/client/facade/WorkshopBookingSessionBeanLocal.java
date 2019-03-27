package ca.queensu.websvcs.workshopbooking.client.facade;

import ca.queensu.websvcs.workshopbooking.client.domain.*;
import ca.queensu.websvcs.workshopbooking.core.entity.Catalogue;
import ca.queensu.websvcs.workshopbooking.core.entity.Person;
import java.util.List;
import javax.ejb.Local;

/**
 * <p>WorkshopBookingSessionBeanLocal interface.</p>
 *
 * @author CISC-498
 * @version $Id: $Id
 */
@Local
public interface WorkshopBookingSessionBeanLocal {

    public List<StudentDataBean> findStudentList();
    public StudentDataBean findStudentByPk(String studentPk);
    public List<String> findCountries();
    public List<String> findHairColours();
    public boolean updateStudent(StudentDataBean studentBean);
    
    // function.jsp
    public List<String> findstatusList();
    public List<String> findlocationList();
    public boolean updateWorkshopForm(WorkshopInfoForm workshopForm);
    
    // emailedit.jsp
    public boolean updateEmailForm(EmailInfoForm emailForm);
    
    //personalDetai.jsp
    public List<String> finddepartmentList();
    public List<String> findroleList();
    
    //for dashboard/Events    
    public List<WorkshopInfoForm> findWorkshopList();
    public WorkshopInfoForm findWorkshopByNum(String workshopNum);
    
    // ADDED BY VINCENT
    public Person getPersonByNetId(String netId);
    public void savePerson(Person p);
    public Catalogue findByWorkshopId(Integer id);
    

    public List<facilitatorDataBean> findFacilitatorList();

    
    public List<Catalogue> getWorkshopsForPerson(Person p);
    public List<Catalogue> getWorkshopsHostedByPerson(Person p);
}
