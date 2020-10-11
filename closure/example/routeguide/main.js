goog.module('my.jspb.test.main');

const ProtoMap = goog.require('jspb.Map');

/**
 * Main entry point for the application.
 */
exports = function() {

  // Increase stacktrace limit in chrome
  Error['stackTraceLimit'] = 150;

  const protoMap = new ProtoMap([]);
  console.log("ok", protoMap);
};
