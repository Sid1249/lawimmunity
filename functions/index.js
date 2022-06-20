/* eslint-disable max-len */
const axios = require("axios");
const functions = require("firebase-functions");
const JSON5 = require("json5");
const admin = require("firebase-admin");
const {getFirestore, FieldValue} = require("firebase-admin/firestore");
const express = require("express");
const cors = require("cors")({origin: true});
const app = express();
const cookieParser = require("cookie-parser")();
admin.initializeApp();

const db = getFirestore();


exports.webookapi = functions.https.onRequest((req, res) => {
  if (req.rawBody != null) {
    console.info("start req body");
    console.info(req.rawBody);
    console.info("end req body");

    const jsonRoooomHook = JSON5.parse(req.rawBody);


    console.log(`json room hook room id = ${jsonRoooomHook.room_id}`);

    axios.get(`https://api.enablex.io/video/v2/cdr/room/${jsonRoooomHook.room_id}`.trim(), {
      headers: {
        "accept": "application/json",
        "Authorization": "Basic NjI5OWIyYmZmMmUwYjEzMDk0NzJmNjFhOnllNHVleXV1cnlIdVFhenV0eXZlTHVheXp1cmVxeTl5TnlyeQ==",
      },
    }).then(function(roomCdrResponse) {
      switch (jsonRoooomHook.type) {
        case "roomdrop": {
          console.log(roomCdrResponse.data);


          axios.get(`https://api.enablex.io/video/v2/archive/room/${jsonRoooomHook.room_id}`.trim(), {
            headers: {
              "accept": "application/json",
              "Authorization": "Basic NjI5OWIyYmZmMmUwYjEzMDk0NzJmNjFhOnllNHVleXV1cnlIdVFhenV0eXZlTHVheXp1cmVxeTl5TnlyeQ==",
            },
          }) .then((userRecord) => {
            db.collection("users").doc(roomCdrResponse.data.cdr[0].room.room_details.owner_ref).get().then((queryResult) => {
              console.log("here for saving link from archive");


              if (queryResult == null || queryResult.data() == null || queryResult.data().rooms == null || (!queryResult.data().rooms.includes(`${jsonRoooomHook.room_id}`))) {
                const userRef = db.collection("users").doc(roomCdrResponse.data.cdr[0].room.room_details.owner_ref);


                userRef.set({
                  uid: `${roomCdrResponse.data.cdr[0].room.room_details.owner_ref}`,
                  minused: FieldValue.increment((Math.floor(roomCdrResponse.data.cdr[0].room.duration / 60))),
                  rooms: FieldValue.arrayUnion(`${jsonRoooomHook.room_id}`),
                }, {merge: true});
              }
            });


            console.log(jsonRoooomHook.room_id);
            res.status(200).send("roomdrop notification");
          }).catch((error) => {
            res.status(500).send("cannot fetch archive");
          });


          break;
        }
        case "recording": {
          console.log(jsonRoooomHook.recording[0]);

          const roomRef = db.collection("rooms").doc(jsonRoooomHook.room_id);


          roomRef.set({
            video: jsonRoooomHook.recording[0],
          }, {merge: true});
          res.status(200).send("recording notification");

          break;
        }

        case "transcoded": {
          console.log(jsonRoooomHook.recording);
          const roomRef = db.collection("rooms").doc(jsonRoooomHook.room_id);


          roomRef.set({
            video: jsonRoooomHook.recording,
          }, {merge: true});
          res.status(200).send("transcoded notification");
          break;
        }

        case "file-transfer": {
          console.log(jsonRoooomHook.files[0].url);

          const roomRef = db.collection("rooms").doc(jsonRoooomHook.room_id);


          roomRef.set({
            video: jsonRoooomHook.files[0].url,
          }, {merge: true});

          res.status(200).send("file-transfer notification");
          break;
        }
        default:
          res.status(500).send("invalid notification");
      }
    }).catch(function(error) {
      if (error.response) {
        // Request made and server responded
        console.log(error.response.data);
        console.log(error.response.status);
        console.log(error.response.headers);
      } else if (error.request) {
        // The request was made but no response was received
        console.log(error.request);
      } else {
        // Something happened in setting up the request that triggered an Error
        console.log("Error", error.message);
      }
      const roomObject = {
        statusCode: 500,
        result: error.message,
      };
      res.status(500).send(roomObject);


      console.log("error 500");
      return;
    });
  }
});


