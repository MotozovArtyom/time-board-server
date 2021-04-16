CREATE TABLE group_task (
    id VARCHAR(36) NOT NULL,
    name VARCHAR(100) NOT NULL,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

CREATE TABLE account (
    id VARCHAR(36) NOT NULL,
    login VARCHAR(256) NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(256) NOT NULL,
    first_name VARCHAR(256) NOT NULL,
    second_name VARCHAR(256) NOT NULL,
    creation_date DATE NOT NULL,
    version INTEGER NOT NULL DEFAULT 0,
    icon_url TEXT NULL,
    PRIMARY KEY (id)
    );

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

INSERT INTO account(id, login, password, email, first_name, second_name, creation_date)
VALUES ('bb951eda-a219-4f39-ac90-6af6c0a6af78', 'admin', 'admin', 'motozov.a.v@gmail.com', 'Admin', 'Admin', NOW());

CREATE TABLE project_schema (
    id VARCHAR(36) NOT NULL,
    account VARCHAR(36) NOT NULL
        CONSTRAINT "FK_project_schema__account"
            REFERENCES account
            ON DELETE RESTRICT,
    user_in_project VARCHAR(36) NULL,
    project_schema VARCHAR(100) NOT NULL,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

INSERT INTO project_schema(id, account, user_in_project, project_schema)
VALUES ('f98e0fec-9230-4937-8f39-178f50c04666', 'bb951eda-a219-4f39-ac90-6af6c0a6af78',
        'dccb81a8-c935-4d5e-be81-a522faf692f3', 'project_test');

CREATE TABLE personal_task (
    id VARCHAR(36) NOT NULL,
    creation_date DATE NOT NULL,
    done_date DATE NULL,
    is_done BOOLEAN NOT NULL DEFAULT FALSE,
    description TEXT NULL,
    name VARCHAR(100) NOT NULL,
    group_task VARCHAR(36) NULL
        CONSTRAINT "FK_task__group"
            REFERENCES group_task
            ON DELETE RESTRICT,
    account VARCHAR(36) NOT NULL
        CONSTRAINT "FK_task__account"
            REFERENCES account
            ON DELETE RESTRICT,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

CREATE TABLE personal_task_attachment (
    id VARCHAR(36) NOT NULL,
    attachment_name VARCHAR(256) NOT NULL,
    url VARCHAR(256) NOT NULL,
    personal_task VARCHAR(36) NOT NULL
        CONSTRAINT "FK_task_attachment__task"
            REFERENCES personal_task
            ON DELETE RESTRICT,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

CREATE TABLE project_dashboard (
    id VARCHAR(36) NOT NULL,
    project_name VARCHAR(256) NOT NULL,
    project_code VARCHAR(10) NOT NULL UNIQUE,
    creation_date DATE NOT NULL,
    description TEXT NULL,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

INSERT INTO project_dashboard(id, project_name, project_code, creation_date, description)
VALUES ('d17666d0-7c75-4da6-9bd3-e187ed482257', 'project_test', 'PT', NOW(), 'project_test');

CREATE TABLE project_user (
    id VARCHAR(36) NOT NULL,
    project_schema VARCHAR(36) NOT NULL,
    joining_date DATE NOT NULL,
    leaving_date DATE NULL,
    project VARCHAR(36) NOT NULL
        CONSTRAINT "FK_project_user__project_dashboard"
            REFERENCES project_dashboard
            ON DELETE RESTRICT,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

INSERT INTO project_user(id, project_schema, joining_date, leaving_date, project)
VALUES (uuid_generate_v4(), 'f98e0fec-9230-4937-8f39-178f50c04666', NOW(), NULL,
        'd17666d0-7c75-4da6-9bd3-e187ed482257');

CREATE TABLE role (
    id VARCHAR(36) NOT NULL,
    name VARCHAR(100) NOT NULL UNIQUE,
    access_level INTEGER NOT NULL UNIQUE,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

INSERT INTO role(id, name, access_level)
VALUES (uuid_generate_v4(), 'Admin', 100),
       (uuid_generate_v4(), 'Moderator', 90),
       (uuid_generate_v4(), 'Viewer', 80),
       (uuid_generate_v4(), 'Guest', 0);

CREATE TABLE user_role (
    id VARCHAR(36) NOT NULL,
    project_user VARCHAR(36) NOT NULL
        CONSTRAINT "FK_user_role__project_user"
            REFERENCES project_user
            ON DELETE RESTRICT,
    role VARCHAR(36) NOT NULL
        CONSTRAINT "FK_user_role__role"
            REFERENCES role
            ON DELETE RESTRICT,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

CREATE TABLE step (
    id VARCHAR(36) NOT NULL,
    name VARCHAR(50) NOT NULL,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

INSERT INTO step(id, name)
VALUES (uuid_generate_v4(), 'TO DO'),
       (uuid_generate_v4(), 'IN PROGRESS'),
       (uuid_generate_v4(), 'DONE');


CREATE TABLE task (
    id VARCHAR(36) NOT NULL,
    number INTEGER NOT NULL,
    full_code VARCHAR(50) NOT NULL UNIQUE,
    creation_date DATE NOT NULL,
    done_date DATE NULL,
    last_modified DATE NOT NULL,
    description TEXT NULL,
    name VARCHAR(256) NOT NULL,
    project VARCHAR(36) NOT NULL
        CONSTRAINT "FK_task__project_dashboard"
            REFERENCES project_dashboard
            ON DELETE RESTRICT,
    step VARCHAR(36) NOT NULL
        CONSTRAINT "FK_task__step"
            REFERENCES step
            ON DELETE RESTRICT,
    group_task VARCHAR(36) NOT NULL
        CONSTRAINT "FK_task__group_task"
            REFERENCES group_task
            ON DELETE RESTRICT,
    executor VARCHAR(36) NOT NULL
        CONSTRAINT "FK_task__project_user_executor"
            REFERENCES project_user
            ON DELETE RESTRICT,
    reporter VARCHAR(36) NOT NULL
        CONSTRAINT "FK_task__project_user_reporter"
            REFERENCES project_user
            ON DELETE RESTRICT,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

CREATE TABLE task_observer (
    id VARCHAR(36) NOT NULL,
    task VARCHAR(36) NULL
        CONSTRAINT "FK_task_observer__task"
            REFERENCES task
            ON DELETE RESTRICT,
    observer VARCHAR(36) NOT NULL
        CONSTRAINT "FK_task_observer__project_user"
            REFERENCES project_user
            ON DELETE RESTRICT,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

CREATE TABLE comment (
    id VARCHAR(36) NOT NULL,
    creation_date DATE NOT NULL,
    last_modified_date DATE NOT NULL,
    author VARCHAR(36) NOT NULL
        CONSTRAINT "FK_commit__project_user"
            REFERENCES project_user
            ON DELETE SET NULL,
    task VARCHAR(36) NOT NULL
        CONSTRAINT "FK_commit__task"
            REFERENCES task
            ON DELETE SET NULL,
    comment_text TEXT NOT NULL,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

CREATE TABLE task_attachment (
    id VARCHAR(36) NOT NULL,
    personalTask VARCHAR(36) NULL
        CONSTRAINT "FK_task_attachment__task"
            REFERENCES task
            ON DELETE RESTRICT,
    attachment_name VARCHAR(256) NOT NULL,
    url VARCHAR(256) NOT NULL,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

CREATE TABLE comment_attachment (
    id VARCHAR(36) NOT NULL,
    comment VARCHAR(36) NULL
        CONSTRAINT "FK_task_attachment__comment"
            REFERENCES comment
            ON DELETE SET NULL,
    attachment_name VARCHAR(256) NOT NULL,
    url VARCHAR(256) NOT NULL,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

CREATE TABLE commit (
    id VARCHAR(36) NOT NULL,
    date DATE NOT NULL,
    hash VARCHAR(16) NOT NULL,
    diff_url VARCHAR(256) NOT NULL,
    message TEXT NOT NULL,
    author VARCHAR(36) NOT NULL
        CONSTRAINT "FK_commit__project_user"
            REFERENCES project_user
            ON DELETE SET NULL,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );

CREATE TABLE task_commit (
    id VARCHAR(36) NOT NULL,
    personalTask VARCHAR(36) NULL
        CONSTRAINT "FK_task_commit__task"
            REFERENCES task
            ON DELETE RESTRICT,
    commit VARCHAR(36) NULL
        CONSTRAINT "FK_task_commit__commit"
            REFERENCES commit
            ON DELETE SET NULL,
    version INTEGER NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
    );