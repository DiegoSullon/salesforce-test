/* eslint-disable linebreak-style */
'use strict';

var Template = require('dw/util/Template');
var HashMap = require('dw/util/HashMap');
var PageRenderHelper = require('*/cartridge/experience/utilities/PageRenderHelper.js');
var RegionModelRegistry = require('*/cartridge/experience/utilities/RegionModelRegistry.js');
/**
 * Render logic for the page.
 */

module.exports.render = function (context) {
  var model = new HashMap();
  var page = context.page;
  model.page = page;
  // automatically register configured regions
  var metaDefinition = require('*/cartridge/experience/pages/promopage.json');
  model.regions = new RegionModelRegistry(page, metaDefinition);
  // Determine seo meta data.
  // Used in htmlhead.isml via common/layout/page.isml decoratod.
  model.currentPageMetaData = PageRenderHelper.getPageMetaData(page);
  model.currentPageMetaData = {};
  model.currentPageMetaData.title = page.pageTitle;
  model.currentPageMetaData.description = page.pageDescription;
  model.currentPageMetaData.keywords = page.pageKeywords;

  if (PageRenderHelper.isInEditMode()) {
    var HookManager = require('dw/system/HookMgr');
    HookManager.callHook('app.experience.editmode', 'editmode');
    model.resetEditPDMode = true;
  }
  // render the page
  return new Template('experience/pages/promopage').render(model).text;
};
