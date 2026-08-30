
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
               	add	x2, x0, #0x0
               	add	x3, x1, #0x0
               	ldr	x3, [x3]
               	str	x3, [x2]
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
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x130]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x120]
               	add	x29, sp, #0x120
               	sub	x1, x29, #0x100
               	add	x0, x1, #0x0
               	mov	x21, #0x1               // =1
               	str	x21, [x0]
               	mov	x22, #0x2               // =2
               	str	x22, [x1, #0x8]
               	mov	x23, #0x3               // =3
               	str	x23, [x1, #0x10]
               	mov	x0, #0x4                // =4
               	str	x0, [x1, #0x18]
               	mov	x0, #0x5                // =5
               	str	x0, [x1, #0x20]
               	mov	x0, #0x6                // =6
               	str	x0, [x1, #0x28]
               	mov	x0, #0x7                // =7
               	str	x0, [x1, #0x30]
               	mov	x0, #0x8                // =8
               	str	x0, [x1, #0x38]
               	mov	x0, #0x9                // =9
               	str	x0, [x1, #0x40]
               	mov	x0, #0xa                // =10
               	str	x0, [x1, #0x48]
               	mov	x0, #0xb                // =11
               	str	x0, [x1, #0x50]
               	mov	x0, #0xc                // =12
               	str	x0, [x1, #0x58]
               	mov	x0, #0xd                // =13
               	str	x0, [x1, #0x60]
               	mov	x0, #0xe                // =14
               	str	x0, [x1, #0x68]
               	mov	x0, #0xf                // =15
               	str	x0, [x1, #0x70]
               	mov	x0, #0x10               // =16
               	str	x0, [x1, #0x78]
               	sub	x20, x29, #0x80
               	mov	x0, x20
               	bl	<addr>
               	add	x0, x20, #0x0
               	ldr	x0, [x0]
               	add	x0, x0, #0x0
               	ldr	x1, [x20, #0x8]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x10]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x18]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x20]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x28]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x30]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x38]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x40]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x48]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x50]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x58]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x60]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x68]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x70]
               	add	x0, x0, x1
               	ldr	x1, [x20, #0x78]
               	add	x0, x0, x1
               	cmp	x0, #0x88
               	b.eq	<addr>
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x120]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	ldr	x0, [x20]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, x22
               	ldp	x29, x30, [sp, #0x120]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	ldr	x0, [x20, #0x78]
               	cmp	x0, #0x10
               	b.eq	<addr>
               	mov	x0, x23
               	ldp	x29, x30, [sp, #0x120]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x120]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
