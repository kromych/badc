
alloca_call_args.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x20
               	ldr	x16, [sp, #0x20]
               	str	x16, [sp]
               	ldr	x16, [sp, #0x28]
               	str	x16, [sp, #0x10]
               	sub	sp, sp, #0x80
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	ldur	x1, [x29, #0x90]
               	add	x0, x0, x1
               	ldur	x1, [x29, #0xa0]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0xa0
               	ret

<main>:
               	str	x20, [sp, #-0xb0]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x2, #0x100000           // =1048576
               	add	x17, x2, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	mov	sp, x1
               	mov	x5, #0x7                // =7
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x1, x0
               	mov	x4, #0x7                // =7
               	strb	w4, [x3]
               	mov	x17, #0x1000            // =4096
               	add	x0, x0, x17
               	cmp	x0, x2
               	b.lt	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	add	x0, x1, x17
               	mov	x2, #0x8                // =8
               	strb	w2, [x0]
               	ldrb	w0, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xf, lsl #16
               	add	x1, x1, x17
               	ldrb	w1, [x1]
               	add	x0, x0, x1
               	sxtw	x20, w0
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x6, #0x6                // =6
               	mov	x7, #0x8                // =8
               	mov	x8, #0x9                // =9
               	mov	x9, #0xa                // =10
               	sub	sp, sp, #0x10
               	str	x8, [sp]
               	str	x9, [sp, #0x8]
               	mov	x16, x6
               	mov	x6, x5
               	mov	x5, x16
               	bl	<addr>
               	add	sp, sp, #0x10
               	cmp	x20, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0xa0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
               	cmp	x0, #0x37
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0xa0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
               	mov	x0, #0x2a               // =42
               	sub	sp, x29, #0xa0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xb0
               	ret
