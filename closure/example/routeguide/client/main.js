goog.module('example.routeguide.client.run');

/**
 * Main entry point
 */
exports = function () {
    const Client = goog.require('example.routeguide.Client');
    const client = new Client();
    client.run();
};
