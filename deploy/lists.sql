-- Deploy lists
-- requires: appschema
-- requires: users

CREATE TABLE flipr.lists (
    nickname    VARCHAR2(512 CHAR)  NOT NULL REFERENCES flipr.users(nickname),
    name        VARCHAR2(512 CHAR)  NOT NULL,
    description VARCHAR2(512 CHAR)  NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);
