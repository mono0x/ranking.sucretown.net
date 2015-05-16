#!/bin/sh
createuser ranking
createdb -O ranking sanrio-character-ranking -E UTF8 --locale=C -T template0
