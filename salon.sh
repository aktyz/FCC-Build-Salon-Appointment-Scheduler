#! /bin/bash

PSQL="psql -X -t --username=freecodecamp --dbname=salon -c"

START() {
  echo -e "\n~~~~~ MY SALON ~~~~~\n"
  echo -e "\nWelcome to My Salon, how can I help you?\n"
  SERVICE_MENU
}

BOOK_VISIT() {
  echo -e "\nGive me a moment before proceeding with booking your $2 visit"
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE
  # check if we have this customer
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
  # if not found
  if [[ -z $CUSTOMER_ID ]]
  then
    # ask for customer name
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    # create the customer
    CREATE_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE','$CUSTOMER_NAME');")
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE';")
  else
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE';")
  fi
  echo -e "\nWhat time would you like your $2, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')?"
  read SERVICE_TIME
  CREATE_APPOINTMENT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID,$1,'$SERVICE_TIME');")
  echo -e "\nI have put you down for a $2 at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//g')."
}

SERVICE_MENU() {
  # get available services
  AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services;")
  # display available service
  echo $AVAILABLE_SERVICES | sed 's/ | /,/g' | tr ' ' '\n' | while IFS=',' read SERVICE_ID SERVICE_NAME
  do
    echo "$SERVICE_ID) $SERVICE_NAME"
  done
  # read customer choice
  read SERVICE_ID_SELECTED
  # If you pick a service that doesn't exist,
  # you should be shown the same list of services again
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED;")
  echo $SERVICE_NAME
  if [[ -z $SERVICE_NAME ]]
  then
    echo "I could not find that service. What would you like today?"
    SERVICE_MENU
  else
    BOOK_VISIT $SERVICE_ID_SELECTED $SERVICE_NAME
  fi
}

START