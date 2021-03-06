_ = require('underscore')._
require ('should')
Factory = _.clone(require('../src/index').Factory)

describe Factory, ->
  before ->
    Factory.factories = {}

    class Profile extends Object

    Profile.buildOne = (attrs) ->
      new Profile(attrs)

    Profile.createOne = (attrs, callback) ->
      callback(null, new Profile(attrs))

    Factory.initializeWith = (klass, attributes, callback) ->
      callback(null, klass.buildOne(attributes))

    Factory.createWith = (klass, attributes, callback) ->
      klass.createOne(attributes, callback)

    Factory.define 'profile', class: Profile, ->
      @avatar_url = 'http://example.com/img.png'

  describe '#createWith', ->
    it 'should pass attributes to factory', ->
      Factory.create 'profile', (err, profile) ->
        profile.should.have.property('avatar_url', 'http://example.com/img.png')
