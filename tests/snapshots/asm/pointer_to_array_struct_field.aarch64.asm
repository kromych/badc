
pointer_to_array_struct_field.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x300              // =768
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x20, x29, #0x8
               	mov	x0, #0x40               // =64
               	bl	<addr>
               	str	x0, [x20]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	sxtw	x3, w1
               	lsl	x4, x3, #4
               	add	x0, x0, x4
               	sxtw	x4, w2
               	mov	x17, #0x64              // =100
               	mul	x3, x3, x17
               	add	x3, x3, x4
               	sxtw	x5, w3
               	strh	w5, [x0, x4, lsl #1]
               	b	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	strh	w1, [x0]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	ldrsh	x0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	sxtw	x3, w1
               	lsl	x4, x3, #4
               	add	x0, x0, x4
               	sxtw	x4, w2
               	ldrsh	x0, [x0, x4, lsl #1]
               	mov	x17, #0x64              // =100
               	mul	x3, x3, x17
               	add	x3, x3, x4
               	sxtw	x4, w3
               	sxth	x3, w4
               	cmp	x0, x3
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	lsl	x0, x1, #3
               	add	x0, x0, #0xa
               	add	x0, x0, x2
               	sxtw	x0, w0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x63               // =99
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
