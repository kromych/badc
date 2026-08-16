
local_array_runtime_nested_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0xb0]
               	mov	x0, #0x6                // =6
               	stur	w0, [x29, #-0xa8]
               	mov	x0, #0x7                // =7
               	stur	w0, [x29, #-0xa0]
               	mov	x0, #0x8                // =8
               	stur	w0, [x29, #-0x98]
               	sub	x0, x29, #0xb0
               	sub	x2, x29, #0xa8
               	sub	x3, x29, #0xa0
               	sub	x4, x29, #0x98
               	ldrsw	x0, [x0]
               	cmp	x0, #0x5
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	ldrsw	x0, [x2]
               	cmp	x0, #0x6
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrsw	x0, [x3]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x4]
               	cmp	x0, #0x8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa0
               	sub	x2, x29, #0x98
               	ldrsw	x0, [x1]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x2]
               	cmp	x0, #0x8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0xa8
               	mov	x0, #0x0                // =0
               	ldrsw	x0, [x1]
               	cmp	x0, #0x6
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
