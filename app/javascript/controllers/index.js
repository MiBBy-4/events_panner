// Import and register all your controllers from the importmap under controllers/*

import { application } from "./application";

import EventsController from "./events_controller";
application.register("events", EventsController)
