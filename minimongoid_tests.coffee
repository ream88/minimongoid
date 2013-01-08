class User extends Minimongoid
  @_collection: new Meteor.Collection 'minimongoid_tests'

  isValid: ->
    @attributes.name.match /John|Jane/


Tinytest.add 'minimongoid - instance methods', (test) ->
  user = new User
    name: 'John'


  test.equal user.attributes, name: 'John'
  test.isFalse user.isPersisted()
  test.isUndefined user.id


  user.save()
  id = user.id
  test.isTrue user.isPersisted()
  test.equal User._collection.findOne(id), user.attributes


  user.update
    name: 'Jane'
    _id: 'some id'
  test.isTrue user.isPersisted()
  test.equal User._collection.findOne(id), name: 'Jane', _id: id


  user.attributes =
    name: 'Frank'
  test.isFalse user.save()


  user.destroy()
  test.isUndefined user.id


Tinytest.add 'minimongoid - class methods', (test) ->
  test.instanceOf User.new(name: 'Jane'), User
  test.isFalse User.new(name: 'Jane').isPersisted()


  test.instanceOf User.create(name: 'Jane'), User
  test.isTrue User.create(name: 'Jane').isPersisted()


  test.equal User._collection.find().fetch(), User.where().fetch()
  test.equal User._collection.find().fetch(), User.all().fetch()


  test.equal (new User(object) for object in User._collection.find().fetch()), User.toArray()


  test.equal 'number', typeof User.count()


  User.destroyAll()
  test.equal 0, User.count()

