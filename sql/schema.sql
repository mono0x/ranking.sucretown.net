-- for PostgreSQL

CREATE TABLE statuses (
  id BIGINT NOT NULL,
  created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  source TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE characters (
  id INTEGER NOT NULL,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (id)
);
CREATE UNIQUE INDEX unique_index_characters_name ON characters USING btree (name);

CREATE TABLE votes (
  character_id INTEGER NOT NULL,
  status_id BIGINT NOT NULL,
  PRIMARY KEY (character_id, status_id)
);
