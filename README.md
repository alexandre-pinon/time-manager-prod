# THEME 00

### All users can :

- Edit their account information.
- Delete their account.
- Report their departure and arrival times.
- View their dashboards.

### The managers and general manager can :

- Manage their team(s).
- View the averages of the daily and weekly hours of the team over a given period.
- View the daily and weekly working hours of an employee over a period of time.
- View their employees’ dashboards .

### The general manager can :

- Promote a user from the rank of employee to manager.
- View the dashboards of all users.
- Delete accounts from all users.

---

# THEME 01

## USER

- a GET method : http://localhost:4000/api/users?email=XXX&username=YYY
- a GET method : http://localhost:4000/api/users/:userID
- a POST method : http://localhost:4000/api/users
- a PUT method : http://localhost:4000/api/users/:userID
- a DELETE method : http://localhost:4000/api/users/:userID

## WORKING TIME

- a GET (ALL) method : http://localhost:4000/api/workingtimes/:userID?start=XXX&end=YYY
- a GET (ONE) method : http://localhost:4000/api/workingtimes/:userID/:id
- a POST method : http://localhost:4000/api/workingtimes/:userID
- a PUT method : http://localhost:4000/api/workingtimes/:id
- a DELETE method : http://localhost:4000/api/workingtimes/:id

## CLOCKING

- a GET method : http://localhost:4000/api/clocks/:userID
- a POST method : http://localhost:4000/api/clocks/:userID

---

# THEME 02

## User (on all pages)

- getUser()
- createUser()
- updateUser()
- deleteUser()

## WorkingTimes

- has userID
- getWorkingTimes()

## WorkingTime

- createWorkingTime()
- updateWorkingTime()
- deleteWorkingTime()

## ClockManager

- has startDateTime data (is worth null if no work period is in progress)
- has clockIn (a boolean that is true if a work period is in progress)
- refresh() (sync api clock with front clock)
- clock() (to pass from active to inactive and vice versa).

## ChartManager

- Three graphs, configurable, and of different types (bar, line, pie, radar, ...)

---

# THEME 03

## Docker containers

- front
- api
- db (with persistence !)

## GCP - GKE

- application must be hosted on a server available on the internet

## GCP - CloudBuild

- CI/CD: Build, Test, Deploy

---

# THEME 04

## Employees

- separate night/day time
- separate overtime
- handle the case where the user forgets to clock out
- have phone app

## Managers

- time tracking goals
- show vacation and off days
- alert if an employee works more than 3 times a week at night
- allow to validate multiple employees workingtimes at once

## General Manager

- Log manager & admin updates

---

# THEME 05

## API

- 3 roles : user, manager, admin
- team CRUD
- auth routes with JWT (usin Joken)
- handle route permissions

## Front

- user register/login/logout
- role promotion/demotion (if admin)
- team CRUD
- sync graph with teams

---

# THEME 06

## Responsive

- all page must have a mobile version, except **Dashboard**
- handle authentication
- side navigation

## Offline Mode

- use local storage
- check internet connection

---

# THEME 07

## Security Gaps

- are they injectable (XSS, Script, HTML, . . . ) ?<br>
  **NO** -> Ecto (ORM)
- are they vulnerable to sql injections, nosql ?<br>
  **NO** -> Ecto (ORM)
- are there accessible configuration files ?<br>
  **NO** -> Config inside GKE
- are password hashes difficult to break ?<br>
  **YES** -> POW PBKDF2-SHA512 hash
- are routes accessible by unauthorized users ?<br>
  **NO** -> JWT & Role Check
- are endpoints accessible by unauthorized users ?<br>
  **NO** -> JWT & Role Check
- is it possible to fill the database and cause a denial of service when rendering the page ?<br>
  **YES**
- are JWT tokens http-only ? If not, how to recover these tokens ?<br>
  **NO** -> Local storage
- are the passwords sent in clear ? If so how do you recover them ?<br>
  **NO** -> HTTPS requests
- is the application available only in https ? if not, how could a malicious user intercept a client’s requests
  to your server ?<br>
  **YES**
