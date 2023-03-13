# FCC-Build-a-Salon-Appointment-Scheduler
One of the projects to complete [FreeCodeCamp Relational Database Certification](https://www.freecodecamp.org/learn/relational-database/)

## Learn Advanced Bash by Building a Kitty Ipsum Translator notes

```sh
echo hello bash > stdout.txt #will create/overwrite file
echo hello bash >> stdout.txt #will append the file
> stdout.txt #a way to empty the file (redirect nothing into the file)
```

### Two types of bash output
- standard out
```sh
stdout #redirect it with '>' or '>>' or '1>' eg.:
echo 'some text' > file.txt
echo -e '\nnew line' >> file.txt
<commands with an output> >> file.txt
```
- standard error
```sh
stderr #redirect it with '2>' eg.:
bad_command 2> stderr.txt
```

### Standard bash input
stdin is by default set to keyboard
'read' command is used to get it
We have different ways to redirect the stdin:
1. '<' to redirect it, using it you don't need 'cat' or 'echo' commands
```sh
read NAME < name.txt
```
2. 'cat' command - will print the contents of a file or input to stdout
```sh
cat
cat name.txt
cat < name.txt
```
3. use pipe '|'
```sh
echo Zyta | read NAME
echo Zyta | cat
```
> **Difference between '<' and '|'**
> <br>Below commands will produce the same output
```sh
sed 's/freecodecamp/f233C0d3C@mp/i' < name.txt
cat name.txt | sed 's/freecodecamp/f233C0d3C@mp/i'
```

Another example of different use cases - translate.sh will cat the first argument:
```sh
./translate.sh kitty_ipsum_1.txt
./translate.sh < kitty_ipsum_1.txt
cat kitty_ipsum_1.txt | ./translate.sh
```


#### Play with stdin, stdout & stderr of a bash script
1. Create an executable script with content:
```sh
#!/bin/bash
read NAME
echo Hello $NAME
bad_command
```
2. run it several times with:
```sh
./script.sh
echo anything | ./script.sh
echo anything | ./script.sh 2> stderr.txt
echo anything | ./script.sh 2> stderr.txt > stdout.txt
./script.sh < name.txt
./script.sh < name.txt 2> stderr.txt
./script.sh < name.txt 2> stderr.txt > stdout.txt
```

### Useful bash commands for plying with files
1. 'cat' and 'wc'
```sh
cat file.txt #concatenate files and print on the standard output
wc file.txt #word count with possible flags: '-l', '-w', '-m'(characters)
cat file.txt | wc
wc < file.txt
```
2. 'grep', it supports RegEx
```sh
grep '<pattern>' file.txt
grep --color -n 'line' mangrep.txt
grep -o '<pattern>' file.txt eg.:
grep -o 'meow[a-z]*' kitty_ipsum_1.txt | wc -l #will count the pattern appearence
./translate.sh kitty_ipsum_1.txt | grep --color 'dog[a-z]*|woof[a-z]*'
./translate.sh kitty_ipsum_1.txt | grep --color 'dog[a-z]*|woof[a-z]*' -E
```

3. 'sed' - stream editor for filtering and transformint text, case sensitive
```sh
sed 's/<pattern_to_replace>/<text_to_replace_it_with>/' <filename>

sed 's/freecodecamp/f233C0d3C@mp/i' < name.txt
cat name.txt | sed 's/freecodecamp/f233C0d3C@mp/i'
cat kitty_ipsum_1.txt | sed 's/catnip/dogchow/; s/cat/dog/' #replacing many stuff at once

echo freeCodeCamp | sed 's/r/2/'
echo freeCodeCamp | sed 's/freecodecamp/f233C0d3C@mp/'
echo freeCodeCamp | sed 's/freecodecamp/f233C0d3C@mp/i'
echo freeCodeCampfreeCodeCamp | sed 's/freeCodeCamp/f233C0d3C@mp/'
echo freeCodeCampfreeCodeCamp | sed 's/freeCodeCamp/f233C0d3C@mp/g'

grep -n 'meow[a-z]*' kitty_ipsum_1.txt | sed -E 's/[0-9]+/1/'
grep -n 'meow[a-z]*' kitty_ipsum_1.txt | sed -E 's/([0-9]+)/\1/'
grep -n 'meow[a-z]*' kitty_ipsum_1.txt | sed -E 's/([0-9]+).*/\1/'

grep -n 'cat[a-z]*' kitty_ipsum_2.txt
grep -n 'cat[a-z]*' kitty_ipsum_2.txt | sed -E 's/[0-9]+/1/'
grep -n 'cat[a-z]*' kitty_ipsum_2.txt | sed -E 's/([0-9]+).*/1/'
grep -n 'cat[a-z]*' kitty_ipsum_2.txt | sed -E 's/([0-9]+).*/\1/' #get line numbers that pattern appears on
```
4. 'diff' to compare files line by line
```sh
diff --color kitty_ipsum_1.txt doggy_ipsum_1.txt
```

5. 'tr/ - translate or delete characters



## Learn bash and SQL by building a bike rental shop

### New SQL commands
Specifying default value of the column value:<br>
```sql
ALTER TABLE bikes ADD COLUMN available BOOLEAN NOT NULL DEFAULT true;
```

### Bash SubShell
Pattern to open a sub-shell in bash:
```sh
<command> | <command> | $(<sub-shell command>) | <command>
echo "$(echo '   M e   ' | sed -E 's/^ *| *$//g')."
```

## What is still left to do in the projects
You should display a numbered list of the services you offer before the first prompt for input, each with the format #) <service>. For example, 1) cut, where 1 is the service_id

If you pick a service that doesn't exist, you should be shown the same list of services again

Your script should prompt users to enter a service_id, phone number, a name if they aren’t already a customer, and a time. You should use read to read these inputs into variables named SERVICE_ID_SELECTED, CUSTOMER_PHONE, CUSTOMER_NAME, and SERVICE_TIME

If a phone number entered doesn’t exist, you should get the customers name and enter it, and the phone number, into the customers table

You can create a row in the appointments table by running your script and entering 1, 555-555-5555, Fabio, 10:30 at each request for input if that phone number isn’t in the customers table. The row should have the customer_id for that customer, and the service_id for the service entered

You can create another row in the appointments table by running your script and entering 2, 555-555-5555, 11am at each request for input if that phone number is already in the customers table. The row should have the customer_id for that customer, and the service_id for the service entered

After an appointment is successfully added, you should output the message I have put you down for a <service> at <time>, <name>. For example, if the user chooses cut as the service, 10:30 is entered for the time, and their name is Fabio in the database the output would be I have put you down for a cut at 10:30, Fabio. Make sure your script finishes running after completing any of the tasks above, or else the tests won't pass











