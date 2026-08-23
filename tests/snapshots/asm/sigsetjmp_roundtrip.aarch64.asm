
sigsetjmp_roundtrip.aarch64:	file format elf64-littleaarch64

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
               	mov	x20, #0x0               // =0
               	stur	w20, [x29, #-0x10]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	stur	w0, [x29, #-0x10]
               	mov	x1, #0x7                // =7
               	mov	x0, x21
               	bl	<addr>
               	uxtb	w0, w0
               	brk	#0x1
               	cmp	w0, #0x7
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldursw	x0, [x29, #-0x10]
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	b	<addr>
