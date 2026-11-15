
runtime_range_designator.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	adrp	x3, <page>
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1                // =1
               	str	w1, [x3, #0x20]
               	mov	x2, #0xb                // =11
               	sub	x1, x29, #0x48
               	stur	w2, [x29, #-0x48]
               	ldur	w2, [x29, #-0x48]
               	stur	w2, [x29, #-0x44]
               	stur	w2, [x29, #-0x40]
               	stur	w2, [x29, #-0x3c]
               	stur	w2, [x29, #-0x38]
               	stur	w2, [x29, #-0x34]
               	stur	w2, [x29, #-0x30]
               	stur	w2, [x29, #-0x2c]
               	stur	w2, [x29, #-0x28]
               	stur	w2, [x29, #-0x24]
               	ldur	w2, [x29, #-0x48]
               	stur	w2, [x29, #-0x20]
               	stur	w2, [x29, #-0x1c]
               	stur	w2, [x29, #-0x18]
               	stur	w2, [x29, #-0x14]
               	stur	w2, [x29, #-0x10]
               	stur	w2, [x29, #-0xc]
               	stur	w2, [x29, #-0x8]
               	ldrsw	x2, [x3, #0x20]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	cbz	x0, <addr>
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x3, <page>
               	ldrsw	x0, [x3, #0x20]
               	add	x0, x0, #0x1
               	str	w0, [x3, #0x20]
               	mov	x0, #0x0                // =0
               	mov	x1, #0x2                // =2
               	str	w1, [x3, #0x20]
               	mov	x1, #0x5                // =5
               	str	w1, [x3, #0x20]
               	fmov	s0, #3.00000000
               	stur	s0, [x29, #-0x10]
               	ldur	w1, [x29, #-0x10]
               	stur	w1, [x29, #-0x8]
               	ldrsw	x1, [x3, #0x20]
               	cmp	w1, #0x5
               	b.eq	<addr>
               	mov	x1, #0x67               // =103
               	cbz	x1, <addr>
               	mov	x0, x1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	str	w1, [x3, #0x20]
               	mov	x2, #0x13               // =19
               	sub	x1, x29, #0x48
               	stur	w2, [x29, #-0x48]
               	ldur	w2, [x29, #-0x48]
               	stur	w2, [x29, #-0x44]
               	stur	w2, [x29, #-0x40]
               	stur	w2, [x29, #-0x3c]
               	stur	w2, [x29, #-0x38]
               	stur	w2, [x29, #-0x34]
               	stur	w2, [x29, #-0x30]
               	stur	w2, [x29, #-0x2c]
               	stur	w2, [x29, #-0x28]
               	stur	w2, [x29, #-0x24]
               	ldur	w2, [x29, #-0x48]
               	stur	w2, [x29, #-0x20]
               	stur	w2, [x29, #-0x1c]
               	stur	w2, [x29, #-0x18]
               	stur	w2, [x29, #-0x14]
               	stur	w2, [x29, #-0x10]
               	stur	w2, [x29, #-0xc]
               	stur	w2, [x29, #-0x8]
               	ldrsw	x2, [x3, #0x20]
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	cbz	x0, <addr>
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w2, [x1, x0, lsl #2]
               	cmp	w2, #0x13
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x11
               	b.lt	<addr>
               	adrp	x0, <page>
               	ldrsw	x1, [x0, #0x20]
               	add	x1, x1, #0x1
               	str	w1, [x0, #0x20]
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0xe                // =14
               	b	<addr>
               	ldur	s1, [x29, #-0x10]
               	fcmp	s1, s0
               	b.ne	<addr>
               	ldur	s1, [x29, #-0x8]
               	fcmp	s1, s0
               	b.eq	<addr>
               	mov	x1, #0xd                // =13
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	ldrsw	x2, [x1, x0, lsl #2]
               	cmp	w2, #0xb
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x11
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
