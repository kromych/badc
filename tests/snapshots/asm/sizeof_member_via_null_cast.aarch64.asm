
sizeof_member_via_null_cast.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400248 <.text+0x28>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400258 <.text+0x38>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400268 <.text+0x48>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400278 <.text+0x58>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400288 <.text+0x68>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x4
               	cmp	x0, #0x4
               	b.eq	0x4002a0 <.text+0x80>
               	mov	x0, #0x10               // =16
               	ret
               	mov	x15, #0x0               // =0
               	cmp	x15, #0x0
               	b.eq	0x4002b8 <.text+0x98>
               	mov	x15, #0x11              // =17
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	ret
