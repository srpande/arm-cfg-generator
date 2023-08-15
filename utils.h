/*
 * ARM assembly level emulator
 *
 * Copyright (c) 2012 Institute Mines-Telecom
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

#ifndef UTILS_H
#define UTILS_H

#include <iostream>
#include <vector>
#include <sstream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

using namespace std;

/** @brief Struct for supporting the sort of our map<string,unsigned int>.
*/
template <typename T1, typename T2>
struct less_second {
    typedef pair<T1, T2> type;
    bool operator ()(type const& a, type const& b) const {
        return a.second > b.second;
    }
};

/** @brief Represents a number into a string format
	@param my_cypher the number to be stringefied
	@return a string representation of the cypher
*/
template <class cypher>
static inline string to_integer(cypher my_cypher) {
	stringstream ss;
	ss << my_cypher;
	return ss.str();
}

/** @brief Splits a string, using + as delimiter
	@param my_string the string to be split
	@return the splitted string
*/
static vector<string> split_plus(string my_string) {
	vector<string> my_splitted_string;

	char my_command[64];
	int length = my_string.length();
	int end = 0;
	int start = 0;
    
	memcpy(my_command, my_string.c_str(), length);
	my_command[length] = '\0';
	
	for(end = 0; end < length; end++) {
		if(my_command[end] != '+') {
			start = end;
			do {end++;} while(my_command[end] != '+' && my_command[end] != '\0');
			my_command[end] = '\0';
			my_splitted_string.push_back(string(&my_command[start]));
		}
	}
    
	return my_splitted_string;
}

/** @brief Splits a string, using whitespace(s) as delimiters
	@param my_string the string to be split
	@return the splitted string
*/
static vector<string> split(string my_string) {
	vector<string> my_splitted_string;
    
	char my_command[128];
	int length = my_string.length();
	int end = 0;
	int start = 0;
    
	memcpy(my_command, my_string.c_str(), length);
	my_command[length] = '\0';
	
	for(end = 0; end < length; end++) {
		if(!isspace(my_command[end])) {
			start = end;
			do {end++;} while(my_command[end] != '\t' && !isspace(my_command[end]) && my_command[end] != '\0');
			my_command[end] = '\0';
			my_splitted_string.push_back(string(&my_command[start]));
		}
	}
	
    //for(end = 0; end < my_splitted_string.size(); end++)
    //    cout << "\"" << my_splitted_string.at(end) << "\"  ";
    //cout << endl;
    
	return my_splitted_string;
}

/** @brief Trims trailing, leading, and trailing colons in a string
	@param str the string to be trimmed
	@return a pointer to the trimmed string
*/
static char* trim_white_spaces(char *str) {
	char *end;
	int i = 0;
	
	// trim leading space
	while(isspace(*str)) str++;
	
	if(*str == 0)  // All spaces?
		return str;
		
	// trim trailing space
	end = str + strlen(str) - 1;
	while(end > str && isspace(*end)) end--;
	
	// remove possible trailing colons
	if(*end == ':' && *str == '.') end--;
	//if(*str == '.') end--;
	
	// write new null terminator
	*(end+1) = 0;
	
	return str;
}

/** @brief Removes unneeded characters arguments ([],#).
	@param arg pointer to the string that needs to be cleaned
	@return pointer to the cleaned string
*/
static inline char* clean_argument(char* arg) {
	// removes brackets and #
	if(!isalpha(arg[0])) arg++;
	// removes trailing stuff
	if(!isalpha(arg[strlen(arg)-1]) && !isdigit(arg[strlen(arg)-1]))
	arg[strlen(arg)-1] = '\0';
	return arg;
}

/** @brief Extracts an integer from a littered string.
	@param arg pointer to the string that needs to be identified
	@return integer deteceted
*/
static inline int get_value(const char* arg) {
	// \todo must also handle negative numbers!!!
	char* iter = (char*)arg;
	while (*iter != '\0') {
		if(*iter == '#') {
			iter++;
			char* end = iter;
			while (isdigit(*end)) end++;
			*(++end) = '\0';
			return atoi(iter);
		}
		else if(isdigit(*iter)) {
			char* end = iter;
			while (isdigit(*end)) end++;
			*(++end) = '\0';
			return atoi(iter);
		}
		iter++;
	}	
	return 0;
}

/** @brief Removes duplicate items from vector.
	@param vector pointer to the vector to be cleaned
	@return stripped vector
*/
template <class T>
static void clean_vector(vector<T> *my_vector)
{
	my_vector->erase( unique( my_vector->begin(), my_vector->end() ), my_vector->end() );
}

string get_instr(string arg1)
{
	int i = 0;
	char instr[8];
	const char *my_index = arg1.c_str();
	while(isalpha(my_index[i]) || my_index[i] == '.') i++;
	memcpy(&instr[0], my_index, i);
	instr[i] = '\0';
	return string(instr);
}

static int is_instr(string arg1, string arg2)
{
	int index = 0;
	int length = arg2.length();
	
	if(arg1.length() != arg2.length())
		return 0;
	
	// Only works if the strings are the same length!
	while(index < length)
	{
		if(arg1[index] != arg2[index])
			return 0;
		index++;
	}	
	return 1;
}

static string get_arg(const string stnc, int location)
{
	int i;
	vector<string> my_split = split(stnc);
	if(location <= my_split.size())
		return my_split.at(location);
	return "";
}

static int line_containes(string line, string arg1, string arg2, string arg3)
{
	if(line.find(arg1) == -1)
		return 0;
	if(line.find(arg2) == -1)
		return 0;
	if(line.find(arg3) == -1)
		return 0;
	return 1;
}


#endif

