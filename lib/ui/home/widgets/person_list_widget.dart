import 'package:flutter/material.dart';
import 'package:flutter_sample/data/remote/response/person_list_response.dart';

class PersonsListWidget extends StatelessWidget {
  final List<Person> persons;

  const PersonsListWidget({Key key, this.persons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      padding: EdgeInsets.only(left: 10),
      child: ListView.builder(
        itemCount: persons.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.only(top: 10, right: 8),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  persons[index].profilePath == null
                      ? Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.blueGrey),
                          child: Icon(
                            Icons.verified_user,
                            color: Colors.white,
                          ),
                        )
                      : Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w200' +
                                        persons[index].profilePath)),
                          )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    persons[index].name,
                    maxLines: 2,
                    style: TextStyle(
                      height: 1.4,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Trending for ${persons[index].knownForDepartment}',
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                        fontSize: 7),
                  )
                ]),
          );
        },
      ),
    );
  }
}
