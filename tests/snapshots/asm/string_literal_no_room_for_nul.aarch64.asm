
string_literal_no_room_for_nul.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	ldrb	w15, [x15]
               	mov	x17, #0x65              // =101
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xd0
               	add	x15, x15, #0xf
               	ldrb	w15, [x15]
               	mov	x17, #0x6b              // =107
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xf0
               	ldrb	w15, [x15]
               	mov	x17, #0x68              // =104
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xf0
               	add	x15, x15, #0x4
               	ldrb	w15, [x15]
               	mov	x17, #0x6f              // =111
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xf0
               	add	x15, x15, #0x5
               	ldrb	w15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0xf0
               	add	x15, x15, #0x13
               	ldrb	w15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x114
               	ldrb	w15, [x15]
               	mov	x17, #0x77              // =119
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x114
               	add	x15, x15, #0x4
               	ldrb	w15, [x15]
               	mov	x17, #0x64              // =100
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x15, <page>
               	add	x15, x15, #0x114
               	add	x15, x15, #0x5
               	ldrb	w15, [x15]
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
