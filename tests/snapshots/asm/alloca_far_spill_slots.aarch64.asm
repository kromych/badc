
alloca_far_spill_slots.aarch64:	file format elf64-littleaarch64

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

<touch>:
               	mov	x2, #0x1                // =1
               	strb	w2, [x0]
               	mov	x0, #0x2                // =2
               	strb	w0, [x1]
               	ret

<f>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0xb0
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	str	x19, [sp, #0x50]
               	mov	x19, sp
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x20, sp
               	sub	x20, x20, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x20
               	mov	x17, #0x3               // =3
               	mul	x21, x0, x17
               	mov	x17, #0x5               // =5
               	mul	x22, x0, x17
               	mov	x17, #0x7               // =7
               	mul	x23, x0, x17
               	mov	x17, #0xb               // =11
               	mul	x24, x0, x17
               	mov	x17, #0xd               // =13
               	mul	x25, x0, x17
               	mov	x17, #0x11              // =17
               	mul	x26, x0, x17
               	mov	x17, #0x13              // =19
               	mul	x27, x0, x17
               	mov	x17, #0x17              // =23
               	mul	x28, x0, x17
               	mov	x17, #0x1d              // =29
               	mul	x16, x0, x17
               	str	x16, [x19, #0x98]
               	mov	x17, #0x1f              // =31
               	mul	x16, x0, x17
               	str	x16, [x19, #0x90]
               	mov	x17, #0x25              // =37
               	mul	x16, x0, x17
               	str	x16, [x19, #0x88]
               	mov	x17, #0x29              // =41
               	mul	x16, x0, x17
               	str	x16, [x19, #0x80]
               	mov	x17, #0x2b              // =43
               	mul	x16, x0, x17
               	str	x16, [x19, #0x78]
               	mov	x17, #0x2f              // =47
               	mul	x16, x0, x17
               	str	x16, [x19, #0x70]
               	mov	x17, #0x35              // =53
               	mul	x16, x0, x17
               	str	x16, [x19, #0x68]
               	add	x0, x19, #0xa8
               	mov	x1, x20
               	bl	<addr>
               	add	x0, x21, x22
               	add	x0, x0, x23
               	add	x0, x0, x24
               	add	x0, x0, x25
               	add	x0, x0, x26
               	add	x0, x0, x27
               	add	x0, x0, x28
               	ldr	x17, [x19, #0x98]
               	add	x0, x0, x17
               	ldr	x17, [x19, #0x90]
               	add	x0, x0, x17
               	ldr	x17, [x19, #0x88]
               	add	x0, x0, x17
               	ldr	x17, [x19, #0x80]
               	add	x0, x0, x17
               	ldr	x17, [x19, #0x78]
               	add	x0, x0, x17
               	ldr	x17, [x19, #0x70]
               	add	x0, x0, x17
               	ldr	x17, [x19, #0x68]
               	add	x16, x0, x17
               	str	x16, [x19, #0x60]
               	add	x0, x19, #0xa8
               	mov	x1, x20
               	bl	<addr>
               	mul	x0, x23, x24
               	madd	x0, x21, x22, x0
               	madd	x0, x25, x26, x0
               	madd	x0, x27, x28, x0
               	ldr	x16, [x19, #0x98]
               	ldr	x17, [x19, #0x90]
               	madd	x0, x16, x17, x0
               	ldr	x16, [x19, #0x88]
               	ldr	x17, [x19, #0x80]
               	madd	x0, x16, x17, x0
               	ldr	x16, [x19, #0x78]
               	ldr	x17, [x19, #0x70]
               	madd	x0, x16, x17, x0
               	ldr	x17, [x19, #0x68]
               	add	x0, x0, x17
               	ldr	x16, [x19, #0x60]
               	add	x0, x16, x0
               	ldrb	w1, [x19, #0xa8]
               	add	x0, x0, x1
               	ldrb	w1, [x20]
               	add	x0, x0, x1
               	ldr	x28, [x19, #0x40]
               	ldp	x26, x27, [x19, #0x30]
               	ldp	x24, x25, [x19, #0x20]
               	ldp	x22, x23, [x19, #0x10]
               	ldp	x20, x21, [x19]
               	ldr	x19, [x19, #0x50]
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret

<expect>:
               	mov	x17, #0x3               // =3
               	mul	x1, x0, x17
               	mov	x17, #0x5               // =5
               	mul	x2, x0, x17
               	add	x4, x1, x2
               	mov	x17, #0x7               // =7
               	mul	x3, x0, x17
               	add	x5, x4, x3
               	mov	x17, #0xb               // =11
               	mul	x4, x0, x17
               	add	x6, x5, x4
               	mov	x17, #0xd               // =13
               	mul	x5, x0, x17
               	add	x7, x6, x5
               	mov	x17, #0x11              // =17
               	mul	x6, x0, x17
               	add	x8, x7, x6
               	mov	x17, #0x13              // =19
               	mul	x7, x0, x17
               	add	x9, x8, x7
               	mov	x17, #0x17              // =23
               	mul	x8, x0, x17
               	add	x10, x9, x8
               	mov	x17, #0x1d              // =29
               	mul	x9, x0, x17
               	add	x11, x10, x9
               	mov	x17, #0x1f              // =31
               	mul	x10, x0, x17
               	add	x12, x11, x10
               	mov	x17, #0x25              // =37
               	mul	x11, x0, x17
               	add	x13, x12, x11
               	mov	x17, #0x29              // =41
               	mul	x12, x0, x17
               	add	x14, x13, x12
               	mov	x17, #0x2b              // =43
               	mul	x13, x0, x17
               	add	x15, x14, x13
               	mov	x17, #0x2f              // =47
               	mul	x14, x0, x17
               	add	x15, x15, x14
               	mov	x17, #0x35              // =53
               	mul	x0, x0, x17
               	add	x15, x15, x0
               	madd	x1, x1, x2, x15
               	madd	x1, x3, x4, x1
               	madd	x1, x5, x6, x1
               	madd	x1, x7, x8, x1
               	madd	x1, x9, x10, x1
               	madd	x1, x11, x12, x1
               	madd	x1, x13, x14, x1
               	add	x0, x1, x0
               	add	x0, x0, #0x3
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
