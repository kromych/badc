
volatile_setjmp_longjmp.aarch64:	file format elf64-littleaarch64

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

<main>:
               	str	x20, [sp, #-0x40]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x10]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	stur	w0, [x29, #-0x10]
               	mov	x1, #0x1                // =1
               	mov	x0, x20
               	bl	<addr>
               	uxtb	w0, w0
               	brk	#0x1
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x40
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
