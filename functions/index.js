const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

var msgData;

exports.offerTrigger = functions.firestore
  .document("notifications/{notificationId}")
  .onCreate((snapshot, context) => {
    msgData = snapshot.data();

    admin
      .firestore()
      .collection("pushtokens")
      .get()
      .then(snapshots => {
        var tokens = [];
        if (snapshots.empty) {
          console.log("No Devices");
        } else {
          for (var token of snapshots.docs) {
            tokens.push(token.data().devtoken);
          }

          var payload = {
            notification: {
              title: msgData.title,
              body: msgData.body,
              sound: "default",
              click_action: "FLUTTER_NOTIFICATION_CLICK"
            },
            data: {
              sendername: msgData.title,
              message: msgData.body
            }
          };

          return admin
            .messaging()
            .sendToDevice(tokens, payload)
            .then(response => {
              console.log("Pushed them all");
            })
            .catch(err => {
              console.log(err);
            });
        }
      });
  });
