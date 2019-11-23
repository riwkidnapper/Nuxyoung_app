const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

var msgData;

exports.sendCreateEventNotification = functions.firestore
  .document("appointment/{appointmentId}")
  .onCreate(async snapshot => {
    msgData = snapshot.data();
    console.log(msgData);
    admin
      .firebase()
      .collection("users")
      .get()
      .then(snapshot => {
        var tokens = [];
        if (snapshot.empty) {
          console.log("No Device");
        } else {
          for (var token of snapshot.docs) {
            tokens.push(token.data().token);
          }

          var payload = {
            notifications: {
              title: "From " + msgData.วันเดือนปีที่นัดหมาย,
              body: "offer " + msgData.ชื่อแพทย์ผู้รักษา,
              sound: "defailt"
            },
            data: {
              sendername: msgData.วันเดือนปีที่นัดหมาย,
              message: msgData.ชื่อแพทย์ผู้รักษา
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
