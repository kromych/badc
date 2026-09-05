
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x3, #0x100              // =256
               	str	x3, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x3, [x2]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x0, #0x0                // =0
               	str	x0, [x4]
               	ldr	x1, [x1]
               	mov	x17, #0xff              // =255
               	and	x5, x1, x17
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
               	mov	x17, #0x2               // =2
               	eor	x5, x1, x17
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
               	mov	x0, #0x3                // =3
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x2]
               	cmp	x0, #0x0
               	b.ls	<addr>
               	sub	x0, x0, #0x11
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
               	mov	x0, #0x0                // =0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
