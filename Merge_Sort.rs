#[derive(Debug, Clone, Ord, PartialOrd, Eq, PartialEq)]
struct Person {
    name: String,
    age: i32,
}

fn merge_sort_by_age(people: &mut Vec<Person>) {
    let len = people.len();
    if len <= 1 {
        return;
    }

    let mid = len / 2;

    let mut left = people[..mid].to_vec();
    let mut right = people[mid..].to_vec();

    merge_sort_by_age(&mut left);
    merge_sort_by_age(&mut right);

    let mut i = 0;
    let mut j = 0;
    let mut k = 0;

    while i < left.len() && j < right.len() {
        if left[i].age <= right[j].age {
            people[k] = left[i].clone();
            i += 1;
        } else {
            people[k] = right[j].clone();
            j += 1;
        }
        k += 1;
    }

    while i < left.len() {
        people[k] = left[i].clone();
        i += 1;
        k += 1;
    }

    while j < right.len() {
        people[k] = right[j].clone();
        j += 1;
        k += 1;
    }
}

fn main() {
    let mut people = vec![
        Person { name: "Alice".to_string(), age: 30 },
        Person { name: "Bob".to_string(), age: 25 },
        Person { name: "Charlie".to_string(), age: 35 },
        Person { name: "David".to_string(), age: 28 },
    ];

    println!("Unsorted: {:?}", people);

    merge_sort_by_age(&mut people);

    println!("Sorted by age: {:?}", people);
}
