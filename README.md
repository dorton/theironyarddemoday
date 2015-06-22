#The Iron Yard Demo Day Site/Printable

This site uses [Middleman](https://github.com/middleman/middleman) to create a static HTML page on GitHub Pages. It is
formatted to be able to print to show one profile per page. Below are
instructions on how to deploy.

#Getting Started

1. Clone repository:
```bash 
$ git clone https://github.com/dorton/theironyarddemoday.git
```
2. Move into theironyarddemoday folder:
```bash 
$ cd theironyarddemoday
```
#Add to your Github Repository
Create a repo in Github.

```bash
$ git init
```

```bash
$ git remote add (THE NEW GITHUB REPO SSH OR HTTPS URL)
```

#Add Student Project Info
Look at file ```responses.csv``` in the data directory - ```data/responses.csv```. Headers need to stay the same. [This](http://goo.gl/wRJ6Nc) was the Google Form that I created to handle it.  Again, the headers for the .csv file must stay the same. If you use a form or new file, copy the questions exactly and add them as the header, or the data will not be pulled in.


#Add Staff Info
Edit the file ```staff.csv``` in the data directory - ```data/staff.csv```.  Headers for this .csv file must stay the same.

#Deploy

```bash
$ Middleman build
```

```bash
$ Middleman deploy
```

Site will be on your github pages ```username.github.io/repo_name ```
