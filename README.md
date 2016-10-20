Open Source Events Calender
===========================

To add or make changes to the calendar, mention @ose_calendar on twitter using
the following command structure.

This command would rename event id 5 to "Ohio Linux Fest"
Example: @ose_calendar -id 5 -name Ohio Linux Fest

This command would delete an event.
Example: @ose_calendar -id 5 -delete

When you do not provide an Id then it will create a new event. When you provide
an id the event will be edited.

Commands:

-id     | Unique id of the event.
-name   | Name of the event.
-starts | The first day of the event.
-ends   | Last day of the event.

-delete | Will delete the event.
