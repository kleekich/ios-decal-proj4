# Pill Tracker

## Author: Kangsik Kevin Lee

## Purpose:
Athletes that take medications or supplements. What makes athletes distinct from <br />
other people that take pills is their more stringent diet, as well as how <br />
instrumental taking their pills can be to their performance. For medications, <br /> 
the need is pretty uniform no matter who is taking them. But supplements, which  <br />
usually have less drastic effects, can be essential to an athlete’s performance,  <br />
and because of this affect how well they can do their job and get paid.  <br />
In addition, because an athlete may already have dietary restrictions different <br /> 
than the general public, this app’s ability to warn the user of what not to eat  <br />
is a necessity. Athletes may also want to factor in how side effects of the  <br />
pills may affect their performance to weigh the benefits of taking a pill now or <br />
later,something we can further look into. <br />

## Features:
- There are two major features of this application. First, it helps people can  <br />
track of time they took the last pill, and it reminds them to take the next pill <br />
on time. For those who take daily medicine, it is very crucial to remember to  <br />
take their pills on time. Depending on a patient’s condition, missing a pill on  <br />
time can lead to a fatal situation. Also, it is very easy to lose track of the  <br />
time they took the last pill. Not only can patients benefit from this  <br />
application, but also people who take daily supplements such as vitamins and  <br />
pro-biotics. <br />
- The second major feature is providing information about foods or other  <br />
medicines to avoid. There are tons of pills, but not much widespread information <br /> 
about them. Some medicines can possibly react badly with some particular food.  <br />
Users can avoid the foods by checking the list, and they can avoid other drugs  <br />
if the application alerts users for possible reactions. It allows users to  <br />
set up for specific condition of users too such as pregnancy. <br />

## Control Flow: Low-fidelity
<img src="images/pill_tracker_wireframe-page-001.jpg" height="400" alt="Screenshot"/>
<img src="images/pill_tracker_wireframe-page-002.jpg" height="400" alt="Screenshot"/>
<img src="images/pill_tracker_wireframe-page-003.jpg" height="400" alt="Screenshot"/>

## Implementation

### Model
 - PillManager.swift
 - Medicine.swift
 - Supplement.swift
 - Food.swift
  
 
### View
 - MainView
 - CategoryView
 - AddMedicineView
 - MedicineListView
 - FoodsToAvoidView
 - MedicineAndFoodDetailView
 - ScheduleView

### Controller
 - MainViewController
 - CategoryViewController
 - AddMedicineViewController
 - MedicineListViewController
 - FoodsToAvoidViewController
 - MedicineAndFoodDetailViewController
 - ScheduleViewController
