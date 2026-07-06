
static_local_shadows_extern_fn.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ldrb	w1, [x0]
               	ldrb	w0, [x0, #0x1]
               	add	x0, x1, x0
               	sxtw	x0, w0
               	ret

<driver>:
               	sxtw	x0, w0
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x2
               	b.lt	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	sxtw	x0, w2
               	ret
               	mov	x2, #0xffff             // =65535
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	ldrb	w0, [x0, #0x1]
               	add	x0, x1, x0
               	sxtw	x2, w0
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
