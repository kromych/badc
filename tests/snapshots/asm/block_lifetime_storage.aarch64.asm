
block_lifetime_storage.aarch64:	file format elf64-littleaarch64

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

<volatiles>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x10]
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, #0x1
               	stur	w1, [x29, #-0x8]
               	ldursw	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, #0x1                // =1
               	stur	w2, [x29, #-0x8]
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	ldrsw	x3, [x0]
               	add	x3, x3, #0xa
               	str	w3, [x0]
               	ldursw	x4, [x29, #-0x8]
               	mov	x3, #0x2                // =2
               	stur	w3, [x29, #-0x8]
               	str	x0, [x1]
               	ldrsw	x5, [x0]
               	add	x5, x5, #0x14
               	str	w5, [x0]
               	ldursw	x5, [x29, #-0x8]
               	add	x5, x4, x5
               	mov	x4, #0x3                // =3
               	stur	w4, [x29, #-0x8]
               	str	x0, [x1]
               	ldrsw	x6, [x0]
               	add	x6, x6, #0x1e
               	str	w6, [x0]
               	ldursw	x6, [x29, #-0x8]
               	add	x5, x5, x6
               	mov	x6, #0x4                // =4
               	stur	w6, [x29, #-0x8]
               	str	x0, [x1]
               	ldrsw	x6, [x0]
               	add	x6, x6, #0x28
               	str	w6, [x0]
               	ldursw	x6, [x29, #-0x8]
               	add	x5, x5, x6
               	cmp	w5, #0x6e
               	b.eq	<addr>
               	mov	x0, x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x5                // =5
               	stur	w2, [x29, #-0x10]
               	sub	x2, x29, #0x10
               	str	x2, [x1]
               	mov	x5, #0x6                // =6
               	stur	w5, [x29, #-0x8]
               	str	x0, [x1]
               	ldrsw	x5, [x0]
               	add	x5, x5, #0x1
               	str	w5, [x0]
               	ldursw	x5, [x29, #-0x8]
               	cmp	w5, #0x7
               	b.eq	<addr>
               	mov	x0, x3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	str	x2, [x1]
               	ldrsw	x5, [x2]
               	add	x5, x5, #0x64
               	str	w5, [x2]
               	ldursw	x5, [x29, #-0x10]
               	cmp	w5, #0x69
               	b.ne	<addr>
               	mov	x3, #0x7                // =7
               	stur	w3, [x29, #-0x8]
               	str	x0, [x1]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x0, [x3]
               	ldrsw	x1, [x0]
               	lsl	x1, x1, #1
               	str	w1, [x0]
               	ldursw	x5, [x29, #-0x8]
               	mov	x0, #0x7788             // =30600
               	movk	x0, #0x5566, lsl #16
               	movk	x0, #0x3344, lsl #32
               	movk	x0, #0x1122, lsl #48
               	stur	x0, [x29, #-0x8]
               	sub	x1, x29, #0x8
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x1, [x0]
               	ldr	x6, [x1]
               	eor	x6, x6, #0x1
               	str	x6, [x1]
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	add	x0, x5, x0
               	mov	x5, #0x9                // =9
               	stur	w5, [x29, #-0x8]
               	str	x1, [x3]
               	ldrsw	x5, [x1]
               	add	x5, x5, #0x1
               	str	w5, [x1]
               	ldursw	x5, [x29, #-0x8]
               	add	x0, x0, x5
               	mov	x17, #0x77a1            // =30625
               	movk	x17, #0x5566, lsl #16
               	movk	x17, #0x3344, lsl #32
               	movk	x17, #0x1122, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, x4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x4, x0
               	stur	w0, [x29, #-0x10]
               	str	x2, [x3]
               	ldrsw	x5, [x2]
               	add	x5, x5, #0x1
               	str	w5, [x2]
               	ldursw	x5, [x29, #-0x10]
               	add	x4, x4, x5
               	stur	w0, [x29, #-0x8]
               	str	x1, [x3]
               	ldrsw	x5, [x1]
               	add	x5, x5, #0x2
               	str	w5, [x1]
               	ldursw	x5, [x29, #-0x8]
               	add	x4, x4, x5
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lt	<addr>
               	cmp	w4, #0xf
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	w0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
