# OERu WordPress MultiSite Configuration

This is an outline of the WordPress Multisite configuration employed by the OERu for our Course site, https://course.oeru.org.

## Theme

We employ a custom WordPress theme, oeru-course, available at https://git.oeru.org/oeru/oeru_course 

## Plugins

The plugins employed: 

### 3rd party 

#### Dependencies

* ARVE Advanced Responsive Video Embedder - 
* Disable Comments
* Disable Site
* Nginx Helper
* Post SMTP
* WP Activity Log
* WP-Matomo

#### Admin/Convenience/Debug

* Check Email
* Matomo Analytics - Ethical Stats. Powerful Insights.
* Unconfirmed

#### Deprecated

These will be retired

* Google Analytics for WordPress


### OER Foundation authored

#### Dependencies

* [Blog Feed Finder](https://git.oeru.org/oeru/blog-feed-finder)
* [Cookie Notice - OERu version](https://git.oeru.org/oeru/oeru-wp-cookienotice)
* [Mautic Synchronise](https://git.oeru.org/oeru/wpms-mautic)
* [MultiSite Activity Register](https://git.oeru.org/oeru/wpms-activity-register)
* [OERu Register Enrol](https://git.oeru.org/oeru/register-enrol)
* [WEmath](https://git.oeru.org/oeru/wemath)
* [WEnotes](https://git.oeru.org/oeru/wenotes)
* [WEquizzes](https://git.oeru.org/oeru/wequizzes)

## Notes

Each course is created via an automated "[Course Snapshot](https://git.oeru.org/wikieducator/course-snapshot)" process from [WikiEducator](https://wikieducator.org) (a MediaWiki instance).

An example is the OERu's [Learning In a Digital Age 101](https://course.oeru.org/lida101) course, which is constructed from this [outline](https://wikieducator.org/Learning_in_a_digital_age/_Outline_LiDA101) via the "Request snapshot" (created by a custom template) on the outline page. 


