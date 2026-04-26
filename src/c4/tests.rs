use super::*;

fn setup_and_compile(code: &str) -> C4 {
    let mut vm = C4::new(code.to_string(), false);
    vm.compile().unwrap();
    vm
}

#[test]
fn test_arithmetic() {
    let code = r#"
    int main() {
        return (10 + 20) * 2;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 60);
}

#[test]
fn test_goto() {
    let code = r#"
    int main() {
        int a;
        a = 0;
    start:
        a = a + 1;
        if (a < 5) goto start;
        goto end;
        a = a + 100;
    end:
        return a;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 5);
}

#[test]
fn test_function_pointers() {
    let code = r#"
    int add(int a, int b) { return a + b; }
    int sub(int a, int b) { return a - b; }
    int main() {
        int *fp;
        int res1;
        int res2;
        fp = add;
        res1 = fp(10, 20);
        fp = sub;
        res2 = fp(10, 5);
        return res1 * res2;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 150); // 30 * 5 = 150
}

#[test]
fn test_switch_statement() {
    let code = r#"
    int main() {
        int a; int res;
        a = 2; res = 0;
        switch(a) {
            case 1: res = 10; break;
            case 2: res = 20; // Tests fallthrough
            case 3: res = res + 5; break;
            default: res = 100; break;
        }
        return res;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 25);
}

#[test]
fn test_switch_default_routing() {
    let code = r#"
    int main() {
        int a; int res;
        a = 99; res = 0;
        switch(a) {
            case 1: res = 10; break;
            case 2: res = 20; break;
            default: res = 100; break;
        }
        return res;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 100);
}

#[test]
fn test_control_flow() {
    let code = r#"
    int main() {
        int i;
        i = 0;
        while (i < 5) {
            i = i + 1;
        }
        if (i == 5) return 1;
        return 0;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 1);
}

#[test]
fn test_do_while() {
    let code = r#"
    int main() {
        int i;
        i = 0;
        do {
            i = i + 1;
        } while (i < 5);
        return i;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 5);
}

#[test]
fn test_break_continue() {
    let code = r#"
    int main() {
        int i;
        int sum;
        sum = 0;
        for (i = 0; i < 10; i++) {
            if (i == 5) break;
            if (i % 2 == 0) continue;
            sum = sum + i;
        }
        return sum; // Should be 1 + 3 = 4
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 4);
}

#[test]
fn test_for_loop() {
    let code = r#"
    int main() {
        int i;
        int sum;
        sum = 0;
        for (i = 0; i < 5; i++) {
            sum = sum + i;
        }
        return sum;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 10);
}

#[test]
fn test_recursion_factorial() {
    let code = r#"
    int fact(int n) {
        if (n < 2) return 1;
        return n * fact(n - 1);
    }
    int main() {
        return fact(5);
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 120);
}

#[test]
fn test_pointers() {
    let code = r#"
    int main() {
        int a;
        int *p;
        a = 100;
        p = &a;
        *p = 200;
        return a;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 200);
}

#[test]
fn test_nested_function_calls() {
    let code = r#"
    int add(int a, int b) {
        return a + b;
    }
    int main() {
        return add(add(10, 20), add(30, 40));
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 100);
}

#[test]
fn test_printf() {
    let code = r#"
    int main() {
        printf("Hello %d\n", 123);
        return 0;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 0);
}

#[test]
fn test_memory_ops() {
    let code = r#"
    int main() {
        char *s1;
        char *s2;
        s1 = malloc(10);
        s2 = malloc(10);
        memset(s1, 'A', 9);
        s1[9] = 0;
        memset(s2, 'A', 9);
        s2[9] = 0;
        if (memcmp(s1, s2, 10) != 0) return 1;
        s2[5] = 'B';
        if (memcmp(s1, s2, 10) == 0) return 2;
        return 0;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 0);
}

#[test]
fn test_file_io() {
    std::fs::write("test_dummy.txt", "1234567890").unwrap();

    let code = r#"
    int main() {
        int fd;
        char *buf;
        fd = open("test_dummy.txt", 0);
        if (fd < 0) return 1;

        buf = malloc(10);
        read(fd, buf, 9);
        buf[9] = 0;
        close(fd);

        return 0;
    }
    "#;
    let mut vm = setup_and_compile(code);
    let res = vm.run().unwrap();

    std::fs::remove_file("test_dummy.txt").unwrap();
    assert_eq!(res, 0);
}

