
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
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x20, #0x0               // =0
               	cmp	w20, #0x37
               	b.ge	<addr>
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x17, #0x18              // =24
               	mul	x23, x20, x17
               	add	x21, x22, x23
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
               	cmp	w20, #0x2f
               	b.ge	<addr>
               	sub	x25, x29, #0x50
               	adrp	x23, <page>
               	add	x23, x23, <lo12>
               	mov	x17, #0x30              // =48
               	mul	x24, x20, x17
               	add	x22, x23, x24
               	ldr	x1, [x22]
               	ldrsw	x2, [x22, #0x8]
               	mov	x0, x25
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	sub	x21, x29, #0x10
               	mov	x0, #-0x2               // =-2
               	str	w0, [x21]
               	str	w0, [x21, #0x4]
               	str	w0, [x21, #0x8]
               	str	w0, [x21, #0xc]
               	ldr	x1, [x22, #0x10]
               	mov	x2, #0x2                // =2
               	add	x0, x23, x24
               	ldrsw	x4, [x0, #0x18]
               	mov	x0, x25
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x17, #0x30              // =48
               	mul	x3, x20, x17
               	add	x0, x2, x3
               	ldrsw	x4, [x0, #0x1c]
               	cmp	w1, w4
               	b.ne	<addr>
               	cbnz	w1, <addr>
               	ldrsw	x1, [x21]
               	ldrsw	x4, [x0, #0x20]
               	cmp	w1, w4
               	b.ne	<addr>
               	ldrsw	x1, [x21, #0x4]
               	ldrsw	x4, [x0, #0x24]
               	cmp	w1, w4
               	b.ne	<addr>
               	ldrsw	x1, [x21, #0x8]
               	ldrsw	x4, [x0, #0x28]
               	cmp	w1, w4
               	b.ne	<addr>
               	sub	x1, x29, #0x10
               	ldrsw	x1, [x1, #0xc]
               	ldrsw	x0, [x0, #0x2c]
               	cmp	w1, w0
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	sub	x0, x29, #0x50
               	bl	<addr>
               	add	x20, x20, #0x1
               	cmp	w20, #0x2f
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x0, x29, #0x50
               	bl	<addr>
               	add	x0, x20, #0x38
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x0, x29, #0x50
               	bl	<addr>
               	add	x0, x20, #0x38
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	add	x0, x20, #0x38
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	add	x0, x20, #0x1
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
