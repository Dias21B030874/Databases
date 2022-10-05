create table student(
    id int primary key,
    full_name varchar not null,
    age int not null,
    birth_date date not null,
    gender varchar check(gender in('male', 'female')) not null,
    average_grade float not null,
    personal_information text,
    need_for_a_dormitory boolean not null,
    additional_info text
);
create table instructor(
    id int primary key,
    full_name varchar not null,
    speaking_languages varchar not null,
    work_experience_in_years int not null,
    possibility_of_having_remote_lessons boolean not null
);
create table lesson_participants(
    lesson_title varchar not null,
    teaching_instructor int not null,
    studying_students int not null,
    room_number int not null,
    constraint c primary key(lesson_title, teaching_instructor, studying_students),
    foreign key(teaching_instructor) references instructor(id),
    foreign key(studying_students) references student(id)
);