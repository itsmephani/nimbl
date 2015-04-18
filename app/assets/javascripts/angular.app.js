var app = angular.module('app', ['lr.upload']);

app.config([
  "$httpProvider", function($httpProvider) {
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  }
]);

app.config(function($httpProvider) {
  var interceptor = function($q, $location) {
    return {
      'responseError': function(rejection) {
        if (rejection.status == 401) {
          if ($location.path().indexOf('login') < 0) {
            $location.path('/sign_out');
          }
        }
        if (rejection.status == 403) {
          $location.path('/dash_board');
        }
        return $q.reject(rejection);
      }
    };
  };
  $httpProvider.interceptors.push(interceptor);
});

app.run(function($http, $rootScope, $location){
  
  if(localStorage.email && window.location.pathname == "/"){
    $rootScope.email = localStorage.email;
    window.location.href = 'dashboard';
  }

  $rootScope.onLogin = function(data){
    $rootScope.email = data.email;
    localStorage.setItem('currentUser', true);
    localStorage.setItem('isAdmin', data.is_admin);
    localStorage.setItem('email', data.email);
    window.location.href = 'dashboard';
  }

    
});
