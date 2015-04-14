app.controller('searchController', ['$scope', '$http', function($scope, $http){
  $scope.model = {q: ""};
  
  $scope.acceptTypes = ['csv'];
  
  $scope.search = function(){
    $scope.searching = true;
    $http.get('/api/search/', {params: $scope.model}).success(function(data){
      alert(data);
      $scope.searching = false;
    }).error(function(data){
      $scope.searching = false;
    });    
  }

  
  $scope.onComplete = function(response){
    $scope.responseMessage = response.data.message;
    $scope.responseStatus = response.status;
    $scope.searching = false;
  }
}]);
