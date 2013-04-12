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
  test.isTrue user.isPersisted()
  test.equal User.all()[0].attributes.name, 'John'

  id = user.id
  user.update
    name: 'Jane'
    _id: 'some id'
  test.isTrue user.isPersisted()
  test.equal User.all()[0].attributes.name, 'Jane'
  test.equal user.id, id


  user.attributes =
    name: 'Frank'
  test.isFalse user.save()


  user.destroy()
  test.isNull user.id


Tinytest.add 'minimongoid - class methods', (test) ->
  test.instanceOf User.new(name: 'Jane'), User
  test.isFalse User.new(name: 'John').isPersisted()


  test.instanceOf User.create(name: 'Jane'), User
  test.isTrue User.create(name: 'John').isPersisted()

  test.equal (user.attributes.name for user in User.all()), ['Jane', 'John']


  test.equal 'number', typeof User.count()


  User.destroyAll()
  test.equal User.count(), 0


class SuperUser extends User
  @_type: 'SuperUser'


Tinytest.add 'minimongoid - single table inheritance', (test) ->
  SuperUser.create name: 'John'
  test.instanceOf User.all()[0], SuperUser


  User.destroyAll()