exports.savelocation = functions.https.onRequest((req, res) => {
  functions.logger.log("Check if request is authorized with Firebase ID token");
  functions.logger.log(`req method = ${req.method}`);

  if ((!req.headers.authorization || !req.headers.authorization.startsWith("Bearer ")) &&
    !(req.cookies && req.cookies.__session)) {
    functions.logger.error(
        "No Firebase ID token was passed as a Bearer token in the Authorization header.",
        "Make sure you authorize your request by providing the following HTTP header:",
        "Authorization: Bearer <Firebase ID Token>",
        "or by passing a \"__session\" cookie."
    );
    res.status(403).send("Unauthorized");
    return;
  }

  let idToken;
  if (req.headers.authorization && req.headers.authorization.startsWith("Bearer ")) {
    functions.logger.log("Found \"Authorization\" header");
    // Read the ID Token from the Authorization header.
    idToken = req.headers.authorization.split("Bearer ")[1];
  } else if (req.cookies) {
    functions.logger.log("Found \"__session\" cookie");
    // Read the ID Token from cookie.
    idToken = req.cookies.__session;
  } else {
    // No cookie
    res.status(403).send("Unauthorized");
    return;
  }

  try {
    admin.auth().verifyIdToken(idToken).then(function(decodedIdToken) {
      functions.logger.log("ID Token correctly decoded", decodedIdToken);
      console.log("create room going to execute");

      req.user = decodedIdToken;
      console.log("user decoded");

      console.log("create room executed");
      if (req.user != null && req.user.uid != null) {
        const userRef = db.collection("users").doc(req.user.uid);


        userRef.set({
          uid: `${req.user.uid}`,
          time: FieldValue.serverTimestamp(),
          roomid: req.rawBody,
        }, {merge: true});

        res.status(200).send("success");
      } else {
        const roomObject = {
          statusCode: 403,
          result: "un authenticated",
        };

        res.status(403).send(roomObject);

        console.log("un authenticated");
      } console.log("create room executed");
    });
  } catch (error) {
    functions.logger.error("Error while verifying Firebase ID token:", error);
    res.status(403).send("Unauthorized");
    return;
  }
});


