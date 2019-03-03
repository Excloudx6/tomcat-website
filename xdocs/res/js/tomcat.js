/*
  Licensed to the Apache Software Foundation (ASF) under one or more
  contributor license agreements.  See the NOTICE file distributed with
  this work for additional information regarding copyright ownership.
  The ASF licenses this file to You under the Apache License, Version 2.0
  (the "License"); you may not use this file except in compliance with
  the License.  You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
*/
$(function(){

  var $fontSizeSlider = $("#font-size");
  $fontSizeSlider.val(windowFontSize);

  $(window).scroll(function(e){
    var sticky = 100;
    var $body = $("body");
    var top = $(this).scrollTop();
    if (top == 0){
      $body.removeClass("scrolled scrolled-sticky");
    }
    else {
      $body.addClass("scrolled");
      if (top >= sticky){
        $body.addClass("scrolled-sticky");
      }
      else {
        $body.removeClass("scrolled-sticky");
      }
    }
  });

  $fontSizeSlider.on("change", function(e){
    setFontsize($(this).val());
  });
  
}); // ready
