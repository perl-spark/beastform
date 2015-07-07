BEGIN;

CREATE TABLE test1 (
  id SERIAL PRIMARY KEY,
  text_field VARCHAR NOT NULL,
  CHECK (text_field != 'error')
);

CREATE TABLE test2 (
  id SERIAL PRIMARY KEY,
  test1_id INT NOT NULL REFERENCES test1 CHECK (test1_id < 1000)
);

CREATE TABLE test3 (
  id SERIAL PRIMARY KEY,
  unique_int INT NOT NULL,
  registered TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  extra JSONB NOT NULL DEFAULT '{}'::JSONB,
  UNIQUE(unique_int)
);

CREATE TABLE test4 (
  test1_id INT NOT NULL REFERENCES test1,
  test2_id INT NOT NULL,
  unique_int INT NOT NULL UNIQUE,
  PRIMARY KEY (test1_id, test2_id),
  FOREIGN KEY (test2_id) REFERENCES test2
);

-- CREATE VIEW test5 (t1, t2, t4) AS
--   SELECT test1.id, test2.id, test4.id
--   FROM test1
--   LEFT JOIN test2
--     ON test1.id = test2.test1_id
--   JOIN test4
--     ON test4.test1_id = test1.id
--     AND test4.test2_id = test2.id;

-- CREATE FUNCTION test6(val integer)
--   RETURNS integer as $$
--   BEGIN
--     RETURN val + 1;
--   END;
--   LANGUAGE PLPGSQL;

-- CREATE TRIGGER test7
--   BEFORE INSERT
--   ON test4
--   FOR EACH ROW
--   EXECUTE PROCEDURE

COMMIT;
