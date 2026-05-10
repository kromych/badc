#include <stdlib.h>

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
    arr = malloc(5 * sizeof(int));
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
