
pointer_to_array_struct_field.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x40               // =64
               	bl	<addr>
               	mov	x4, x0
               	cbnz	x4, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x3, #0x0                // =0
               	b	<addr>
               	lsl	x5, x1, #4
               	add	x2, x4, x5
               	add	x8, x2, #0x0
               	mov	x17, #0x64              // =100
               	mul	x0, x1, x17
               	add	x6, x0, #0x0
               	sxtw	x7, w6
               	strh	w7, [x8]
               	add	x6, x0, #0x1
               	sxtw	x7, w6
               	strh	w7, [x2, #0x2]
               	add	x6, x0, #0x2
               	sxtw	x7, w6
               	strh	w7, [x2, #0x4]
               	add	x6, x0, #0x3
               	sxtw	x7, w6
               	strh	w7, [x2, #0x6]
               	add	x6, x0, #0x4
               	sxtw	x7, w6
               	strh	w7, [x2, #0x8]
               	add	x6, x0, #0x5
               	sxtw	x7, w6
               	strh	w7, [x2, #0xa]
               	add	x0, x0, #0x6
               	sxtw	x5, w0
               	strh	w5, [x2, #0xc]
               	lsl	x0, x1, #4
               	add	x2, x4, x0
               	mov	x17, #0x64              // =100
               	mul	x0, x1, x17
               	add	x0, x0, #0x7
               	sxtw	x5, w0
               	strh	w5, [x2, #0xe]
               	add	x3, x1, #0x1
               	sxtw	x1, w3
               	cmp	x1, #0x4
               	b.lt	<addr>
               	mov	x5, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	lsl	x2, x3, #4
               	add	x2, x4, x2
               	ldrsh	x6, [x2, x1, lsl #1]
               	mov	x17, #0x64              // =100
               	mul	x2, x3, x17
               	add	x2, x2, x1
               	sxtw	x7, w2
               	sxth	x2, w7
               	cmp	x6, x2
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	add	x5, x3, #0x1
               	sxtw	x3, w5
               	cmp	x3, #0x4
               	b.lt	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	strh	w0, [x4]
               	sxth	x0, w0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x63               // =99
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, x4
               	bl	<addr>
               	uxtb	w0, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	lsl	x1, x5, #3
               	add	x1, x1, #0xa
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
