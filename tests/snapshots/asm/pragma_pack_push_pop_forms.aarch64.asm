
pragma_pack_push_pop_forms.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1d               // =29
               	str	x1, [x0, #0x8]
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x38
               	b.hs	<addr>
               	ldr	x1, [x0, #0x8]
               	add	x1, x1, #0x1
               	str	x1, [x0, #0x8]
               	ldr	x1, [x0, #0x8]
               	cmp	x1, #0x38
               	b.lo	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	and	x1, x1, #0x1fffff
               	lsl	x1, x1, #43
               	asr	x1, x1, #43
               	cbnz	w1, <addr>
               	ldrsh	x1, [x0]
               	cbnz	w1, <addr>
               	ldrsw	x1, [x0]
               	cbnz	w1, <addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x38
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	mov	x2, #0x18               // =24
               	bl	<addr>
               	sub	x1, x29, #0x18
               	mov	x0, #0x38               // =56
               	strb	w0, [x1, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x18               // =24
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
