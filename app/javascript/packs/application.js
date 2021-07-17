import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
import "channels"

import '../css/tailwind.css';
import './swiper';

require("../preview");
require("../profile");
require("../chat");
require("../menu");

Rails.start()
// Turbolinks.start()