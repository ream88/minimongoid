Package.describe({
  summary: "Mongoid inspired models."
});

Package.on_use(function (api) {
  api.use('coffeescript');
  api.add_files('minimongoid.coffee', 'server');
});

Package.on_test(function (api) {
  api.add_files('minimongoid_tests.coffee', 'server');
});
