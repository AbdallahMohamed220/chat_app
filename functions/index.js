const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.myFunction = functions.firestore
    .document('chat/{message}')
    .onCreate((snap) => {
       return admin.messaging().sendToTopic('chat',
         {
              notification: { 
                  title: snap.data().userName,
                  body:snap.data().message,
                  clickAction:'FLUTTER_NOTIFICATION_CLICK'

         }, },)
    });