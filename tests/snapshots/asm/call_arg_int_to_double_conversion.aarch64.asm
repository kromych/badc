
call_arg_int_to_double_conversion.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x300              // =768
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x20
               	fmov	d1, x1
               	bl	<addr>
               	fmov	d17, x20
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x0
               	fmov	d1, x0
               	bl	<addr>
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	mov	x0, #0x4020000000000000 // =4620693217682128896
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x0
               	fmov	d1, x1
               	bl	<addr>
               	mov	x0, #0x4030000000000000 // =4625196817309499392
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	scvtf	d0, x0
               	fmov	d1, d0
               	fmov	d0, x1
               	bl	<addr>
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	scvtf	d0, x0
               	fmov	d1, d0
               	fmov	d0, x1
               	bl	<addr>
               	mov	x0, #0x4020000000000000 // =4620693217682128896
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x0
               	fmov	d1, x0
               	bl	<addr>
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
