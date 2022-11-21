import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Movie App', 
          style: TextStyle(color: Colors.white, 
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
          )
          ),
        ),
        body: const HomePage(),
        
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage ({ Key? key }) : super(key: key);

    _HomePageState createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
     String selectMovie = "Parasite",
      description = "Choose your movie",
      movie = "";

      var title, year, rated, released, genre, actors, plot;
           
            List<String> movieList = [
              "Parasite",
              "Peninsula",
              "Divergent",
              "Twilight",
              "Alive",
              "Unstoppable",
              "Stardust",
              "Rampant",
              "Jumanji",
              "Transformers"
            ];

          String desc = "No Data";

    Widget build(BuildContext context) {
      return Scaffold(
         backgroundColor: Color.fromARGB(255, 75, 25, 65),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 75, 25, 65),
        elevation: 0.0,
      ),
      body: SingleChildScrollView (
       child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Movie Information", style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: 
            FontWeight.bold,)),

            DropdownButton( 
            itemHeight: 60, 
            value: selectMovie, 
            onChanged: (newValue) { 
              setState(() { 
                selectMovie = newValue.toString(); 
              }); 
            }, 
            items: movieList.map((selectMovie) { 
              return DropdownMenuItem( 
                //value: selectMovie, 
                child: Text( 
                  selectMovie, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), 
                ), 
                value: selectMovie,
              ); 
            }).toList(), 
          ),

           ElevatedButton(onPressed: _getMovie, child: const Text("Search Movie")), 
          Text(desc, 
              style: 
                const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
            ],
        ),
      )
      ),
      );
    }
  
  Future<void> _getMovie() async {
    var apiid = "c417bcd2"; 
   var url = Uri.parse('http://www.omdbapi.com/?t=$selectMovie&apikey=$apiid');
    var response = await http.get(url);
    //var rescode = response.statusCode;  
    if (response.statusCode == 200) { 
      var jsonData = response.body; 
      //var parsedJson = json.decode(jsonData); 
      var parsedData = json.decode(jsonData);
        title = parsedData['Title'];
        year = parsedData['Year']; 
        rated = parsedData['Rated']; 
        released = parsedData['Released']; 
        genre = parsedData['Genre']; 
        actors = parsedData['Actors']; 
        plot = parsedData['Plot']; 

      setState(() { 
         desc = 
        "Title: $selectMovie. \nYear: $year. \nRated: $rated. \nRelease on: $released. \nGenre: $genre. \nActors: $actors. \nPlot: $plot."; 

      });
    
    } else { 
      setState(() { 
        desc = "No record"; 
      }); 
    }

  }
  }