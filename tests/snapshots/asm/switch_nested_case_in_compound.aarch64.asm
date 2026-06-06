
switch_nested_case_in_compound.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0xf0
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x108
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x10e
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x115
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	lsl	x2, x20, #3
               	add	x0, x0, x2
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	lsl	x1, x20, #3
               	add	x1, x21, x1
               	ldr	x0, [x0]
               	str	x0, [x1]
               	b	<addr>
               	lsl	x0, x20, #3
               	add	x0, x21, x0
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x19, [sp]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x2                // =2
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x64               // =100
               	sub	x1, x29, #0x8
               	ldrsw	x2, [x1]
               	add	x2, x2, x0
               	str	w2, [x1]
               	cmp	x0, #0x64
               	b.ne	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x2
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x4
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x4000            // =16384
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x1000            // =4096
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x2000            // =8192
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x11c
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	mov	x0, #0x1                // =1
               	b	<addr>
               	ldursw	x0, [x29, #-0x8]
               	mov	x17, #0x106b            // =4203
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x64               // =100
               	sub	x1, x29, #0x8
               	ldrsw	x2, [x1]
               	add	x2, x2, x0
               	str	w2, [x1]
               	cmp	x0, #0x64
               	b.ne	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x2
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x4
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x4000            // =16384
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x1000            // =4096
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	mov	x17, #0x2000            // =8192
               	orr	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x131
               	ldursw	x1, [x29, #-0x8]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
