
dlopen_atoi.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x440              // =1088
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x0                // =0
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sxtw	x21, w0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, x21
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
