
alloca_call_args.aarch64:	file format elf64-littleaarch64

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

<sum10>:
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
               	str	x20, [sp, #-0x40]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
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
               	mov	x4, #0x7                // =7
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x2, x1, x0
               	mov	x3, #0x7                // =7
               	strb	w3, [x2]
               	mov	x17, #0x1000            // =4096
               	add	x0, x0, x17
               	mov	x17, #0x100000          // =1048576
               	cmp	x0, x17
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
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	mov	x5, #0x4                // =4
               	mov	x6, #0x5                // =5
               	mov	x7, #0x6                // =6
               	mov	x8, #0x8                // =8
               	mov	x9, #0x9                // =9
               	mov	x10, #0xa               // =10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x11, x0
               	sub	sp, sp, #0x10
               	str	x9, [sp]
               	str	x10, [sp, #0x8]
               	mov	x0, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x5
               	mov	x5, x7
               	mov	x7, x8
               	mov	x16, x6
               	mov	x6, x4
               	mov	x4, x16
               	blr	x11
               	add	sp, sp, #0x10
               	cmp	x20, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	cmp	x0, #0x37
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x2a               // =42
               	sub	sp, x29, #0x30
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
