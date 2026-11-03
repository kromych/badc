
decl_specifier_order.aarch64:	file format elf64-littleaarch64

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

<takes_qualified>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	stur	x3, [x29, #-0x10]
               	stur	w2, [x29, #-0x20]
               	stur	w3, [x29, #-0x10]
               	ldursw	x0, [x29, #-0x20]
               	add	x0, x0, #0x2
               	sub	x1, x29, #0x10
               	ldar	w1, [x1]
               	add	x0, x0, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x18]
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x20]
               	adrp	x1, <page>
               	ldr	w1, [x1, #0x28]
               	add	x0, x0, x1
               	add	x0, x0, #0x2
               	cmp	w0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x30]
               	cmp	w0, #0x0
               	b.hi	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x40]
               	cmp	w0, #0x64
               	b.gt	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	w0, [x0, #0x48]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldrsw	x0, [x0, #0x50]
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x58]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldar	w1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldar	w1, [x1]
               	add	x0, x0, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldar	w1, [x1]
               	add	x0, x0, x1
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	ldrsw	x0, [x0]
               	adrp	x1, <page>
               	ldrsw	x1, [x1, #0x78]
               	add	x0, x0, x1
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, x0
               	mov	x3, x0
               	mov	x2, x0
               	bl	<addr>
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4                // =4
               	stur	w0, [x29, #-0x20]
               	stur	w0, [x29, #-0x18]
               	stur	w0, [x29, #-0x10]
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x20]
               	ldursw	x1, [x29, #-0x18]
               	add	x0, x0, x1
               	sub	x1, x29, #0x10
               	ldar	w1, [x1]
               	add	x0, x0, x1
               	sub	x1, x29, #0x8
               	ldar	w1, [x1]
               	add	x0, x0, x1
               	add	x0, x0, #0x4
               	cmp	w0, #0x14
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
