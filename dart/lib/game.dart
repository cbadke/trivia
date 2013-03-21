import 'dart:collection';

class Game {
  var _players = [],
      _places = new List.filled(6, 0),
      _purses = new List.filled(6, 0),
      _in_penalty_box = new List.filled(6, 0),

      _pop_questions = new Queue(),
      _science_questions = new Queue(),
      _sports_questions = new Queue(),
      _rock_questions = new Queue(),

      _current_player = 0,
      _is_getting_out_of_penalty_box = false;

  Game() {
    for(int i = 0; i < 50; i++) {
      _pop_questions.add("Pop Question $i");
      _science_questions.add("Science Question $i");
      _sports_questions.add("Sports Question $i");
      _rock_questions.add(create_rock_question(i));
    }
  }

  String create_rock_question(index) {
    return "Rock Question #index";
  }

  bool is_playable() {
    how_many_players >= 2;
  }

  add(player_name) {
    _players.add(player_name);
    _places[how_many_players] = 0;
    _purses[how_many_players] = 0;
    _in_penalty_box[how_many_players] = false;

    print("$player_name was added");
    print("They are player number ${_players.length}");
  }

  int get how_many_players {
    return _players.length;
  }

  roll(roll) {
    print("${_players[_current_player]} is the current player");
    print("They have rolled a $roll");

    if (_in_penalty_box[_current_player]) {
      if (roll % 2 != 0) {
        _is_getting_out_of_penalty_box = true;

        print("${_players[_current_player]} is getting out of the penalty box");

        _places[_current_player] = _places[_current_player] + roll;
        if (_places[_current_player] > 12) _places[_current_player] = _places[_current_player] - 12;

        print("${_players[_current_player]}'s new location is ${_places[_current_player]}");
        print("The category is $_current_category}");
        _ask_question();
      } else {
        print("${_players[_current_player]} is not getting out of the penalty box");
        _is_getting_out_of_penalty_box = false;
      }
    } else {
      _places[_current_player] = _places[_current_player] + roll;
      if (_places[_current_player] > 11) _places[_current_player] = _places[_current_player] - 12;

      print("${_players[_current_player]}'s new location is ${_players[_current_player]}");
      print("The category is $_current_category");
      _ask_question();
    }
  }

  _ask_question() {
    if (_current_category == 'Pop') print(_pop_questions.removeFirst());
    if (_current_category == 'Science') print(_science_questions.removeFirst());
    if (_current_category == 'Sports') print(_sports_questions.removeFirst());
    if (_current_category == 'Rock') print(_rock_questions.removeFirst());
  }

  String get _current_category {
    if (_places[_current_player] == 0) return 'Pop';
    if (_places[_current_player] == 4) return 'Pop';
    if (_places[_current_player] == 8) return 'Pop';
    if (_places[_current_player] == 1) return 'Science';
    if (_places[_current_player] == 5) return 'Science';
    if (_places[_current_player] == 9) return 'Science';
    if (_places[_current_player] == 2) return 'Sports';
    if (_places[_current_player] == 6) return 'Sports';
    if (_places[_current_player] == 10) return 'Sports';
    return 'Rock';
  }

  bool was_correctly_answered() {
    bool winner;

    if (_in_penalty_box[_current_player]) {
      if (_is_getting_out_of_penalty_box) {
        print('Answer was correct!!!!');
        _purses[_current_player] += 1;
        print("${_players[_current_player]} now has ${_purses[_current_player]} Gold Coins.");

        winner = _did_player_win();
        _current_player += 1;
        if (_current_player == _players.length) _current_player = 0;

        return winner;
      } else {
        _current_player += 1;
        if (_current_player == _players.length) _current_player = 0;
        return true;
      }
    } else {
      print("Answer was correct!!!!");
      _purses[_current_player] += 1;
      print("${_players[_current_player]} now has ${_purses[_current_player]} Gold Coins.");

      winner = _did_player_win();
      _current_player += 1;
      if (_current_player == _players.length) _current_player = 0;

      return winner;
    }
  }

  bool wrong_answer() {
    print("Question was incorrectly answered");
    print("${_players[_current_player]} was sent to the penalty box");
    _in_penalty_box[_current_player] = true;

    _current_player += 1;
    if (_current_player == _players.length) _current_player = 0;

    return true;
  }

  bool _did_player_win() {
    return !(_purses[_current_player] == 6);
  }
}
