
libc_struct_arg_by_value.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	str	x19, [sp]
               	sub	x0, x29, #0x8
               	mov	x1, #0x7f               // =127
               	movk	x1, #0x100, lsl #16
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0xf0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0xa8c0             // =43200
               	movk	x1, #0x101, lsl #16
               	str	w1, [x0]
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	bl	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0xfa
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
