
thread_local_image_alignment.aarch64:	file format elf64-littleaarch64

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

<check>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x1, x0
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x20
               	mov	x17, #0xf               // =15
               	and	x2, x0, x17
               	cmp	w2, #0x0
               	cset	x2, ne
               	sxtw	x2, w2
               	cbz	x2, <addr>
               	add	x0, x1, #0x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x2, #0x3                // =3
               	str	x2, [x0]
               	mov	x2, #0x4                // =4
               	str	x2, [x0, #0x8]
               	mrs	x2, TPIDR_EL0
               	add	x2, x2, #0x0, lsl #12   // =0x0
               	add	x2, x2, #0x10
               	mov	x3, #0x1                // =1
               	strb	w3, [x2]
               	mrs	x2, TPIDR_EL0
               	add	x2, x2, #0x0, lsl #12   // =0x0
               	add	x2, x2, #0x30
               	mov	x3, #0x2                // =2
               	strb	w3, [x2]
               	ldr	x2, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x2, x0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	add	x0, x1, #0x2
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	ldrb	w0, [x0]
               	mrs	x2, TPIDR_EL0
               	add	x2, x2, #0x0, lsl #12   // =0x0
               	add	x2, x2, #0x30
               	ldrb	w2, [x2]
               	add	x0, x0, x2
               	cmp	w0, #0x3
               	b.eq	<addr>
               	add	x0, x1, #0x3
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret

<thread_main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x20, #0x0               // =0
               	mov	x1, #0x2                // =2
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x22, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x21, x0
               	sub	x0, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x9, x22
               	mov	x1, x20
               	mov	x3, x20
               	blr	x9
               	ldur	x0, [x29, #-0x10]
               	sub	x1, x29, #0x8
               	mov	x9, x21
               	blr	x9
               	ldur	x0, [x29, #-0x8]
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
