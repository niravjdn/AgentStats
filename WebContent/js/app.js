var myApp = angular.module('myApp', []);

myApp.controller('typeAheadCtrl', ['$scope', '$http', function ($scope, $http) {
    $scope.personList = [];
    /*$scope.typelistload = function() {
        $http.get(
            'http://localhost:8080/SpringMVCHibernate/Person/getPersonList'
        ).success(function(data) {
            $scope.personList = data;
        }).error(function() {
            ngToast.danger( "Some problem in Listing:");
        });
    };*/

    $http.get('json/Bofa2.json').then(function (response) {
        //alert(response.data);
        return response.data;
    });

}]);