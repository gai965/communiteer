import Rails from "@rails/ujs"
import "channels"

import '../css/tailwind.css';
import '../css/preview.css';
import './swiper';

require("../preview");
require("../profile");
require("../chat");
require("../menu");
require("../formerror");

Rails.start()