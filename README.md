# README

# Adopt Dont Shop

## Table of Contents

- [Overview](#overview)
- [Learning Goals](#learning-goals)
- [Tools Used](#tools-used)
- [Features](#features)
- [Database Schema](#database-schema)

## Overview

[Adopt Don't Shop](https://enigmatic-coast-35919.herokuapp.com/) is a week long paired project during Mod 2 of Turing School's Back-End Engineering program.

The goal was to create a functioning Rails Application that can take users through a website and give them the ability to Create, Read, Update, and Destroy data while being able to view the changes on the website (Rails Application).

## Learning Goals

Learning goals and areas of focus consisted of:
- Build out CRUD functionality for a many to many relationship
- Use ActiveRecord to write queries that join multiple tables of data together
- Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
- Validate models and handle sad paths for invalid data input
- Use flash messages to give feedback to the user
- Use partials in views
- Use within blocks in tests
- Track user stories using GitHub Projects
- Deploy an application to Heroku

The project home page and requirements can be found [here](https://github.com/turingschool-examples/adopt_dont_shop).

## Tools Used
 - Ruby 2.7.4
 - Rails 5.2.7
 - RSpec (capybara, orderly, shoulda matchers, simplecov)
 - PostgreSQL
 - dbdiagram.io

## Features

From the main page, the user will be able to navigate through adoption *Shelters* and their *Pets*, as well as *Veterinarian Offices* and their *Veterinarians*. The user can search for *pets* to create and submit an *application* to adopt one or more *pets*. An Admin can then approve or reject an application (from /admin/applications/*:id*). Approval of an *application* will make a *pet* un-adoptable on other *applications*.

## Database Schema
