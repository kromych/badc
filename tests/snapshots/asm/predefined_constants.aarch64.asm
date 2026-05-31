
predefined_constants.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400248 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400258 <.text+0x28>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400268 <.text+0x38>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400278 <.text+0x48>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400288 <.text+0x58>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400298 <.text+0x68>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4002a8 <.text+0x78>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4002b8 <.text+0x88>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4002c8 <.text+0x98>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4002d8 <.text+0xa8>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4002e8 <.text+0xb8>
               	mov	x0, #0xa                // =10
               	ret
               	mov	x15, #0x0               // =0
               	cmp	x15, #0x0
               	b.eq	0x4002fc <.text+0xcc>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40030c <.text+0xdc>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40031c <.text+0xec>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
