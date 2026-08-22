
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x2, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, #0x0                // =0
               	str	x3, [x2]
               	ldr	x0, [x0]
               	mov	x17, #0xff              // =255
               	and	x3, x0, x17
               	cbnz	x3, <addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x1]
               	mov	x17, #0x2               // =2
               	eor	x3, x0, x17
               	mov	w3, w3
               	cbz	x3, <addr>
               	cmp	x0, #0x2
               	b.hi	<addr>
               	mov	x0, #0x2                // =2
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	str	x0, [x2]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x64
               	b.ge	<addr>
               	ldr	x0, [x2]
               	mov	x2, #0x100              // =256
               	str	x2, [x0]
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x64
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x1]
               	cmp	x2, #0x0
               	cset	x0, hi
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	sub	x0, x2, #0x11
               	mov	x17, #0xffef            // =65519
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.ls	<addr>
               	mov	x0, #0x4                // =4
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x1]
               	cbz	x0, <addr>
               	lsl	x0, x0, #55
               	cmp	x0, #0x0
               	b.lt	<addr>
               	mov	x0, #0x5                // =5
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
