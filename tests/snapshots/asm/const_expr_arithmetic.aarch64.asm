
const_expr_arithmetic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x0               // =0
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x1               // =1
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x6                // =6
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x2               // =2
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x3               // =3
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x20, #0x4               // =4
               	mov	x1, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x6                // =6
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x5               // =5
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x6               // =6
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x6                // =6
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, #0x7               // =7
               	b	<addr>
