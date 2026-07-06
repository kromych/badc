
volatile_setjmp_longjmp.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2a0              // =672
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x50]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x8]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	stur	w0, [x29, #-0x8]
               	mov	x1, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	uxtb	w0, w0
               	ldursw	x0, [x29, #-0x8]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
