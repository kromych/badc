
code_address_plus_offset_initializer.aarch64:	file format elf64-littleaarch64

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

<before>:
               	mov	x0, #0x1                // =1
               	ret

<after>:
               	mov	x0, #0x2                // =2
               	ret

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x0, x1
               	cmp	x0, #0x4
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	sub	x1, x2, x1
               	cmp	x1, #0x8
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x1, x1, x2
               	mov	x17, #-0x2              // =-2
               	cmp	x1, x17
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	cmp	w1, #0x3
               	cset	x1, eq
               	cbz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x1, x1, x2
               	cmp	x1, #0x10
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	cmp	w0, #0x0
               	cset	x0, eq
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
