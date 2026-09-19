
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
               	mov	x1, x0
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x20
               	and	x2, x0, #0xf
               	cbz	w2, <addr>
               	add	x0, x1, #0x1
               	sxtw	x0, w0
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
               	mrs	x3, TPIDR_EL0
               	add	x3, x3, #0x0, lsl #12   // =0x0
               	add	x3, x3, #0x30
               	mov	x4, #0x2                // =2
               	strb	w4, [x3]
               	ldr	x4, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x0, x4, x0
               	cmp	x0, #0x7
               	b.eq	<addr>
               	add	x0, x1, #0x2
               	sxtw	x0, w0
               	ret
               	ldrb	w0, [x2]
               	ldrb	w2, [x3]
               	add	x0, x0, x2
               	cmp	w0, #0x3
               	b.eq	<addr>
               	add	x0, x1, #0x3
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x0                // =0
               	ret

<thread_main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0xa                // =10
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<second_thread_result>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
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
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
