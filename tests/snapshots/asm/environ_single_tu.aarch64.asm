
environ_single_tu.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x370              // =880
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x2, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	b	<addr>
               	sxtw	x0, w2
               	add	x2, x0, #0x1
               	add	x1, x1, #0x8
               	ldr	x0, [x1]
               	cbnz	x0, <addr>
               	sxtw	x0, w2
               	cmp	x0, #0x0
               	b.le	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
