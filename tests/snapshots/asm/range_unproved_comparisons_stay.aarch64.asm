
range_unproved_comparisons_stay.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x100              // =256
               	str	x2, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x2, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	str	x0, [x4]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	and	x5, x1, #0xff
               	cbnz	x5, <addr>
               	cbnz	x1, <addr>
               	mov	x1, #0x1                // =1
               	cbz	x1, <addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x5, [x3]
               	eor	x1, x5, #0x2
               	cbz	w1, <addr>
               	cmp	x5, #0x2
               	b.hi	<addr>
               	mov	x1, #0x2                // =2
               	cbz	w1, <addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x5                // =5
               	stur	x1, [x29, #-0x8]
               	sub	x5, x29, #0x8
               	str	x5, [x4]
               	ldur	x5, [x29, #-0x8]
               	cmp	x5, #0x64
               	b.ge	<addr>
               	ldr	x4, [x4]
               	str	x2, [x4]
               	ldur	x2, [x29, #-0x8]
               	cmp	x2, #0x64
               	b.ge	<addr>
               	mov	x2, #0x3                // =3
               	cbz	w2, <addr>
               	mov	x0, x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x3]
               	cmp	x2, #0x0
               	b.ls	<addr>
               	sub	x2, x2, #0x11
               	mov	x17, #-0x11             // =-17
               	cmp	x2, x17
               	b.ls	<addr>
               	mov	x0, #0x4                // =4
               	cbz	w0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x3]
               	cbz	x0, <addr>
               	lsl	x0, x0, #55
               	cmp	x0, #0x0
               	b.lt	<addr>
               	cbz	w1, <addr>
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