#[test]
fn test_ir_execution() {
    let mut vm = C4::new("".to_string(), false);
    vm.text = vec![
        Op::Ent as i64,
        0,
        Op::Imm as i64,
        5,
        Op::Psh as i64,
        Op::Imm as i64,
        10,
        Op::Add as i64,
        Op::Lev as i64,
    ];

    let name: &[u8] = b"main";
    let _ = vm.resolve_symbol(name, vm.hash_name(name));
    let main_sym = vm.find_symbol("main").unwrap();
    vm.symbols[main_sym].val = 0;

    let res = vm.run().unwrap();
    assert_eq!(res, 15);
}

#[test]
fn test_ir_translation_simple() {
    let code = r#"
    int main() {
        return 42;
    }
    "#;
    let mut vm = C4::new(code.to_string(), false);
    vm.compile().unwrap();

    let expected_text = vec![
        Op::Ent as i64,
        0,
        Op::Imm as i64,
        42,
        Op::Lev as i64,
        Op::Lev as i64,
    ];
    assert_eq!(vm.text, expected_text);
}

#[test]
fn test_ir_translation_if() {
    let code = r#"
    int main() {
        if (1) {
            return 2;
        } else {
            return 3;
        }
    }
    "#;
    let vm = setup_and_compile(code);

    let bz_target = 11;
    let jmp_target = 14;

    let expected_text = vec![
        Op::Ent as i64,
        0,
        Op::Imm as i64,
        1,
        Op::Bz as i64,
        bz_target,
        Op::Imm as i64,
        2,
        Op::Lev as i64,
        Op::Jmp as i64,
        jmp_target,
        Op::Imm as i64,
        3,
        Op::Lev as i64,
        Op::Lev as i64,
    ];
    assert_eq!(vm.text, expected_text);
}

#[test]
fn test_ir_translation_while() {
    let code = r#"
    int main() {
        while (0) {
            return 1;
        }
    }
    "#;
    let vm = setup_and_compile(code);

    let bz_target = 11;
    let jmp_target = 2;

    let expected_text = vec![
        Op::Ent as i64,
        0,
        Op::Imm as i64,
        0,
        Op::Bz as i64,
        bz_target,
        Op::Imm as i64,
        1,
        Op::Lev as i64,
        Op::Jmp as i64,
        jmp_target,
        Op::Lev as i64,
    ];
    assert_eq!(vm.text, expected_text);
}

#[test]
fn test_pointer_arithmetic_scaling() {
    let code = r#"
        int main() {
            int *p;
            p = 100;
            return p + 1; // Should return 108, not 101
        }
        "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 108);
}

#[test]
fn test_expression_precedence() {
    let code = "int main() { return 2 + 3 * 4 == 14; }";
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 1);
}

#[test]
fn test_variable_shadowing() {
    let code = r#"
    int main() {
        int i; i = 10;
        if (1) { int i; i = 20; }
        return i;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 10);
}

#[test]
fn test_pointer_arithmetic() {
    let code = r#"
    int main() {
        int *p;
        p = malloc(16);
        *p = 1;
        *(p + 1) = 2;
        return *p + *(p + 1);
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 3);
}

#[test]
fn test_memset_mcmp() {
    let code = r#"
    int main() {
        char *s; s = malloc(5);
        memset(s, 65, 4); // 'AAAA'
        s[4] = 0;
        if (s[0] == 65) return 42;
        return 0;
    }
    "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 42);
}

