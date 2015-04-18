app.controller('searchController', ['$scope', '$http', function($scope, $http){
  $scope.model = {q: "", scope: "having_keyword", offset: 0, limit: 10};
  
  $scope.acceptTypes = ['csv'];
  $scope.ceil = window.Math.ceil;
  $scope.search = function(){
    $scope.searching = true;
    $scope.model.offset = 0;
    if($scope.model.q)
      $http.get('/api/results/', {params: $scope.model}).success(function(data){
        console.log(data);
        $scope.data = data;
        $scope.model.q = data.keyword.keyword;
        $scope.searching = false;
      }).error(function(data){
        $scope.searching = false;
      });    
  }

  
  $scope.onComplete = function(response){
    $scope.responseMessage = response.data.message;
    $scope.responseStatus = response.status;
    $scope.searching = false;
    $scope.data = data;    
    $scope.model.q = data.keyword.keyword;
  }

  $scope.$watch('model.offset', function(){
    if($scope.model.q)
      $scope.search();
  });
}]);
