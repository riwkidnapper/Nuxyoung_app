part of home;

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //logo before welcome
      body: navigationPage(context),

      //body: Loginpage(),
    );
  }
}

navigationPage(context) {
  FirebaseAuth.instance
      .currentUser()
      .then((user) => {
            if (user != null)
              {
                Firestore.instance
                    ?.collection("users")
                    ?.where('uid', isEqualTo: user?.uid)
                    ?.where('email', isEqualTo: user?.email)
                    ?.getDocuments()
                    ?.then((QuerySnapshot snapshot) {
                  if (snapshot.documents[0]['rule'] == 'user') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    ).catchError((err) => print(err));
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicalBudhosp(currentUser: user),
                      ),
                    ).catchError((err) => print(err));
                  }
                })
              }
            else
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Loginpage(),
                  ),
                )
              }

            // else
            //   {
            //     // Firestore.instance
            //     //     .collection("users")
            //     //     .document(user.uid)
            //     //     .get()
            //     //     .then((DocumentSnapshot result) =>
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => HomePage(),
            //       ),
            //     ).catchError((err) => print(err))
            //   }
          })
      .catchError((err) => print(err));
}
