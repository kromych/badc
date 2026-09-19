
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x40               // =64
               	bl	<addr>
               	mov	x2, x0
               	cbnz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x6, #0x64               // =100
               	cmp	w0, #0x4
               	b.ge	<addr>
               	lsl	x4, x0, #4
               	add	x3, x2, x4
               	add	x7, x3, #0x0
               	mul	x1, x0, x6
               	add	x5, x1, #0x0
               	strh	w5, [x7]
               	add	x5, x1, #0x1
               	strh	w5, [x3, #0x2]
               	add	x5, x1, #0x2
               	strh	w5, [x3, #0x4]
               	add	x5, x1, #0x3
               	strh	w5, [x3, #0x6]
               	add	x5, x1, #0x4
               	strh	w5, [x3, #0x8]
               	add	x5, x1, #0x5
               	strh	w5, [x3, #0xa]
               	add	x5, x1, #0x6
               	strh	w5, [x3, #0xc]
               	add	x3, x2, x4
               	add	x1, x1, #0x7
               	strh	w1, [x3, #0xe]
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x7, #0x0                // =0
               	mov	x6, #0x64               // =100
               	mov	x0, x7
               	cmp	w0, #0x4
               	b.ge	<addr>
               	lsl	x4, x0, #4
               	add	x3, x2, x4
               	add	x1, x3, #0x0
               	ldrsh	x8, [x1]
               	mul	x1, x0, x6
               	add	x5, x1, #0x0
               	sxth	x5, w5
               	cmp	w8, w5
               	b.ne	<addr>
               	mov	x9, #0x1                // =1
               	ldrsh	x8, [x3, #0x2]
               	add	x5, x1, #0x1
               	sxth	x5, w5
               	cmp	w8, w5
               	b.ne	<addr>
               	mov	x9, #0x2                // =2
               	ldrsh	x8, [x3, #0x4]
               	add	x5, x1, #0x2
               	sxth	x5, w5
               	cmp	w8, w5
               	b.ne	<addr>
               	mov	x9, #0x3                // =3
               	ldrsh	x8, [x3, #0x6]
               	add	x5, x1, #0x3
               	sxth	x5, w5
               	cmp	w8, w5
               	b.ne	<addr>
               	mov	x9, #0x4                // =4
               	ldrsh	x8, [x3, #0x8]
               	add	x5, x1, #0x4
               	sxth	x5, w5
               	cmp	w8, w5
               	b.ne	<addr>
               	mov	x9, #0x5                // =5
               	ldrsh	x8, [x3, #0xa]
               	add	x5, x1, #0x5
               	sxth	x5, w5
               	cmp	w8, w5
               	b.ne	<addr>
               	mov	x5, #0x6                // =6
               	ldrsh	x3, [x3, #0xc]
               	add	x1, x1, #0x6
               	sxth	x1, w1
               	cmp	w3, w1
               	b.ne	<addr>
               	mov	x4, #0x7                // =7
               	lsl	x1, x0, #4
               	add	x1, x2, x1
               	ldrsh	x3, [x1, #0xe]
               	mul	x1, x0, x6
               	add	x1, x1, #0x7
               	sxth	x1, w1
               	cmp	w3, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #-0x1               // =-1
               	strh	w0, [x2]
               	mov	x0, x2
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x7, x4
               	lsl	x0, x0, #3
               	add	x0, x0, #0xa
               	add	x0, x0, x7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x7, x5
               	b	<addr>
               	mov	x7, x9
               	b	<addr>
               	mov	x7, x9
               	b	<addr>
               	mov	x7, x9
               	b	<addr>
               	mov	x7, x9
               	b	<addr>
               	mov	x7, x9
               	b	<addr>
