
mmap_anonymous.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
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
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	cmp	x2, x20
               	b.hs	<addr>
               	b	<addr>
               	mov	x17, #0x1000            // =4096
               	add	x2, x2, x17
               	b	<addr>
               	add	x1, x0, x2
               	lsr	x3, x2, #12
               	add	x3, x3, #0x1
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	strb	w3, [x1]
               	b	<addr>
               	mov	x2, #0x0                // =0
               	cmp	x2, x20
               	b.hs	<addr>
               	b	<addr>
               	mov	x17, #0x1000            // =4096
               	add	x2, x2, x17
               	b	<addr>
               	add	x1, x0, x2
               	ldrb	w1, [x1]
               	lsr	x3, x2, #12
               	add	x3, x3, #0x1
               	mov	x17, #0xff              // =255
               	and	x3, x3, x17
               	cmp	x1, x3
               	b.eq	<addr>
               	b	<addr>
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
