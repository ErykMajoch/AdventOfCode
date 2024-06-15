var fs = require("fs");
var full = fs.readFileSync("input.txt", "utf-8");
var lines = full.split("\n");
lines.pop();

function parse_lines() {
  let people = new Set();
  let connections = new Map();
  lines.forEach((v) => {
    v = v.replace(".", "");
    let words = v.split(" ");

    let person1 = words[0];
    let person2 = words[10];
    let value = words[2] === "lose" ? -1 * Number(words[3]) : Number(words[3]);

    connections.set(`${person1} -> ${person2}`, value)
    people.add(person1);
    people.add(person2);

  });

  return {
    people: Array.from(people),
    connections: connections
  }

}

function permutations(array) {
    function p(array, temp) {
        var i, x;
        if (!array.length) {
            result.push(temp);
        }
        for (i = 0; i < array.length; i++) {
            x = array.splice(i, 1)[0];
            p(array, temp.concat(x));
            array.splice(i, 0, x);
        }
    }

    var result = [];
    p(array, []);
    return result;
}

function calculate_hapiness(people, connections) {
  // var {people, connections} = parse_lines();
  var max = 0;
  var perms = permutations(people);
  for (var i = 0; i < perms.length; i++) {
    var perm = perms[i];
    var total = 0;
    for (var current = 0; current < perm.length; current++) {
      var prev = current === 0 ? perm.length - 1 : current - 1;
      var next = current === perm.length - 1 ? 0 : current + 1;

      total += connections.get(`${perm[current]} -> ${perm[prev]}`);
      total += connections.get(`${perm[current]} -> ${perm[next]}`);

    }
    max = Math.max(max, total);
  }
  return max;
}

var {people, connections} = parse_lines();
console.log(`Part one: ${calculate_hapiness(people, connections)}`);

var me = "Me";
for (i in people) {
  connections.set(`${me} -> ${people[i]}`, 0);
  connections.set(`${people[i]} -> ${me}`, 0);
}
people.push(me);

console.log(`Part two: ${calculate_hapiness(people, connections)}`);

