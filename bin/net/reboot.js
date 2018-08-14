#!/usr/bin/node
const Browser = require("zombie");
describe('Reiniciando roteador NET', function () {

    const browser = new Browser();

    before(function (done) {
        browser.visit("http://192.168.0.1/", done);
    });

    describe('login', function () {
        browser
            .fill('loginUsername', 'admin')
            .fill('loginPassword', 'motorola')
            .pressButton("Login", function () {
                browser.visit("http://192.168.0.1/RgConfiguration.asp", function () {
                    browser.pressButton("Reboot");
                });
            });
    });

});