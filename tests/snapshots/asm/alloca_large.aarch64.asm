
alloca_large.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x0, #0x100000           // =1048576
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x1
               	mov	x0, #0x1                // =1
               	strb	w0, [x1]
               	mov	x17, #0xfffff           // =1048575
               	add	x0, x1, x17
               	mov	x2, #0x2                // =2
               	strb	w2, [x0]
               	mov	x0, #0x1000             // =4096
               	mov	x2, #0xfffff            // =1048575
               	cmp	w0, w2
               	b.ge	<addr>
               	mov	x3, #0x3                // =3
               	strb	w3, [x1, x0]
               	add	x0, x0, #0x1, lsl #12   // =0x1000
               	cmp	w0, w2
               	b.lt	<addr>
               	ldrb	w0, [x1]
               	mov	x17, #0xfffff           // =1048575
               	add	x1, x1, x17
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	cmp	w0, #0x3
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	sub	sp, x29, #0x10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
