DECLARE
  -- Simple collections 
  TYPE t_expiry_dates IS VARRAY(10) OF DATE;                    
  TYPE t_batch_nos    IS TABLE OF VARCHAR2(20);                 
  TYPE t_quantities   IS TABLE OF NUMBER;

  -- Record type
  TYPE MedicineRec IS RECORD (
    medicine_name VARCHAR2(100),
    batch_no      t_batch_nos,
    expiry_date   t_expiry_dates,
    quantity      t_quantities,
    price         NUMBER(10,2)
  );

  TYPE PharmacyInventory IS TABLE OF MedicineRec INDEX BY PLS_INTEGER;

  inventory     PharmacyInventory;
  today         DATE := TRUNC(SYSDATE);
  days_left     NUMBER;
  crit_count    NUMBER := 0;
  idx           PLS_INTEGER;


BEGIN
  -- POPULATE DATA 

  -- Medicine 1: Paracetamol
  inventory(1).medicine_name := 'Paracetamol 500mg';
  inventory(1).price         := 45.50;
  inventory(1).batch_no      := t_batch_nos('B001', 'B002');
  inventory(1).expiry_date   := t_expiry_dates(DATE '2026-02-10', DATE '2025-12-28');
  inventory(1).quantity      := t_quantities(150, 80);

  -- Medicine 2: Amoxicillin
  inventory(2).medicine_name := 'Amoxicillin 250mg';
  inventory(2).price         := 120.00;
  inventory(2).batch_no      := t_batch_nos('B103', 'B104', 'B105');
  inventory(2).expiry_date   := t_expiry_dates(DATE '2025-10-20', DATE '2025-11-15', DATE '2026-03-01');
  inventory(2).quantity      := t_quantities(30, 45, 100);

  -- Medicine 3: Aspirin
  inventory(3).medicine_name := 'Aspirin 75mg';
  inventory(3).price         := 18.00;
  inventory(3).batch_no      := t_batch_nos('ASP01');
  inventory(3).expiry_date   := t_expiry_dates(DATE '2025-12-08');  -- 13 days left
  inventory(3).quantity      := t_quantities(120);

  DBMS_OUTPUT.PUT_LINE('PHARMACY EXPIRY ALERT SYSTEM');
  DBMS_OUTPUT.PUT_LINE('Generated on: ' || TO_CHAR(today, 'DD-MON-YYYY'));
  DBMS_OUTPUT.PUT_LINE(CHR(13));
  DBMS_OUTPUT.PUT_LINE(RPAD('-', 70, '-'));
  


  -- Process each medicine
  idx := inventory.FIRST;
  WHILE idx IS NOT NULL LOOP

    FOR i IN 1 .. inventory(idx).batch_no.COUNT LOOP

      days_left := inventory(idx).expiry_date(i) - today;

      -- Critical: Already expired  Use GOTO for immediate alert
      IF days_left < 0 THEN
        crit_count := crit_count + 1;
        DBMS_OUTPUT.PUT_LINE(
          'CRITICAL: ' || inventory(idx).medicine_name ||
          ' | Batch: ' || inventory(idx).batch_no(i) ||
          ' | EXPIRED ' || ABS(days_left) || ' days ago!'
        );
        GOTO next_batch;
      END IF;

      -- Near expiry: less than or equal to 30 days
      IF days_left <= 30 THEN
        DBMS_OUTPUT.PUT_LINE(
          'WARNING: ' || inventory(idx).medicine_name ||
          ' | Batch: ' || inventory(idx).batch_no(i) ||
          ' | Expires in ' || days_left || ' days (' ||
          TO_CHAR(inventory(idx).expiry_date(i), 'DD-MON-YYYY') || ')'
        );
      END IF;

      <<next_batch>>
      NULL;

    END LOOP;

    idx := inventory.NEXT(idx);
  END LOOP;

  DBMS_OUTPUT.PUT_LINE(CHR(13));
  DBMS_OUTPUT.PUT_LINE(RPAD('-', 70, '-'));
  DBMS_OUTPUT.PUT_LINE('SUMMARY: ' || crit_count || ' batch(es) are already expired.');
  DBMS_OUTPUT.PUT_LINE('ACTION: Remove from shelf immediately and log for disposal.');
  DBMS_OUTPUT.PUT_LINE(CHR(13));
  DBMS_OUTPUT.PUT_LINE(RPAD('-', 70, '-'));


EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/