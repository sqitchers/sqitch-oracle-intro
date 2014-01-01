-- Deploy users
-- requires: appschema

CREATE TABLE flipr.users (
    nickname  VARCHAR2(512 CHAR) PRIMARY KEY,
    password  VARCHAR2(512 CHAR) NOT NULL,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);
