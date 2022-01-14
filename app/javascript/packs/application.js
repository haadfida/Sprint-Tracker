global.$ = global.jQuery = require("jquery");
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import dt from "datatables.net";
import 'datatables.net-bs5'; 
import "chartkick/chart.js";

require('../app');
require('select2')
require('datatables.net-bs5')
require("bootstrap")
require("../app.js")
require("flatpickr");

Rails.start()
ActiveStorage.start()

