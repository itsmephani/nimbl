function homeController($rootScope, $scope, $http, $location){
	if(localStorage.currentUser){
    window.location.href = 'dashboard';
  }
	$scope.login = function() {    
    var params = $.param({user: $scope.user});
    $http({
    method: 'POST',
    url: "api/users/sign_in",
    data: params,
    headers: {'Content-Type': 'application/x-www-form-urlencoded'}
    }).success(function(data) {
      	$scope.sError = false;
        $scope.msgText = "";      
        $rootScope.onLogin(data);
      }).error(function(data) {
      $scope.sError = true;
      $scope.msgText = data;
    });
  };
  
}
