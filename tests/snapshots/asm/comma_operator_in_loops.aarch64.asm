
comma_operator_in_loops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe8]
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
               	add	x21, x21, #0xf8
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
               	add	x2, x2, #0x110
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	adrp	x2, <page>
               	add	x2, x2, #0x116
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x10
               	adrp	x2, <page>
               	add	x2, x2, #0x11d
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
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, #0x128
               	ldrsw	x2, [x1]
               	add	x2, x2, #0x1
               	str	w2, [x1]
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	str	x20, [sp]
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	stur	w0, [x29, #-0x10]
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0xa
               	str	w1, [x0]
               	b	<addr>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	bl	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x64
               	str	w1, [x0]
               	b	<addr>
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x8]
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x3e8
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	mov	x17, #0x869f            // =34463
               	movk	x17, #0x1, lsl #16
               	add	x1, x1, x17
               	str	w1, [x0]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x128
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x0, [x29, #-0x10]
               	sub	x0, x0, #0x456
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
