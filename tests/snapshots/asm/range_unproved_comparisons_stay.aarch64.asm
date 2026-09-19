
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
               	mov	x3, #0x100              // =256
               	str	x3, [x0]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x3, [x2]
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
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x2]
               	eor	x5, x1, #0x2
               	mov	w5, w5
               	cbz	x5, <addr>
               	cmp	x1, #0x2
               	b.hi	<addr>
               	mov	x1, #0x2                // =2
               	cbz	x1, <addr>
               	sxtw	x0, w1
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
               	str	x3, [x4]
               	ldur	x3, [x29, #-0x8]
               	cmp	x3, #0x64
               	b.ge	<addr>
               	mov	x3, #0x3                // =3
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x2]
               	cmp	x3, #0x0
               	b.ls	<addr>
               	sub	x3, x3, #0x11
               	mov	x17, #-0x11             // =-17
               	cmp	x3, x17
               	b.ls	<addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x2]
               	cbz	x0, <addr>
               	lsl	x0, x0, #55
               	cmp	x0, #0x0
               	b.lt	<addr>
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
