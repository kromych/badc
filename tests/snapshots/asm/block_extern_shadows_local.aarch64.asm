
block_extern_shadows_local.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x9
               	sxtw	x0, w0
               	ret

<param_probe>:
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	add	x0, x0, #0x0
               	mov	x2, #0x7                // =7
               	str	w2, [x1]
               	add	x0, x0, #0x5
               	sxtw	x0, w0
               	cmp	x0, #0x69
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x9
               	sxtw	x0, w0
               	cmp	x0, #0x40
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x0, #0x50
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