exports.createnominee = functions.https.onRequest((req, res) => {
  functions.logger.log("Check if request is authorized with Firebase ID token");
  functions.logger.log(`req method = ${req.method}`);

  if ((!req.headers.authorization || !req.headers.authorization.startsWith("Bearer ")) &&
    !(req.cookies && req.cookies.__session)) {
    functions.logger.error(
        "No Firebase ID token was passed as a Bearer token in the Authorization header.",
        "Make sure you authorize your request by providing the following HTTP header:",
        "Authorization: Bearer <Firebase ID Token>",
        "or by passing a \"__session\" cookie."
    );
    res.status(403).send("Unauthorized");
    return;
  }

  let idToken;
  if (req.headers.authorization && req.headers.authorization.startsWith("Bearer ")) {
    functions.logger.log("Found \"Authorization\" header");
    // Read the ID Token from the Authorization header.
    idToken = req.headers.authorization.split("Bearer ")[1];
  } else if (req.cookies) {
    functions.logger.log("Found \"__session\" cookie");
    // Read the ID Token from cookie.
    idToken = req.cookies.__session;
  } else {
    // No cookie
    res.status(403).send("Unauthorized");
    return;
  }

  try {
    admin.auth().verifyIdToken(idToken).then(function(decodedIdToken) {
      functions.logger.log("ID Token correctly decoded", decodedIdToken);


      console.log("create room going to execute");

      req.user = decodedIdToken;
      console.log("user decoded");

      console.log("create room executed");
      if (req.user != null && req.user.uid != null) {
        const nomieeReqJson = JSON5.parse(req.rawBody);
        if (nomieeReqJson!= null && nomieeReqJson.nomineephone != null && nomieeReqJson.nomineephone != "") {
          admin.auth().getUserByPhoneNumber(nomieeReqJson.nomineephone)
              .then((userRecord) => {
                console.log(`Successfully fetched user data:  ${userRecord.toJSON()}`);
                const nomineeName = nomieeReqJson.nomineename;
                const nomineePhone = userRecord.toJSON().phone;
                const nomineeUID = userRecord.toJSON().uid;


                const userRef = db.collection("users").doc(req.user.uid);

                const nomineesmap = {
                  [nomineeUID]: {
                    "name": nomineeName,
                    "phone": nomineePhone,
                    "uid": nomineeUID,
                    "status": "approved",
                  },
                };

                userRef.set({
                  nominee: nomineesmap,
                }, {merge: true});

                res.status(200).send("success, nominee was a user and added to user doc ");
              })
              .catch((error) => {
                admin.auth()
                    .createUser({
                      phoneNumber: `${nomieeReqJson.nomineephone}`,
                      disabled: false,
                    })
                    .then((userRecord) => {
                    // See the UserRecord reference doc for the contents of userRecord.
                      console.log("Successfully created new user:", userRecord.uid);

                      const nomineeName = nomieeReqJson.nomineename;
                      const nomineePhone = userRecord.toJSON().phone;
                      const nomineeUID = userRecord.toJSON().uid;


                      const userRef = db.collection("users").doc(req.user.uid);

                      const nomineesmap = {
                        [nomineeUID]: {
                          "name": nomineeName,
                          "phone": nomineePhone,
                          "uid": nomineeUID,
                          "status": "approved",
                        },
                      };

                      userRef.set({
                        nomieelist: FieldValue.arrayUnion(userRecord.toJSON().uid),
                        nominee: nomineesmap,
                      }, {merge: true});
                      res.status(200).send("New user created as nominee");
                    })
                    .catch((error) => {
                      console.log("Error creating new user:", error);
                      res.status(500).send("Error creating new user:");
                    });


                console.log("Error fetching user data, so creating new user:", error);
              });
        } else {
          console.log("nomiee phone not valid");
          res.status(500).send("nomiee phone not valid");
        }
      } else {
        res.status(403).send("un authenticated");

        console.log("un authenticated");
      } console.log("create room executed");
    });
  } catch (error) {
    functions.logger.error("Error while verifying Firebase ID token:", error);
    res.status(404).send("Unauthorized");
    return;
  }
});


// exports.blockowner = functions.https.onRequest((req, res) => {
//   functions.logger.log("Check if request is authorized with Firebase ID token");
//   functions.logger.log(`req method = ${req.method}`);

//   if ((!req.headers.authorization || !req.headers.authorization.startsWith("Bearer ")) &&
//     !(req.cookies && req.cookies.__session)) {
//     functions.logger.error(
//         "No Firebase ID token was passed as a Bearer token in the Authorization header.",
//         "Make sure you authorize your request by providing the following HTTP header:",
//         "Authorization: Bearer <Firebase ID Token>",
//         "or by passing a \"__session\" cookie."
//     );
//     res.status(403).send("Unauthorized");
//     return;
//   }

//   let idToken;
//   if (req.headers.authorization && req.headers.authorization.startsWith("Bearer ")) {
//     functions.logger.log("Found \"Authorization\" header");
//     // Read the ID Token from the Authorization header.
//     idToken = req.headers.authorization.split("Bearer ")[1];
//   } else if (req.cookies) {
//     functions.logger.log("Found \"__session\" cookie");
//     // Read the ID Token from cookie.
//     idToken = req.cookies.__session;
//   } else {
//     // No cookie
//     res.status(403).send("Unauthorized");
//     return;
//   }

//   try {
//     admin.auth().verifyIdToken(idToken).then(function(decodedIdToken) {
//       functions.logger.log("ID Token correctly decoded", decodedIdToken);


//       console.log("block owner to execute");

//       req.user = decodedIdToken;
//       console.log("user decoded");

//       if (req.user != null && req.user.uid != null) {
//         const ownerJson = JSON5.parse(req.rawBody);
//         admin.auth().getUserByPhoneNumber(ownerJson.ownerphone)
//             .then((userRecord) => {
//               console.log(`Successfully fetched owner data:  ${userRecord.toJSON()}`);
//               const ownerUid = userRecord.toJSON().uid;


