function fn() {
  var env = karate.env; // get system property 'karate.env'
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
	myVarName: 'someValue'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';

    config.appUrl = 'https://637f02becfdbfd9a63bb8a98.mockapi.io/';
  }
  karate.log('karate.env system property was:', env);
  return config;
}