
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
               	stp	x20, x21, [sp, #-0x40]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, #0x1               // =1
               	stur	w20, [x29, #-0x10]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	stur	w0, [x29, #-0x10]
               	mov	x0, x21
               	mov	x1, x20
               	bl	<addr>
               	uxtb	w0, w0
               	brk	#0x1
               	ldursw	x0, [x29, #-0x10]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	mov	x20, #0x0               // =0
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	b	<addr>
