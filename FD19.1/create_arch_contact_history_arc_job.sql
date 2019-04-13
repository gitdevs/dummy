BEGIN
  dbms_scheduler.create_job(
      job_name => 'ARCH_CONTACT_HISTORY_ARC'
     ,job_type => 'PLSQL_BLOCK'
     ,job_action => 'DECLARE
                    l_error_message VARCHAR2(255);
                    l_rtn NUMBER(1);
                    BEGIN
                    l_rtn := ARCH_CONTACT_HISTORY_PE(l_error_message);
                    INSERT INTO T_Scheduled_Job_Results(Job_Command,Run_By_User,Completed_At,Return_Code,Error_Message)
                    VALUES(''ARCH_CONTACT_HISTORY_ARC'',''GDSPADMIN'',SYS_EXTRACT_UTC(SYSTIMESTAMP),l_rtn,l_error_message);
                    COMMIT;
                    END;'
     ,start_date => trunc(sysdate,'MONTH')+5/24
     ,repeat_interval => 'FREQ=MONTHLY'
     ,enabled => TRUE
     ,comments => 'Monthly T_CONTACT_HISTORY to T_CONTACT_HISTORY_ARCHIVE');
END;
/
 