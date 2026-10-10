
typedef_array_param_decay.aarch64:	file format elf64-littleaarch64

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

<copy>:
               	ldr	x2, [x1]
               	str	x2, [x0]
               	ldr	x2, [x1, #0x8]
               	str	x2, [x0, #0x8]
               	ldr	x2, [x1, #0x10]
               	str	x2, [x0, #0x10]
               	ldr	x2, [x1, #0x18]
               	str	x2, [x0, #0x18]
               	ldr	x2, [x1, #0x20]
               	str	x2, [x0, #0x20]
               	ldr	x2, [x1, #0x28]
               	str	x2, [x0, #0x28]
               	ldr	x2, [x1, #0x30]
               	str	x2, [x0, #0x30]
               	ldr	x2, [x1, #0x38]
               	str	x2, [x0, #0x38]
               	ldr	x2, [x1, #0x40]
               	str	x2, [x0, #0x40]
               	ldr	x2, [x1, #0x48]
               	str	x2, [x0, #0x48]
               	ldr	x2, [x1, #0x50]
               	str	x2, [x0, #0x50]
               	ldr	x2, [x1, #0x58]
               	str	x2, [x0, #0x58]
               	ldr	x2, [x1, #0x60]
               	str	x2, [x0, #0x60]
               	ldr	x2, [x1, #0x68]
               	str	x2, [x0, #0x68]
               	ldr	x2, [x1, #0x70]
               	str	x2, [x0, #0x70]
               	ldr	x1, [x1, #0x78]
               	str	x1, [x0, #0x78]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	sub	x1, x29, #0x100
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x100]
               	mov	x0, #0x2                // =2
               	stur	x0, [x29, #-0xf8]
               	mov	x0, #0x3                // =3
               	stur	x0, [x29, #-0xf0]
               	mov	x0, #0x4                // =4
               	stur	x0, [x29, #-0xe8]
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0xe0]
               	mov	x0, #0x6                // =6
               	stur	x0, [x29, #-0xd8]
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0xd0]
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0xc8]
               	mov	x0, #0x9                // =9
               	stur	x0, [x29, #-0xc0]
               	mov	x0, #0xa                // =10
               	stur	x0, [x29, #-0xb8]
               	mov	x0, #0xb                // =11
               	stur	x0, [x29, #-0xb0]
               	mov	x0, #0xc                // =12
               	stur	x0, [x29, #-0xa8]
               	mov	x0, #0xd                // =13
               	stur	x0, [x29, #-0xa0]
               	mov	x0, #0xe                // =14
               	stur	x0, [x29, #-0x98]
               	mov	x0, #0xf                // =15
               	stur	x0, [x29, #-0x90]
               	mov	x0, #0x10               // =16
               	stur	x0, [x29, #-0x88]
               	sub	x0, x29, #0x80
               	bl	<addr>
               	ldur	x0, [x29, #-0x80]
               	ldur	x1, [x29, #-0x78]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x70]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x68]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x60]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x58]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x50]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x48]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x40]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x38]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x30]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x28]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x20]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x18]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x10]
               	add	x0, x0, x1
               	ldur	x1, [x29, #-0x8]
               	add	x0, x0, x1
               	cmp	x0, #0x88
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x80]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
