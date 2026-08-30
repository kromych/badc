
struct_return_by_value.aarch64:	file format elf64-littleaarch64

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

<echo_small>:
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x0, #0x7                // =7
               	sub	x20, x29, #0x58
               	str	w0, [x20]
               	mov	x0, #0x8                // =8
               	str	w0, [x20, #0x4]
               	sub	x0, x29, #0x70
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x20]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	ldrsw	x1, [x0]
               	cmp	w1, #0x7
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x8
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x21, #0x0               // =0
               	mov	x1, x21
               	mov	x1, x21
               	mov	x1, x21
               	ldr	x0, [x0]
               	bl	<addr>
               	sub	x16, x29, #0x58
               	str	x0, [x16]
               	ldr	w0, [x20]
               	ldr	w1, [x20, #0x4]
               	cmp	w0, #0x7
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	w1, #0x8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x90]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	b	<addr>
               	b	<addr>