//               const userRef = db.collection("users").doc(req.user.uid);

//               const nomineesmap = {
//                 [ownerUid]: {
//                   "status": "blocked",
//                 },
//               };

//               userRef.set({
//                 nominee: nomineesmap,
//               }, {merge: true});

//               res.status(200).send("success, nominee was a user and added to user doc ");
//             })
//             .catch((error) => {
//               admin.auth()
//                   .createUser({
//                     phoneNumber: "+11234567890",
//                     disabled: false,
//                   })
//                   .then((userRecord) => {
//                     // See the UserRecord reference doc for the contents of userRecord.
//                     console.log("Successfully created new user:", userRecord.uid);

//                     const nomineeName = nomieeReqJson.nomineename;
//                     const nomineePhone = userRecord.toJSON().phone;
//                     const nomineeUID = userRecord.toJSON().uid;


//                     const userRef = db.collection("users").doc(req.user.uid);

//                     const nomineesmap = {
//                       [nomineeUID]: {
//                         "name": nomineeName,
//                         "phone": nomineePhone,
//                         "uid": nomineeUID,
//                       },
//                     };

//                     userRef.set({
//                       nomieelist: FieldValue.arrayUnion(userRecord.toJSON().uid),
//                       nominee: nomineesmap,
//                     }, {merge: true});
//                     res.status(200).send("New user created as nominee");
//                   })
//                   .catch((error) => {
//                     console.log("Error creating new user:", error);
//                     res.status(500).send("Error creating new user:");
//                   });


//               console.log("Error fetching user data:", error);
//             });
//         res.status(200).send("success");
//       } else {
//         res.status(403).send("un authenticated");

//         console.log("un authenticated");
//       } console.log("create room executed");
//     });
//   } catch (error) {
//     functions.logger.error("Error while verifying Firebase ID token:", error);
//     res.status(404).send("Unauthorized");
//     return;
//   }
// });


