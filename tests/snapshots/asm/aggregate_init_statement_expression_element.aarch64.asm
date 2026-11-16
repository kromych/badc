
aggregate_init_statement_expression_element.aarch64:	file format elf64-littleaarch64

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

<opaque>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x0, #0x1000             // =4096
               	stur	w0, [x29, #-0x8]
               	ldursw	x20, [x29, #-0x8]
               	sub	x0, x29, #0x18
               	mov	x1, #0xc3d4             // =50132
               	movk	x1, #0xa1b2, lsl #16
               	movk	x1, #0x2, lsl #32
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0x100              // =256
               	cmp	w20, #0x100
               	csel	x1, x20, x1, gt
               	add	x1, x1, #0x30
               	stur	w1, [x29, #-0x10]
               	bl	<addr>
               	ldr	w1, [x0]
               	mov	x17, #0xc3d4            // =50132
               	movk	x17, #0xa1b2, lsl #16
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x5                // =5
               	stur	w0, [x29, #-0x8]
               	ldursw	x20, [x29, #-0x8]
               	sub	x0, x29, #0x18
               	stur	w20, [x29, #-0x18]
               	mov	x1, #0x15               // =21
               	stur	w1, [x29, #-0x14]
               	mov	x1, #0x1e               // =30
               	stur	w1, [x29, #-0x10]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, w20
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x9                // =9
               	stur	w0, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	sub	x0, x29, #0x18
               	stur	w1, [x29, #-0x18]
               	mov	x2, #0x7                // =7
               	stur	w2, [x29, #-0x14]
               	add	x2, x1, #0x1
               	add	x3, x1, #0x2
               	add	x4, x1, #0x3
               	add	x2, x2, x3
               	add	x2, x2, x4
               	stur	w2, [x29, #-0x10]
               	str	x1, [sp, #0x18]
               	bl	<addr>
               	ldr	x1, [sp, #0x18]
               	ldr	w2, [x0]
               	cmp	w2, w1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	cbz	w0, <addr>
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	ldr	w2, [x0, #0x4]
               	cmp	w2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	b	<addr>
               	ldr	w0, [x0, #0x8]
               	add	x1, x1, x1, lsl #1
               	add	x1, x1, #0x6
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x15
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	b	<addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	ldr	w1, [x0, #0x4]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	ldr	w0, [x0, #0x8]
               	mov	x1, #0x100              // =256
               	cmp	w20, #0x100
               	csel	x1, x20, x1, gt
               	add	x1, x1, #0x30
               	cmp	w0, w1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
