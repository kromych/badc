
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
               	mov	x2, x0
               	cbnz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x3, #0x0                // =0
               	mov	x7, #0x64               // =100
               	b	<addr>
               	sxtw	x1, w3
               	lsl	x5, x1, #4
               	add	x4, x2, x5
               	add	x9, x4, #0x0
               	mul	x0, x1, x7
               	add	x6, x0, #0x0
               	mov	x8, x6
               	strh	w8, [x9]
               	add	x6, x0, #0x1
               	mov	x8, x6
               	strh	w8, [x4, #0x2]
               	add	x6, x0, #0x2
               	mov	x8, x6
               	strh	w8, [x4, #0x4]
               	add	x6, x0, #0x3
               	mov	x8, x6
               	strh	w8, [x4, #0x6]
               	add	x6, x0, #0x4
               	mov	x8, x6
               	strh	w8, [x4, #0x8]
               	add	x6, x0, #0x5
               	mov	x8, x6
               	strh	w8, [x4, #0xa]
               	add	x0, x0, #0x6
               	mov	x5, x0
               	strh	w5, [x4, #0xc]
               	lsl	x0, x1, #4
               	add	x4, x2, x0
               	mul	x0, x1, x7
               	add	x0, x0, #0x7
               	mov	x5, x0
               	strh	w5, [x4, #0xe]
               	add	x3, x1, #0x1
               	cmp	w3, #0x4
               	b.lt	<addr>
               	mov	x8, #0x0                // =0
               	mov	x7, #0x64               // =100
               	mov	x3, x8
               	b	<addr>
               	sxtw	x1, w3
               	lsl	x5, x1, #4
               	add	x4, x2, x5
               	add	x0, x4, #0x0
               	ldrsh	x9, [x0]
               	mul	x0, x1, x7
               	add	x6, x0, #0x0
               	mov	x10, x6
               	sxth	x6, w10
               	cmp	w9, w6
               	b.ne	<addr>
               	mov	x11, #0x1               // =1
               	ldrsh	x9, [x4, #0x2]
               	add	x6, x0, #0x1
               	mov	x10, x6
               	sxth	x6, w10
               	cmp	w9, w6
               	b.ne	<addr>
               	mov	x11, #0x2               // =2
               	ldrsh	x9, [x4, #0x4]
               	add	x6, x0, #0x2
               	mov	x10, x6
               	sxth	x6, w10
               	cmp	w9, w6
               	b.ne	<addr>
               	mov	x11, #0x3               // =3
               	ldrsh	x9, [x4, #0x6]
               	add	x6, x0, #0x3
               	mov	x10, x6
               	sxth	x6, w10
               	cmp	w9, w6
               	b.ne	<addr>
               	mov	x11, #0x4               // =4
               	ldrsh	x9, [x4, #0x8]
               	add	x6, x0, #0x4
               	mov	x10, x6
               	sxth	x6, w10
               	cmp	w9, w6
               	b.ne	<addr>
               	mov	x9, #0x5                // =5
               	ldrsh	x5, [x4, #0xa]
               	add	x4, x0, #0x5
               	mov	x6, x4
               	sxth	x4, w6
               	cmp	w5, w4
               	b.ne	<addr>
               	mov	x10, #0x6               // =6
               	lsl	x5, x1, #4
               	add	x4, x2, x5
               	ldrsh	x6, [x4, #0xc]
               	add	x0, x0, #0x6
               	mov	x9, x0
               	sxth	x0, w9
               	cmp	w6, w0
               	b.ne	<addr>
               	mov	x6, #0x7                // =7
               	ldrsh	x4, [x4, #0xe]
               	mul	x0, x1, x7
               	add	x0, x0, #0x7
               	mov	x5, x0
               	sxth	x0, w5
               	cmp	w4, w0
               	b.ne	<addr>
               	add	x3, x1, #0x1
               	cmp	w3, #0x4
               	b.lt	<addr>
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	strh	w0, [x2]
               	mov	x0, x2
               	bl	<addr>
               	uxtb	w0, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x8, x6
               	lsl	x0, x3, #3
               	add	x0, x0, #0xa
               	add	x0, x0, x8
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x8, x10
               	b	<addr>
               	mov	x8, x9
               	b	<addr>
               	mov	x8, x11
               	b	<addr>
               	mov	x8, x11
               	b	<addr>
               	mov	x8, x11
               	b	<addr>
               	mov	x8, x11
               	b	<addr>
               	b	<addr>
