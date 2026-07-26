
int128_struct_fallback.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x250
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	mov	x3, #0x1                // =1
               	sub	x0, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x3, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x3, #0x1000000000       // =68719476736
               	sub	x0, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	ldr	x3, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x3, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x3, #-0x800000000000000 // =-576460752303423488
               	sub	x0, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	str	x1, [x0]
               	sub	x0, x29, #0x20
               	str	x3, [x0, #0x8]
               	sub	x0, x29, #0x20
               	ldr	x1, [x0, #0x8]
               	mov	x17, #-0x800000000000000 // =-576460752303423488
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