#[test]
fn test_quicksort() {
    let code = r#"
        void swap(int *a, int *b) {
            int t;
            t = *a;
            *a = *b;
            *b = t;
        }

        int partition(int *arr, int low, int high) {
            int pivot;
            int i;
            int j;

            pivot = arr[high];
            i = low - 1;

            for (j = low; j < high; j++) {
                if (arr[j] <= pivot) {
                    i++;
                    swap(&arr[i], &arr[j]);
                }
            }
            swap(&arr[i + 1], &arr[high]);
            return i + 1;
        }

        void quicksort(int *arr, int low, int high) {
            int pi;
            if (low < high) {
                pi = partition(arr, low, high);
                quicksort(arr, low, pi - 1);
                quicksort(arr, pi + 1, high);
            }
        }

        int main() {
            int *arr;
            int i;
            arr = malloc(40); // 5 integers * 8 bytes
            arr[0] = 12; arr[1] = 7; arr[2] = 15; arr[3] = 5; arr[4] = 10;

            quicksort(arr, 0, 4);

            // Check if sorted: 5, 7, 10, 12, 15
            if (arr[0] != 5) return 1;
            if (arr[1] != 7) return 2;
            if (arr[2] != 10) return 3;
            if (arr[3] != 12) return 4;
            if (arr[4] != 15) return 5;

            return 0; // Success
        }
        "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 0);
}

#[test]
fn test_linked_list() {
    let code = r#"
        int main() {
            int *head; int *temp; int *node;
            int sum; int i;

            head = 0;
            sum = 0;

            // Create a list of 5 nodes: [4, 3, 2, 1, 0]
            for (i = 0; i < 5; i++) {
                node = malloc(16); // 8 bytes for value, 8 bytes for next pointer
                node[0] = i;       // data
                node[1] = head;    // next
                head = node;
            }

            // Traverse and sum
            temp = head;
            while (temp != 0) {
                sum = sum + temp[0];
                temp = temp[1];
            }

            return sum; // Expected: 4+3+2+1+0 = 10
        }
        "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 10);
}

#[test]
fn test_binary_search_tree() {
    let code = r#"
        int* insert(int *root, int val) {
            if (root == 0) {
                root = malloc(24); // [0]=val, [1]=left, [2]=right
                root[0] = val;
                root[1] = 0;
                root[2] = 0;
                return root;
            }
            if (val < root[0]) {
                root[1] = insert(root[1], val);
            } else {
                root[2] = insert(root[2], val);
            }
            return root;
        }

        int search(int *root, int val) {
            if (root == 0) return 0;
            if (root[0] == val) return 1;
            if (val < root[0]) return search(root[1], val);
            return search(root[2], val);
        }

        int main() {
            int *root;
            root = 0;
            root = insert(root, 50);
            insert(root, 30);
            insert(root, 70);
            insert(root, 20);
            insert(root, 40);

            if (search(root, 20) == 0) return 1; // Failed to find existing
            if (search(root, 40) == 0) return 2; // Failed to find existing
            if (search(root, 99) == 1) return 3; // Found non-existent

            return 0; // Success
        }
        "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 0);
}

#[test]
fn test_bst_free() {
    let code = r#"
        void free_tree(int *root) {
            if (root == 0) return;

            // Post-order traversal: visit children before the parent
            free_tree(root[1]); // left
            free_tree(root[2]); // right

            free(root);
        }

        int* insert(int *root, int val) {
            if (root == 0) {
                root = malloc(24);
                root[0] = val; root[1] = 0; root[2] = 0;
                return root;
            }
            if (val < root[0]) root[1] = insert(root[1], val);
            else root[2] = insert(root[2], val);
            return root;
        }

        int main() {
            int *root;
            root = 0;
            root = insert(root, 50);
            insert(root, 30);
            insert(root, 70);

            // This validates the recursive calls for deallocation
            free_tree(root);

            return 0; // Success if no VM crash
        }
        "#;
    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 0);
}

#[test]
fn test_double_pointers() {
    let code = r#"
        int main() {
            int a;
            int *p;
            int **pp;
            int **matrix;

            // 1. Basic address-of and double dereference
            a = 10;
            p = &a;
            pp = &p;

            **pp = 42; // Modifies 'a' through the double pointer

            if (a != 42) return 1;
            if (*p != 42) return 2;

            // 2. Dynamic memory and 2D array syntax
            matrix = malloc(8);    // Allocate array of 1 pointer (8 bytes)
            matrix[0] = malloc(8); // Allocate array of 1 integer for the first row

            matrix[0][0] = 123;    // Write via chained brackets

            if (**matrix != 123) return 3;
            if (matrix[0][0] != 123) return 4;

            return 0; // Success
        }
        "#;

    let mut vm = setup_and_compile(code);
    assert_eq!(vm.run().unwrap(), 0);
}
