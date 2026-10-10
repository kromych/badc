
alloca_far_local_base_register.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	mov	x19, sp
               	mov	x0, #0x1                // =1
               	strb	w0, [x19, #0x30]
               	str	xzr, [x19, #0x10]
               	str	x0, [x19, #0x18]
               	mov	x0, #0x2                // =2
               	str	x0, [x19, #0x20]
               	mov	x0, #0x40               // =64
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x0, sp
               	sub	x0, x0, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x0
               	mov	x1, #0x3                // =3
               	strb	w1, [x0]
               	ldr	x1, [x19, #0x10]
               	ldr	x2, [x19, #0x18]
               	ldr	x3, [x19, #0x20]
               	add	x2, x2, x3
               	lsl	x2, x2, #1
               	add	x1, x1, x2
               	str	x1, [x19, #0x10]
               	ldr	x1, [x19, #0x18]
               	ldr	x2, [x19, #0x10]
               	add	x1, x1, x2
               	str	x1, [x19, #0x18]
               	ldr	x1, [x19, #0x20]
               	ldr	x2, [x19, #0x18]
               	add	x1, x1, x2
               	str	x1, [x19, #0x20]
               	ldrb	w1, [x19, #0x30]
               	eor	x1, x1, #0x1
               	cbz	w1, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [x19]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w0, [x0]
               	eor	x0, x0, #0x3
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [x19]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x19, #0x10]
               	ldr	x1, [x19, #0x18]
               	add	x0, x0, x1
               	ldr	x1, [x19, #0x20]
               	add	x0, x0, x1
               	sub	x0, x0, #0x16
               	ldr	x19, [x19]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
