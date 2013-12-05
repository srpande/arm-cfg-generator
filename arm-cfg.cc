/*
 * ARM assembly Control Flow Graph generator
 *
 * Copyright (c) 2013, Karel De Vogeleer, ParisTech
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see
 * <http://www.gnu.org/licenses/gpl-2.0.html>
 */
 

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <map>
#include <algorithm>
#include <stdio.h>
#include <ctype.h>

#include "utils.h"

using namespace std;

vector<int> my_breaks;
vector<int> my_branches;
map<string,int> my_references;
vector<string> my_lines;

void find_breaks()
{
	int line_index;
	
	// Add the start
	my_breaks.push_back(0);
	
	for(line_index = 0; line_index < my_lines.size(); line_index++)
	{
		const char *line_c = my_lines.at(line_index).c_str();
		if(line_c[0] == 'b')
		{
			// "bl" are jumps to other functions, we are not following these...
			if(line_c[1] == 'l' && !isalpha(line_c[2]))
			{
				my_breaks.push_back(line_index);
			}
			else
			{
				my_branches.push_back(line_index);
				my_breaks.push_back(line_index+1);
			}
		}
		else if(is_instr(get_instr(line_c),"tst")
					|| is_instr(get_instr(line_c),"cmp")
                    || is_instr(get_instr(line_c),"cmn"))
		{
			my_breaks.push_back(line_index);
		}
	}
	
	sort(my_breaks.begin(), my_breaks.end(), less<int>());
	sort(my_branches.begin(), my_branches.end(), less<int>());
	
	// Add the end as well if not there already
	my_breaks.push_back(my_lines.size());
	
	clean_vector(&my_breaks);
	clean_vector(&my_branches);
}

void load_file ()
{
	string line;
	char *line_c;
	
	int line_index = 0;
	
	while(getline(cin, line)) {
		line_c = trim_white_spaces((char*)line.c_str());
		switch(line_c[0])
		{
			case '@' : break;
			case '.' :
				{
					if(line_c[1] == 'L')
					{
						string my_ref = string(&line_c[1]);
						my_references.insert(pair<string,int>(my_ref,my_lines.size()));
					}
					break;
				}
			default :
				{
					if(line_c[strlen(line_c)-1] != ':')
					{
						my_lines.push_back(line_c);
					}
				}
		}
	}
}

void print_links()
{
	for(map<string,int>::iterator iterator = my_references.begin(); iterator != my_references.end(); iterator++)
	{
		cout << iterator->first << " -> " << iterator->second << endl;
	}
}

void print_breaks()
{
	int i;
	
	for(i = 0; i < my_breaks.size(); i++)
	{
		cout << i << ": " << my_breaks.at(i) << endl;
	}
}

void print_lines()
{
	int i;
	
	for(i = 0; i < my_lines.size(); i++)
	{
		cout << i << ": " << my_lines.at(i) << endl;
	}
}

void print_header()
{
	cout << "digraph g {" << endl;
}

void print_trailer()
{
	cout << "}" << endl;
}

void list_structs()
{
	int i,k;
	
	for(i = 1; i < my_breaks.size(); i++)
	{
		int is_cmp = 0;
		
		//cout << "DEBUG: " << my_breaks.at(i) << " " << my_lines.size() << endl;
		string my_shape, my_alignement;
        string my_instr = get_instr(my_lines.at(my_breaks.at(i-1)));
		if(is_instr(my_instr,"cmp") || is_instr(my_instr.c_str(),"cmn") || is_instr(my_instr.c_str(),"tst"))
		{
			is_cmp = 1;
		}
		
		if(is_cmp)
		{
			my_shape = "diamond";
			my_alignement = "\\n";
		}
		else
		{
			my_shape = "box";
			my_alignement = "\\l";
		}
		
		cout << "\tnode" << i << " [shape=" << my_shape << ", label = \"";
			
		for(k = my_breaks.at(i-1); k < my_breaks.at(i); k++)
		{
			cout << my_lines.at(k) << my_alignement;
		}
		
		cout << "\"];" << endl;
	}
}

int convert_reference(const char *my_ref)
{
	int i = 0;
	map<string,int>::iterator iter;
	string my_ref_str;
	
	while(my_ref[i] != '.') i++;
	my_ref_str = string(&my_ref[++i]);
	
	iter = my_references.find(my_ref_str);

	if(iter != my_references.end())
		return iter->second;
	
	return -1;
}

