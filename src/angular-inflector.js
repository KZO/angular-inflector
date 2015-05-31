/*
 * angular-inflector
 *
 * Inflections for angular
 *
 * (c) 2014 KZO Innovations
 * License: MIT
 */

var Inflector = require('@kzo/inflector');

(function () {

  'use strict';

  /* jshint -W040 */
  angular.module('kzo.inflector', []).provider('inflector', function () {
    this.rules = {};
    this.$get = function () {
      var inflector = new Inflector();
      inflector._rules.plurals = this.rules.plurals || inflector._rules.plurals;
      inflector._rules.singular = this.rules.singular || inflector._rules.singular;
      inflector._rules.irregular = this.rules.irregular || inflector._rules.irregular;
      inflector._rules.uncountable = this.rules.uncountable || inflector._rules.uncountable;
      // console.log(inflector._rules.plurals);
      return inflector;
    };
  });

})();
