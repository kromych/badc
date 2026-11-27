
int128_bitfield.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	and	x2, x0, #0xfffffffff
               	mov	x17, #0x1234            // =4660
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	cbz	x0, <addr>
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x0, [x1]
               	ldr	x2, [x1, #0x8]
               	and	x2, x2, #0xfffffffff
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	cbz	x0, <addr>
               	ret
               	ldr	x0, [x1, #0x8]
               	lsr	x0, x0, #36
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	cbz	x0, <addr>
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldur	w1, [x0, #0x1]
               	ldrb	w0, [x0, #0x5]
               	orr	x0, x1, x0, lsl #32
               	sbfx	x0, x0, #0, #40
               	asr	x1, x0, #63
               	cmn	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x79               // =121
               	cbz	x0, <addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	cmn	w1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7a               // =122
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0xe                // =14
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x800000000       // =34359738368
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
