# OERu WordPress MultiSite Configuration

This is an outline of the WordPress Multisite configuration employed by the OERu for our [Course site](https://course.oeru.org).

## Plugins

The plugins employed: 

### 3rd party 

#### Dependencies

* [ARVE Advanced Responsive Video Embedder](https://wordpress.org/plugins/advanced-responsive-video-embedder/) - to implement responsive layout for videos.
* [Disable Comments](https://wordpress.org/plugins/disable-comments/)
* [Disable Site](https://wordpress.org/plugins/disable-site/)
* [Nginx Helper](https://wordpress.org/plugins/nginx-helper/)
* [Post SMTP](https://wordpress.org/plugins/post-smtp/)
* [WP Activity Log](https://wordpress.org/plugins/wp-security-audit-log/)
* [WP-Matomo](https://wordpress.org/plugins/wp-piwik/)

#### Admin/Convenience/Debug

* [Check Email](https://wordpress.org/plugins/check-email/)
* [Matomo Analytics](https://wordpress.org/plugins/matomo/)
* [Unconfirmed](https://wordpress.org/plugins/unconfirmed/)

#### Deprecated

These will be retired

* Google Analytics for WordPress

### OER Foundation authored

* [Blog Feed Finder](https://git.oeru.org/oeru/blog-feed-finder)
* [Cookie Notice - OERu version](https://git.oeru.org/oeru/oeru-wp-cookienotice)
* [Mautic Synchronise](https://git.oeru.org/oeru/wpms-mautic)
* [MultiSite Activity Register](https://git.oeru.org/oeru/wpms-activity-register)
* [OERu Register Enrol](https://git.oeru.org/oeru/register-enrol)
* [WEmath](https://git.oeru.org/oeru/wemath)
* [WEnotes](https://git.oeru.org/oeru/wenotes)
* [WEquizzes](https://git.oeru.org/oeru/wequizzes)

## OERu Theme

We use our own mobile-friendly (Bootstrap 3-based) theme (which supports multiple pre-defined colour palettes): [OERu Course](https://git.oeru.org/oeru/oeru_course)

To get the login prompt to display (top right of window) you must enable it in the theme settings for each subsite.
To do so:
* log in as an administrator for the subsite you want to change.
* go to "Customize" the theme, in the top menu bar. 
* in the left hand "Customizing" sidebar, select "Site Navigation" 
* and in the resulting overlay, set "Show the login option?" to "Yes". 
* save the change by clicking the "Publish" button at the top of the sidebar. 

## Notes

Each course is created via an automated "[Course Snapshot](https://git.oeru.org/wikieducator/course-snapshot)" process from [WikiEducator](https://wikieducator.org) (a MediaWiki instance).

An example is the OERu's [Learning In a Digital Age 101](https://course.oeru.org/lida101) course, which is constructed from this [outline](https://wikieducator.org/Learning_in_a_digital_age/_Outline_LiDA101) via the "Request snapshot" (created by a custom template) on the outline page. 


