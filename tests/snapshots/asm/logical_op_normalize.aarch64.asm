
logical_op_normalize.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, x0
               	sxtw	x1, w1
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	cmp	x1, #0x0
               	cset	x0, gt
               	cmp	x0, #0x0
               	cset	x0, ne
               	ret
               	b	<addr>

<or_rr>:
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x2, gt
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	cmp	x1, #0x0
               	cset	x0, ne
               	ret
               	b	<addr>

<and_ll>:
               	mov	x2, x0
               	sxtw	x1, w1
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	cmp	x1, #0x0
               	cset	x0, gt
               	cmp	x0, #0x0
               	cset	x0, ne
               	ret
               	b	<addr>

<and_rr>:
               	mov	x2, x0
               	sxtw	x2, w2
               	sxtw	x1, w1
               	mov	x0, #0x0                // =0
               	cbz	x2, <addr>
               	cmp	x1, #0x0
               	cset	x0, ne
               	ret
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x20, [x0]
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x5                // =5
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	sub	x21, x29, #0x10
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	ldrsw	x0, [x21, x0, lsl #2]
               	cmp	x0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x21, x29, #0x10
               	mov	x0, #0x0                // =0
               	mov	x1, #0x9                // =9
               	bl	<addr>
               	ldrsw	x0, [x21, x0, lsl #2]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x1                // =1
               	cbnz	x20, <addr>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	mov	x1, #0x0                // =0
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x1                // =1
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
