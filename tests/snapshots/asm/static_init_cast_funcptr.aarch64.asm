
static_init_cast_funcptr.aarch64:	file format elf64-littleaarch64

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

<real_double>:
               	lsl	x0, x0, #1
               	sxtw	x0, w0
               	ret

<real_negate>:
               	neg	x0, x0
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	mov	x0, #0x15               // =21
               	blr	x1
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x20]
               	mov	x0, #0x7                // =7
               	blr	x1
               	mov	x17, #-0x7              // =-7
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	blr	x1
               	cmp	w0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	blr	x1
               	mov	x17, #-0x11             // =-17
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrb	w1, [x1]
               	mov	x17, #0x64              // =100
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0, #0x18]
               	ldrb	w0, [x0]
               	mov	x17, #0x6e              // =110
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret

<__c5_sys_atoi>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
