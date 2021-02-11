goog.module('example.routeguide.grpc_web.client.run');

/**
 * Main entry point
 */
exports = function() {
    const Client = goog.require('example.routeguide.grpc_web.Client');
    const client = new Client("localhost", null, null);
    client.run();
};
