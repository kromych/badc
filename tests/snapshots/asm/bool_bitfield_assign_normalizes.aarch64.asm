
bool_bitfield_assign_normalizes.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	ldrb	w1, [x0, #0xc]
               	and	x2, x1, #0x1
               	cmp	w2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	ubfx	x1, x1, #1, #1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	ldr	w0, [x0, #0xc]
               	ubfx	x1, x0, #2, #3
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	sbfx	x0, x0, #5, #4
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x10]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrb	w1, [x0, #0x1]
               	cbnz	w1, <addr>
               	ldrb	w0, [x0, #0x2]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x14]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x30]
               	cbz	w0, <addr>
               	mov	x0, #0x1a               // =26
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x31]
               	cbz	w0, <addr>
               	mov	x0, #0x1b               // =27
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w1, [x0]
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	ret
               	ldrb	w1, [x0, #0x1]
               	cbz	w1, <addr>
               	mov	x0, #0x1d               // =29
               	ret
               	ldrb	w0, [x0, #0x2]
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	ret
               	adrp	x0, <page>
               	ldrb	w0, [x0, #0x18]
               	and	x1, x0, #0x1
               	cmp	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ret
               	ubfx	x0, x0, #1, #1
               	cbz	w0, <addr>
               	mov	x0, #0x20               // =32
               	ret
               	mov	x0, #0x0                // =0
               	ret
