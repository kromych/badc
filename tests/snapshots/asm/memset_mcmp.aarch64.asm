
memset_mcmp.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xe0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x22, #0x41              // =65
               	mov	x20, #0x4               // =4
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x22
               	bl	<addr>
               	add	x0, x21, #0x4
               	mov	x20, #0x0               // =0
               	strb	w20, [x0]
               	ldrb	w22, [x21]
               	mov	x17, #0x41              // =65
               	eor	x22, x22, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x22, x22, x17
               	cmp	x22, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2a               // =42
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
