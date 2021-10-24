import Rails from "@rails/ujs"
import "channels"

import '../css/tailwind.css';
import '../css/preview.css';
// import '../css/pagination.css';
import './swiper';

require('jquery');
require("../preview");
require("../profile");
require("../menu");
require("../count");
require("../map");
require("../modal");

Rails.start()