
pointer_to_array_struct_field.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x300              // =768
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x50]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x20, x29, #0x8
               	mov	x0, #0x40               // =64
               	bl	<addr>
               	str	x0, [x20]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	sxtw	x2, w1
               	lsl	x3, x2, #4
               	add	x0, x0, x3
               	add	x0, x0, #0x0
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	add	x2, x2, #0x0
               	sxtw	x3, w2
               	strh	w3, [x0]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	sxtw	x2, w1
               	lsl	x3, x2, #4
               	add	x0, x0, x3
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	add	x2, x2, #0x1
               	sxtw	x3, w2
               	strh	w3, [x0, #0x2]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	sxtw	x2, w1
               	lsl	x3, x2, #4
               	add	x0, x0, x3
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	add	x2, x2, #0x2
               	sxtw	x3, w2
               	strh	w3, [x0, #0x4]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	sxtw	x2, w1
               	lsl	x3, x2, #4
               	add	x0, x0, x3
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	add	x2, x2, #0x3
               	sxtw	x3, w2
               	strh	w3, [x0, #0x6]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	sxtw	x2, w1
               	lsl	x3, x2, #4
               	add	x0, x0, x3
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	add	x2, x2, #0x4
               	sxtw	x3, w2
               	strh	w3, [x0, #0x8]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	sxtw	x2, w1
               	lsl	x3, x2, #4
               	add	x0, x0, x3
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	add	x2, x2, #0x5
               	sxtw	x3, w2
               	strh	w3, [x0, #0xa]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	sxtw	x2, w1
               	lsl	x3, x2, #4
               	add	x0, x0, x3
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	add	x2, x2, #0x6
               	sxtw	x3, w2
               	strh	w3, [x0, #0xc]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	sxtw	x2, w1
               	lsl	x3, x2, #4
               	add	x0, x0, x3
               	mov	x17, #0x64              // =100
               	mul	x2, x2, x17
               	add	x2, x2, #0x7
               	sxtw	x3, w2
               	strh	w3, [x0, #0xe]
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x4
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
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
               	b.ne	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	sxtw	x0, w2
               	cmp	x0, #0x8
               	b.lt	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	sxtw	x0, w1
               	cmp	x0, #0x4
               	b.lt	<addr>
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
               	mov	x0, #0x63               // =99
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x50
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
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x50
               	ret
               	lsl	x0, x1, #3
               	add	x0, x0, #0xa
               	add	x0, x0, x2
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x50
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
