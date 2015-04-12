app.controller('searchController', ['$scope', '$http', function($scope, $http){
  $scope.model = {q: "", csv_file: ""};
  
  $scope.search = function(){
    $scope.model.csv_file = document.getElementById('file').files[0];
    $scope.multipart = true;
    $http.get('/search/', {params: $scope.model}).success(function(data){
      alert(data);
    });    
  }
}]);
