
long_long_distinct.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	sub	x0, x29, #0x40
               	mov	x1, #0xa                // =10
               	str	x1, [x0]
               	sub	x0, x29, #0x40
               	mov	x1, #0x14               // =20
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x40
               	mov	x1, #0x1e               // =30
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x40
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x14
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	sub	x0, x29, #0x60
               	mov	x1, #0x64               // =100
               	str	x1, [x0]
               	sub	x0, x29, #0x60
               	mov	x1, #0xc8               // =200
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x60
               	mov	x1, #0x12c              // =300
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x60
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0xc8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp], #0x90
               	ret