int get_struct_index(int line)
{
	int i;

	for(i = 0; i < my_breaks.size(); i++)
	{
		if(line < my_breaks.at(i))
		{
			return i;
		}
	}
	
	return -1;
}

void print_lines_with_bb()
{
	int k = 0, l = 0, m = 0;
	
	for(k = 0; k < my_lines.size(); k++)
	{
		while(k > my_breaks.at(l))
			l++;
		if(k == my_breaks.at(l))
			cout << "--" << l+1 << "------" << endl;
		while(k > my_branches.at(m))
			m++;
		if(k == my_branches.at(m))
			cout << k << "+ " << my_lines.at(k) << endl;
		else
			cout << k << ": " << my_lines.at(k) << endl;
	}
}

void list_arrows()
{
	int i;
	
	vector<string> my_arrows;
	std::stringstream ss;
	
	// List branches
	for(i = 0; i < my_branches.size(); i++)
	{
		//cout << "Verifying branch #" << i << " at " << my_branches.at(i) << endl;
		int my_ref = convert_reference(my_lines.at(my_branches.at(i)).c_str());
		
		int my_struct_index_dest = get_struct_index(my_ref);
		int my_struct_index_source = get_struct_index(my_branches.at(i));
		
		//cout << "s:" << my_struct_index_dest << " d:" << my_struct_index_source << " " << my_ref << endl;

		if(my_struct_index_dest != -1 && my_struct_index_source != -1)
		{
			ss.str("");
			ss << "\tnode" << my_struct_index_source << " -> node" << my_struct_index_dest << ";";
			my_arrows.push_back(ss.str());
		}
		
		string test = "\tnode";
	}
	
	cout << endl;
	
	// List links between adjescent blocks
	for(i = 1; i < my_breaks.size(); i++)
	{
		if(!is_instr(get_instr(my_lines.at(my_breaks.at(i)-1)),"b")
			&& !is_instr(get_instr(my_lines.at(my_breaks.at(i)-1)),"pop"))
		{
			int my_struct_index_dest = get_struct_index(my_breaks.at(i));
			ss.str("");
			ss << "\tnode" << (my_struct_index_dest-1) << " -> node" << my_struct_index_dest << ";";
			my_arrows.push_back(ss.str());
		}
	}
	
	sort(my_arrows.begin(), my_arrows.end(), less<string>());
	clean_vector(&my_arrows);
	
	for(i = 0; i < my_arrows.size(); i++)
	{
		cout << my_arrows.at(i) << endl;
	}
	
}

void print_clean_file ()
{
	string line;
	char *line_c;
	
	int line_index = 0;
	
	while(getline(cin, line)) {
		line_c = trim_white_spaces((char*)line.c_str());
		cout << line << endl;
		if(line_c[0] != '@')
		{
			
		}
		cout << line_c << endl;
	}
}

int main(int argc, const char** argv)
{
	int i = 0;

	load_file();
	find_breaks();

	for(int i = 0; i < argc; i++) {
		if(argv[i][0] == '-') {
			switch (argv[i][1]) {
				case 'f' : print_lines(); return 0;
				case 'l' : print_links(); return 0;
				case 'b' : print_breaks(); return 0;
				case 'p' : print_lines_with_bb(); return 0;
				case 'c' : print_clean_file(); return 0;
				case 'v' : cout << "ARM assembly CFG generator v1.0" << endl; return 0;
				case 'h' :
				{
					cout << "ARM assembly CFG generator parameters" << endl;
					cout << "\t-f print the assembly without comments or links" << endl;
					cout << "\t-l print the list of reference and its pointers" << endl;
					cout << "\t-b print the block borders" << endl;
					cout << "\t-p print the program together with some infered info" << endl;
					cout << "\t\t \"+\" indicates a branch" << endl;
					cout << "\t\t \"--#------\" indicates a block boundary" << endl;
					cout << "\t-v print the version of the program" << endl;
					cout << "\t-h print help information" << endl;
					return 0;
				}
			}
		}
	}

	print_header();
	list_structs();
	cout << endl;
	list_arrows();
	print_trailer();

	return 0; 
}
