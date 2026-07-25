
long_long_distinct.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	sub	x0, x29, #0x30
               	mov	x1, #0xa                // =10
               	str	x1, [x0]
               	sub	x0, x29, #0x30
               	mov	x1, #0x14               // =20
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x30
               	mov	x1, #0x1e               // =30
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x30
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x14
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x64               // =100
               	str	x1, [x0]
               	sub	x0, x29, #0x18
               	mov	x1, #0xc8               // =200
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	mov	x1, #0x12c              // =300
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0xc8
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
