
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
               	mov	x3, x0
               	cbnz	x3, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x5, #0x64               // =100
               	lsl	x4, x2, #4
               	add	x1, x3, x4
               	mul	x0, x2, x5
               	strh	w0, [x1]
               	add	x6, x0, #0x1
               	strh	w6, [x1, #0x2]
               	add	x6, x0, #0x2
               	strh	w6, [x1, #0x4]
               	add	x6, x0, #0x3
               	strh	w6, [x1, #0x6]
               	add	x6, x0, #0x4
               	strh	w6, [x1, #0x8]
               	add	x6, x0, #0x5
               	strh	w6, [x1, #0xa]
               	add	x6, x0, #0x6
               	strh	w6, [x1, #0xc]
               	add	x1, x3, x4
               	add	x0, x0, #0x7
               	strh	w0, [x1, #0xe]
               	add	x2, x2, #0x1
               	cmp	w2, #0x4
               	b.lt	<addr>
               	mov	x5, #0x0                // =0
               	mov	x4, #0x64               // =100
               	mov	x0, x5
               	lsl	x1, x0, #4
               	add	x1, x3, x1
               	ldrsh	x6, [x1]
               	mul	x2, x0, x4
               	sxth	x7, w2
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x8, #0x1                // =1
               	ldrsh	x6, [x1, #0x2]
               	add	x7, x2, #0x1
               	sxth	x7, w7
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x8, #0x2                // =2
               	ldrsh	x6, [x1, #0x4]
               	add	x7, x2, #0x2
               	sxth	x7, w7
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x8, #0x3                // =3
               	ldrsh	x6, [x1, #0x6]
               	add	x7, x2, #0x3
               	sxth	x7, w7
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x8, #0x4                // =4
               	ldrsh	x6, [x1, #0x8]
               	add	x7, x2, #0x4
               	sxth	x7, w7
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x8, #0x5                // =5
               	ldrsh	x6, [x1, #0xa]
               	add	x7, x2, #0x5
               	sxth	x7, w7
               	cmp	w6, w7
               	b.ne	<addr>
               	mov	x6, #0x6                // =6
               	ldrsh	x1, [x1, #0xc]
               	add	x2, x2, #0x6
               	sxth	x2, w2
               	cmp	w1, w2
               	b.ne	<addr>
               	mov	x6, #0x7                // =7
               	lsl	x1, x0, #4
               	add	x1, x3, x1
               	ldrsh	x1, [x1, #0xe]
               	mul	x2, x0, x4
               	add	x2, x2, #0x7
               	sxth	x2, w2
               	cmp	w1, w2
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, #-0x1               // =-1
               	strh	w0, [x3]
               	mov	x0, x3
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x5, x6
               	lsl	x0, x0, #3
               	add	x0, x0, #0xa
               	add	x0, x0, x5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x5, x6
               	b	<addr>
               	mov	x5, x8
               	b	<addr>
               	mov	x5, x8
               	b	<addr>
               	mov	x5, x8
               	b	<addr>
               	mov	x5, x8
               	b	<addr>
               	mov	x5, x8
               	b	<addr>