const createroom = (req, res, next) => {
  functions.logger.log("Check if request is authorized with Firebase ID token");

  if ((!req.headers.authorization || !req.headers.authorization.startsWith("Bearer ")) &&
    !(req.cookies && req.cookies.__session)) {
    functions.logger.error(
        "No Firebase ID token was passed as a Bearer token in the Authorization header.",
        "Make sure you authorize your request by providing the following HTTP header:",
        "Authorization: Bearer <Firebase ID Token>",
        "or by passing a \"__session\" cookie."
    );
    res.status(403).send("Unauthorized");
    return;
  }

  let idToken;
  if (req.headers.authorization && req.headers.authorization.startsWith("Bearer ")) {
    functions.logger.log("Found \"Authorization\" header");
    // Read the ID Token from the Authorization header.
    idToken = req.headers.authorization.split("Bearer ")[1];
  } else if (req.cookies) {
    functions.logger.log("Found \"__session\" cookie");
    // Read the ID Token from cookie.
    idToken = req.cookies.__session;
  } else {
    // No cookie
    res.status(403).send("Unauthorized");
    return;
  }

  try {
    admin.auth().verifyIdToken(idToken).then(function(decodedIdToken) {
      functions.logger.log("ID Token correctly decoded", decodedIdToken);
      console.log("create room going to execute");

      req.user = decodedIdToken;
      console.log("user decoded");

      console.log("create room executed");
      if (req.user != null && req.user.uid != null) {
        axios.post(
            "https://api.enablex.io/video/v2/rooms",
            {
              "name": `${req.user.phone == null ? "LawImmunity Room" : `${req.user.phone} Room`}`,
              "owner_ref": `${req.user.uid}`.trim(),
              "settings": {
                "description": "Descriptive text",
                "mode": "group",
                "scheduled": false,
                "adhoc": false,
                "duration": 30,
                "moderators": "1",
                "participants": "1",
                "auto_recording": true,
                "single_file_recording": true,
              },
              "sip": {
                "enabled": false,
              },
              "data": {
                "custom_key": "",
              },
            },
            {
              headers: {
                "accept": "application/json",
                "Authorization": "Basic NjI5OWIyYmZmMmUwYjEzMDk0NzJmNjFhOnllNHVleXV1cnlIdVFhenV0eXZlTHVheXp1cmVxeTl5TnlyeQ==",
                "Content-Type": "application/json",
              },
            }
        ).then(function(responseRoom) {
          if (responseRoom.status == 400 || responseRoom.status == 401) {
            const roomObject = {
              statusCode: 404,
              result: JSON.stringify(responseRoom.data),
            };

            console.log("error 404");
            res.status(404).send(roomObject);
            return;
          } else {
            if (responseRoom.status == 200 || responseRoom.status == 201) {
              if (responseRoom != null && responseRoom.data != null && responseRoom.data.room != null && responseRoom.data.room.room_id != null) {
                axios.post(
                    `https://api.enablex.io/video/v2/rooms/${responseRoom.data.room.room_id.trim()}/tokens`.trim(),
                    {
                      "name": "LawImmunity User",
                      "role": "moderator",
                      "user_ref": `${req.user.uid}`.trim(),
                    },
                    {
                      headers: {
                        "accept": "application/json",
                        "Authorization": "Basic NjI5OWIyYmZmMmUwYjEzMDk0NzJmNjFhOnllNHVleXV1cnlIdVFhenV0eXZlTHVheXp1cmVxeTl5TnlyeQ==",
                        "Content-Type": "application/json",
                      },
                    }
                ).then(function(responseToken) {
                  if (responseToken.status == 200 || responseToken.status == 201) {
                    const roomRef = db.collection("rooms").doc(responseRoom.data.room.room_id);


                    roomRef.set({
                      uid: `${req.user.uid}`,
                      time: FieldValue.serverTimestamp(),
                      roomid: responseRoom.data.room.room_id,
                      coords: req.coords == null ? "" : req.coords,
                    }, {merge: true});

                    //
                    console.log(`sucess-> ${JSON.stringify(responseToken.data.token)}`);
                    res.status(200).send(responseToken.data.token);

                    return;
                  } else {
                    const roomObject = {
                      statusCode: 400,
                      result: "error occured",
                    };

                    res.status(400).send(roomObject);

                    console.log("failure -> error occured");
                    return;
                  }
                }).catch(function(error) {
                  if (error.response) {
                    // Request made and server responded
                    console.log(error.response.data);
                    console.log(error.response.status);
                    console.log(error.response.headers);
                  } else if (error.request) {
                    // The request was made but no response was received
                    console.log(error.request);
                  } else {
                    // Something happened in setting up the request that triggered an Error
                    console.log("Error", error.message);
                  }
                  const roomObject = {
                    statusCode: 500,
                    result: error.message,
                  };
                  res.status(500).send(roomObject);


                  console.log("error 500");
                  return;
                });
              } else {
                const roomObject = {
                  statusCode: 400,
                  result: "error occured",
                };

                console.log("failure -> error occured");
                res.status(400).send(roomObject);

                return;
              }
            } else {
              const roomObject = {
                statusCode: 400,
                result: "error occured",
              };

              console.log("failure -> error occured");
              res.status(400).send(roomObject);

              return;
            }
          }
        }).catch(function(error) {
          if (error.response) {
            // Request made and server responded
            console.log(error.response.data);
            console.log(error.response.status);
            console.log(error.response.headers);
          } else if (error.request) {
            // The request was made but no response was received
            console.log(error.request);
          } else {
            // Something happened in setting up the request that triggered an Error
            console.log("Error", error.message);
          }
          const roomObject = {
            statusCode: 500,
            result: error.message,
          };

          res.status(500).send(roomObject);

          console.log("error 500");
          return;
        });
      } else {
        const roomObject = {
          statusCode: 403,
          result: "un authenticated",
        };

        res.status(403).send(roomObject);

        console.log("un authenticated");
      } console.log("create room executed");
    });
  } catch (error) {
    functions.logger.error("Error while verifying Firebase ID token:", error);
    res.status(403).send("Unauthorized");
    return;
  }
};

app.use(cors);
app.use(cookieParser);
app.use(createroom);


exports.getroomtoken = functions.https.onRequest(app);
