
mmap_anonymous.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x4000            // =16384
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3                // =3
               	mov	x3, #0x22               // =34
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x1, x20
               	mov	x5, x0
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	add	x1, x0, #0x0
               	mov	x2, #0x1                // =1
               	strb	w2, [x1]
               	mov	x17, #0x1000            // =4096
               	add	x1, x0, x17
               	mov	x2, #0x2                // =2
               	strb	w2, [x1]
               	mov	x17, #0x2000            // =8192
               	add	x1, x0, x17
               	mov	x2, #0x3                // =3
               	strb	w2, [x1]
               	mov	x17, #0x3000            // =12288
               	add	x1, x0, x17
               	mov	x2, #0x4                // =4
               	strb	w2, [x1]
               	mov	x2, #0x0                // =0
               	b	<addr>
               	add	x1, x0, x2
               	ldrb	w1, [x1]
               	lsr	x3, x2, #12
               	add	x3, x3, #0x1
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	cmp	x1, x3
               	b.ne	<addr>
               	mov	x17, #0x1000            // =4096
               	add	x2, x2, x17
               	cmp	x2, x20
               	b.lo	<addr>
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	b	<addr>
