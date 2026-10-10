
pattern_match_posix.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x20, #0x0               // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x18              // =24
               	mul	x1, x20, x17
               	add	x21, x0, x1
               	ldr	x0, [x21]
               	ldr	x1, [x21, #0x8]
               	ldrsw	x2, [x21, #0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	ldrsw	x1, [x21, #0x14]
               	cmp	w0, w1
               	b.ne	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x37
               	b.lt	<addr>
               	mov	x20, #0x0               // =0
               	sub	x22, x29, #0x40
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	mov	x17, #0x30              // =48
               	mul	x24, x20, x17
               	add	x21, x23, x24
               	ldr	x1, [x21]
               	ldrsw	x2, [x21, #0x8]
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x3, x29, #0x50
               	mov	x0, #-0x2               // =-2
               	stur	w0, [x29, #-0x50]
               	stur	w0, [x29, #-0x4c]
               	stur	w0, [x29, #-0x48]
               	stur	w0, [x29, #-0x44]
               	ldr	x1, [x21, #0x10]
               	mov	x2, #0x2                // =2
               	add	x0, x23, x24
               	ldrsw	x4, [x0, #0x18]
               	mov	x0, x22
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x1, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0x30              // =48
               	mul	x2, x20, x17
               	add	x0, x0, x2
               	ldrsw	x2, [x0, #0x1c]
               	cmp	w1, w2
               	b.ne	<addr>
               	cbnz	w1, <addr>
               	ldursw	x1, [x29, #-0x50]
               	ldrsw	x2, [x0, #0x20]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x4c]
               	ldrsw	x2, [x0, #0x24]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x48]
               	ldrsw	x2, [x0, #0x28]
               	cmp	w1, w2
               	b.ne	<addr>
               	ldursw	x1, [x29, #-0x44]
               	ldrsw	x0, [x0, #0x2c]
               	cmp	w1, w0
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x2f
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x0, x29, #0x40
               	bl	<addr>
               	add	x0, x20, #0x38
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x0, x29, #0x40
               	bl	<addr>
               	add	x0, x20, #0x38
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	add	x0, x20, #0x38
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	add	x0, x20, #0x1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
