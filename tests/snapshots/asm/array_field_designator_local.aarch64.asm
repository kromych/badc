
array_field_designator_local.aarch64:	file format elf64-littleaarch64

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
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	and	x1, x1, #0xff
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldr	w1, [x0, #0x8]
               	and	x1, x1, #0xff
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldr	w1, [x0, #0x10]
               	and	x1, x1, #0xff
               	cbnz	x1, <addr>
               	ldr	w1, [x0, #0x18]
               	and	x1, x1, #0xff
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	w1, [x0]
               	asr	x1, x1, #8
               	and	x1, x1, #0xff
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x4]
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x7
               	b.ne	<addr>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	and	x1, x1, #0xff
               	cmp	w1, #0x9
               	b.ne	<addr>
               	ldr	w1, [x0, #0x18]
               	and	x1, x1, #0xff
               	cmp	w1, #0x9
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x14]
               	cmp	w1, #0x5
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0xc]
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
