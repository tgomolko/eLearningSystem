# eLearnigSystem

This app is used for preparation and conduct of online courses, lectures or seminars. A user is able to view
public courses list, sign up for a course and take it online. A user has an opportunity to create and conduct
his/her own authors’ courses making them public or restrict to a limited user list. E-mailing, course
statistics, certificates are among app possibilities. The application provides course instructors with
convenient tools for making their educational process more efficient and interactive.

## Tech stack
- Ruby 2.6.2
- Rails 5.2.3
- JavaScript
- jQuery
- AJAX
- SideKiq
- Redis
- PostgreSQL

## Instalation

Clone the repository:

```
git clone https://github.com/tgomolko/eLearningSystem.git
```
Change into the directory:

```
cd eLearningSystem
```
Then run:
```
bundle install
```
```
rake db:migrate
```
Start local server
```
rails s
```

Go to your browser and open [http://localhost:3000](http://localhost:3000)

## Sample screenshots
**Main page**

![Screenshot from 2020-06-22 18-43-20](https://user-images.githubusercontent.com/22145273/85308190-96318a80-b4b9-11ea-84af-556230e3b5ad.png)

**User dashboard page**

![Screenshot from 2020-06-22 18-43-49](https://user-images.githubusercontent.com/22145273/85308283-b3feef80-b4b9-11ea-94ba-e529201b897e.png)

**Course creating page**

![Screenshot from 2020-06-22 18-57-03](https://user-images.githubusercontent.com/22145273/85308749-44d5cb00-b4ba-11ea-8ed6-563e56041a9b.png)

**Course preview page**

![Screenshot from 2020-06-22 18-44-42](https://user-images.githubusercontent.com/22145273/85308442-e3156100-b4b9-11ea-990a-ef1d2c2a1b04.png)
