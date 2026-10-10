
netinet_addr_class_macros.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x30
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x20
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldurb	w0, [x29, #-0x30]
               	eor	x0, x0, #0xff
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x20]
               	eor	x0, x0, #0xff
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x20]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x1c]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x18]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x14]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x13]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x12]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x11]
               	eor	x0, x0, #0x1
               	cbz	w0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	w0, [x29, #-0x30]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x2c]
               	cbnz	w0, <addr>
               	ldur	w0, [x29, #-0x28]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x24]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x23]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x22]
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x21]
               	eor	x0, x0, #0x1
               	cbnz	w0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w0, [x29, #-0x30]
               	eor	x0, x0, #0xff
               	cbnz	w0, <addr>
               	ldurb	w0, [x29, #-0x2f]
               	and	x0, x0, #0xf
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
