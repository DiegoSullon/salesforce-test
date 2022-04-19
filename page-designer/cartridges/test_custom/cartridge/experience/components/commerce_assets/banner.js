/* eslint-disable linebreak-style */
'use strict';
var Template = require('dw/util/Template');
var HashMap = require('dw/util/HashMap');
var ImageTransformation = require('*/cartridge/experience/utilities/ImageTransformation.js');
/**
 * Render logic for the component.
 */
module.exports.render = function (context) {
  var model = new HashMap();
  var content = context.content;

  model.image = ImageTransformation.getScaledImage(content.image);

  return new Template('experience/components/commerce_assets/banner').render(model).text;
};
