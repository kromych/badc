
memory_ops.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x330              // =816
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x19, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x22, #0xa               // =10
               	mov	x0, x22
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, x22
               	bl	<addr>
               	mov	x20, x0
               	mov	x23, #0x41              // =65
               	mov	x24, #0x9               // =9
               	mov	x0, x21
               	mov	x2, x24
               	mov	x1, x23
               	bl	<addr>
               	mov	x25, #0x0               // =0
               	strb	w25, [x21, #0x9]
               	mov	x0, x20
               	mov	x2, x24
               	mov	x1, x23
               	bl	<addr>
               	strb	w25, [x20, #0x9]
               	mov	x0, x21
               	mov	x2, x22
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x42               // =66
               	strb	w0, [x20, #0x5]
               	mov	x2, #0xa                // =10
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
