
far_field_copy_load.aarch64:	file format elf64-littleaarch64

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

<from_big>:
               	ldrb	w1, [x0, #0x1]
               	add	x17, x0, #0x2, lsl #12  // =0x2000
               	ldrb	w0, [x17]
               	add	x0, x0, x1
               	ret

<half_from_big>:
               	ldrb	w1, [x0, #0x3]
               	add	x17, x0, #0x9, lsl #12  // =0x9000
               	add	x17, x17, #0xc40
               	ldrh	w0, [x17]
               	add	x0, x1, x0
               	ret

<word_from_big>:
               	ldrb	w1, [x0, #0x5]
               	add	x17, x0, #0x9, lsl #12  // =0x9000
               	add	x17, x17, #0xc44
               	ldr	w0, [x17]
               	add	x0, x1, x0
               	mov	w0, w0
               	ret

<wide_from_big>:
               	ldrb	w1, [x0, #0x7]
               	add	x17, x0, #0x9, lsl #12  // =0x9000
               	add	x17, x17, #0xc48
               	ldr	x0, [x17]
               	add	x0, x1, x0
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x9                // =9
               	strb	w0, [x20]
               	mov	x0, #0x2                // =2
               	strb	w0, [x20, #0x1]
               	mov	x0, #0x3                // =3
               	strb	w0, [x20, #0x3]
               	mov	x0, #0x5                // =5
               	strb	w0, [x20, #0x5]
               	mov	x0, #0x7                // =7
               	strb	w0, [x20, #0x7]
               	add	x0, x20, #0x2, lsl #12  // =0x2000
               	mov	x1, #0x28               // =40
               	strb	w1, [x0]
               	mov	x17, #0x9c40            // =40000
               	add	x0, x20, x17
               	mov	x1, #0x1234             // =4660
               	strh	w1, [x0]
               	mov	x17, #0x9c44            // =40004
               	add	x0, x20, x17
               	mov	x1, #0x5678             // =22136
               	movk	x1, #0x1234, lsl #16
               	str	w1, [x0]
               	mov	x17, #0x9c48            // =40008
               	add	x0, x20, x17
               	mov	x1, #0x789a             // =30874
               	movk	x1, #0x3456, lsl #16
               	movk	x1, #0x12, lsl #32
               	str	x1, [x0]
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0x1237            // =4663
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0x567d            // =22141
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x20
               	bl	<addr>
               	mov	x17, #0x78a1            // =30881
               	movk	x17, #0x3456, lsl #16
               	movk	x17, #0x12, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x2a               // =42
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
