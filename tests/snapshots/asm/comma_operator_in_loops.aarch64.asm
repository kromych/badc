
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
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x13, x19
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x0, [x0]
               	str	x0, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x0, x19
               	lsl	x20, x20, #3
               	add	x0, x0, x20
               	ldr	x0, [x0]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	sxtw	x0, w0
               	adrp	x19, <page>
               	add	x19, x19, #0x148
               	mov	x14, x19
               	ldrsw	x13, [x14]
               	add	x13, x13, #0x1
               	str	w13, [x14]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x8]
               	stur	w15, [x29, #-0x10]
               	b	<addr>
               	sub	x15, x29, #0x10
               	ldrsw	x14, [x15]
               	add	x14, x14, #0xa
               	str	w14, [x15]
               	b	<addr>
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	bl	<addr>
               	cbnz	x20, <addr>
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	cbz	x0, <addr>
               	sub	x21, x29, #0x10
               	ldrsw	x0, [x21]
               	add	x0, x0, #0x64
               	str	w0, [x21]
               	b	<addr>
               	mov	x20, #0x7               // =7
               	mov	x0, x20
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	b	<addr>
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x8]
               	b	<addr>
               	sub	x20, x29, #0x10
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x21, [x0]
               	add	x21, x21, #0x3e8
               	str	w21, [x0]
               	b	<addr>
               	sub	x21, x29, #0x10
               	ldrsw	x20, [x21]
               	mov	x17, #0x869f            // =34463
               	movk	x17, #0x1, lsl #16
               	add	x20, x20, x17
               	str	w20, [x21]
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	b	<addr>
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	bl	<addr>
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x3
               	b.ge	<addr>
               	b	<addr>
               	sub	x22, x29, #0x8
               	ldrsw	x0, [x22]
               	add	x0, x0, #0x1
               	str	w0, [x22]
               	b	<addr>
               	sub	x0, x29, #0x10
               	ldrsw	x21, [x0]
               	add	x21, x21, #0x1
               	str	w21, [x0]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0x148
               	mov	x21, x19
               	ldrsw	x21, [x21]
               	cmp	x21, #0x7
               	b.eq	<addr>
               	mov	x22, #0x1               // =1
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldursw	x21, [x29, #-0x10]
               	sub	x21, x21, #0x456
               	sxtw	x21, w21
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
