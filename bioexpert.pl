% CSCI 330 - Prolog Assignment
% March, 2011
% Casey Yardley
% =============================

% main
% Starts the expert system
main :-
    write('This program identifies the phyla to which'),nl,
    write('an animal belongs, to the level of detail that'),nl,
    write('would be expected in a course like BIOL 121.'),nl,
    write('Answer questions with ''Y'' for yes or ''N'' for no.'),nl,
    clearFacts,
    try_questions.

% try_questions
% Asks questions until an answer is found
try_questions :-
    phyla_is(Phyla),!,
    describe(Phyla),
    fail.   
try_questions.

% phyla_is(-phyla)
% Defines the Knowldege base rules
phyla_is(porifera):-
    said(truetissues, no).

phyla_is(cnidaria):-
    said(truetissues, yes),
    said(coelom, no),
    said(bilateralsymmetry, no).

phyla_is(platyhelminthes):-
    said(truetissues, yes),
    said(bilateralsymmetry, yes),
    said(coelom, no),
    said(flat, yes).

phyla_is(nematoda):-
    said(coelom, no),
    said(bilateralsymmetry, yes),
    said(flat, no).

phyla_is(mollusca):-
    said(coelom, yes),
    said(segmented, no),
    said(jointedappendages, no),
    said(dorsalnervecord, no).

phyla_is(annelida):-
    said(coelom, yes),
    said(segmented, yes),
    said(jointedappendages, no),
    said(dorsalnervecord, no).

phyla_is(arthropoda):-
    said(coelom, yes),
    said(jointedappendages, yes),
    said(dorsalnervecord, no).

phyla_is(echinodermata):-
    said(coelom, yes),
    said(jointedappendages, no),
    said(dorsalnervecord, no).

phyla_is(chordata):-
    said(coelom, yes),
    said(dorsalnervecord, yes).

% dynamic(-facts)
% User supplied information
:- dynamic(facts/2).

% clearFacts
% removes all user supplied facts
clearFacts :-
    retract(facts(_,_)),
    fail.
clearFacts.

% said(+Question, ?Answer)
% Pairs an answer with a certain
% question, from the user
said(Question,Answer):-
    facts(Question,Answer).

said(Question,Answer) :-
    \+ facts(Question,_),nl,
    ask(Question),
    get_yes_or_no(Response),
    asserta(facts(Question,Response)),
    Response = Answer.

% ask(+Trait)
% Ask the user a Question about a trait
ask(truetissues):-
    write('Does the animal have true tissues?'),nl.

ask(bilateralsymmetry):-
    write('Does the animal exhibit bilateral symmetry?'),nl.

ask(coelom):-
    write('Does the animal have a coelom (body cavity)?'),nl.

ask(flat):-
    write('Is the animal flat shaped?'),nl.

ask(segmented):-
    write('Is the animal segmented?'),nl.

ask(jointedappendages):-
    write('Does the animal have jointed appendages?'),nl.

ask(dorsalnervecord):-
    write('Does the animal have a Dorsal Nerve Cord?'),nl.

% Answer(+Phyla)
% Answers which kingdom the animal belongs to
describe(porifera):-
    write('This animal belongs in Phyla Porifera.'),nl,
    write('(example: Sponges)').

describe(cnidaria):-
    write('This animal belongs to Phyla Cnidaria.'),nl,
    write('(example: Jellyfish, Anemones)').

describe(platyhelminthes):-
    write('This animal belongs to Phyla Platyhelminthes.'),nl,
    write('(example: Flatworms)').

describe(nematoda):-
    write('This animal belongs to Phyla Nematoda.'),nl,
    write('(example: Roundworms)').

describe(mollusca):-
    write('This animal belongs to Phyla Mollusca.'),nl,
    write('(example: Clams, Snails, Squid)').

describe(annelida):-
    write('This animal belongs to Phyla Annelida.'),nl,
    write('(example: Earthworms, Leeches)').
    
describe(arthropoda):-
    write('This animal belongs to Phyla Arthropoda.'),nl,
    write('(example: Ants, Spiders, Crayfish)').

describe(echinodermata):-
    write('This animal belongs to Phyla Echinodermata.'),nl,
    write('(example: Starfish, Sea Urchins)').

describe(chordata):-
    write('This animal belongs to Phyla Chordata.'),nl,
    write('(example: Mammals, Fish, Birds, Amphibians, Reptiles)').

% get_yes_or_no(-Result)
% Returns yes or no from
% user input.
get_yes_or_no(Result) :-
    get(Char), 					% read a character
    get0(_), 					% consume the Return after it
    interpret(Char,Result),
    !. 							% cut -- see text
get_yes_or_no(Result) :-
	nl,
	put(7), % beep
	write('Type Y or N:'),
	get_yes_or_no(Result).

% interpret(+Number, -Answer)
% Returns yes if 'Y' or 'n'
% Returns no if 'N' or 'n'
interpret(89,yes). 	% ASCII 89 = 'Y'
interpret(121,yes). % ASCII 121 = 'y'
interpret(78,no). 	% ASCII 78 = 'N'
interpret(110,no). 	% ASCII 110 = 'n'
