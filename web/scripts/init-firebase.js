//<!--
console.log('Инициализируем firebase');
var firebaseConfig = {
    apiKey: "AIzaSyDmH0XGjsFz9kM3PyhVtNDcj1zip4v_33o",
    authDomain: "awesome1c.firebaseapp.com",
    databaseURL: "https://awesome1c.firebaseio.com",
    projectId: "awesome1c",
    storageBucket: "awesome1c.appspot.com",
    messagingSenderId: "695512621921",
    appId: "1:695512621921:web:2236fde8a74d3968f61b20",
    measurementId: "G-2BQD77Q5PW"
};
// Initialize Firebase
firebase.initializeApp(firebaseConfig);
//firebase.analytics(); 
console.log('Firebase инициализирован');

function getCurrentUser() {
  return firebase.auth().currentUser;
}
//-->
