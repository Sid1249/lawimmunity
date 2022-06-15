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

    axios.get(`https://api.enablex.io/video/v2/cdr/room/${jsonRoooomHook.room_id}`, {
      headers: {
        "accept": "application/json",
        "Authorization": "Basic NjI5OWIyYmZmMmUwYjEzMDk0NzJmNjFhOnllNHVleXV1cnlIdVFhenV0eXZlTHVheXp1cmVxeTl5TnlyeQ==",
      },
    }).then(function(roomCdrResponse) {
      switch (jsonRoooomHook.type) {
        case "roomdrop": {
          console.log(roomCdrResponse.data);


          db.collection("users").doc(roomCdrResponse.data.cdr[0].room.room_details.owner_ref).get().then((queryResult) => {
            console.log("here for query");


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
          break;
        }
        case "recording": {
          console.log(jsonRoooomHook.recording[0]);

          const roomRef = db.collection("rooms").doc(jsonRoooomHook.room_id);


          roomRef.set({
            video: jsonRoooomHook.recording[0],
          });
          res.status(200).send("recording notification");

          break;
        }

        case "transcoded": {
          console.log(jsonRoooomHook.recording);
          const roomRef = db.collection("rooms").doc(jsonRoooomHook.room_id);


          roomRef.set({
            video: jsonRoooomHook.recording,
          });
          res.status(200).send("transcoded notification");
          break;
        }

        case "file-transfer": {
          console.log(jsonRoooomHook.files[0].url);

          const roomRef = db.collection("rooms").doc(jsonRoooomHook.room_id);


          roomRef.set({
            video: jsonRoooomHook.files[0].url,
          });

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
              "owner_ref": `${req.user.uid}`,
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
                    `https://api.enablex.io/video/v2/rooms/${responseRoom.data.room.room_id}/tokens`,
                    {
                      "name": "LawImmunity User",
                      "role": "moderator",
                      "user_ref": `${req.user.uid}`,
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
                    });

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
