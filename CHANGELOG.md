# Changelog

## 0.2.3 ##

**Bugfix**

* Don't use symbol in session values, as they may be stringified with Rails 4.2.0

## 0.2.2 ##

**Bugfix**

* Fix controller requirement for ruby 2.1+

## 0.2.1 ##

**Feature**

* Add `currentuser_session` as helper (undocumented)

## 0.2.0

**Feature**

* Set `:sign_up` context in session (undocumented because unreliable yet)

**Refactoring**

* Change the way currentuser data is stored in session

## 0.1.0

**Improvement**

* **[Breaking change]** Use HTTP DELETE rather than HTTP GET for sign out
