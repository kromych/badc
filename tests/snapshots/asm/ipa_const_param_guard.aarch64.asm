
ipa_const_param_guard.aarch64:	file format elf64-littleaarch64

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

<patch_map>:
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	add	x2, x2, #0x0
               	ldr	x3, [x0, #0x8]
               	lsl	x3, x3, #1
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x10]
               	mov	x17, #0x3               // =3
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x18]
               	lsl	x3, x3, #2
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x20]
               	mov	x17, #0x5               // =5
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x28]
               	mov	x17, #0x6               // =6
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x30]
               	mov	x17, #0x7               // =7
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x38]
               	lsl	x3, x3, #3
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x40]
               	mov	x17, #0x9               // =9
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x48]
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x50]
               	mov	x17, #0xb               // =11
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x58]
               	mov	x17, #0xc               // =12
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x60]
               	mov	x17, #0xd               // =13
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x68]
               	mov	x17, #0xe               // =14
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x70]
               	mov	x17, #0xf               // =15
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x78]
               	lsl	x3, x3, #4
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x80]
               	mov	x17, #0x11              // =17
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x88]
               	mov	x17, #0x12              // =18
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x90]
               	mov	x17, #0x13              // =19
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x98]
               	mov	x17, #0x14              // =20
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0xa0]
               	mov	x17, #0x15              // =21
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0xa8]
               	mov	x17, #0x16              // =22
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0xb0]
               	mov	x17, #0x17              // =23
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0xb8]
               	mov	x17, #0x18              // =24
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0xc0]
               	mov	x17, #0x19              // =25
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0xc8]
               	mov	x17, #0x1a              // =26
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0xd0]
               	mov	x17, #0x1b              // =27
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0xd8]
               	mov	x17, #0x1c              // =28
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0xe0]
               	mov	x17, #0x1d              // =29
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0xe8]
               	mov	x17, #0x1e              // =30
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0xf0]
               	mov	x17, #0x1f              // =31
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0xf8]
               	lsl	x3, x3, #5
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x100]
               	mov	x17, #0x21              // =33
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x108]
               	mov	x17, #0x22              // =34
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x110]
               	mov	x17, #0x23              // =35
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x118]
               	mov	x17, #0x24              // =36
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x120]
               	mov	x17, #0x25              // =37
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x128]
               	mov	x17, #0x26              // =38
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x130]
               	mov	x17, #0x27              // =39
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x138]
               	mov	x17, #0x28              // =40
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x140]
               	mov	x17, #0x29              // =41
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x148]
               	mov	x17, #0x2a              // =42
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x150]
               	mov	x17, #0x2b              // =43
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x158]
               	mov	x17, #0x2c              // =44
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x160]
               	mov	x17, #0x2d              // =45
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x168]
               	mov	x17, #0x2e              // =46
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x170]
               	mov	x17, #0x2f              // =47
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x178]
               	mov	x17, #0x30              // =48
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x180]
               	mov	x17, #0x31              // =49
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x188]
               	mov	x17, #0x32              // =50
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x190]
               	mov	x17, #0x33              // =51
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x198]
               	mov	x17, #0x34              // =52
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x1a0]
               	mov	x17, #0x35              // =53
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x1a8]
               	mov	x17, #0x36              // =54
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x1b0]
               	mov	x17, #0x37              // =55
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x1b8]
               	mov	x17, #0x38              // =56
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x1c0]
               	mov	x17, #0x39              // =57
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x1c8]
               	mov	x17, #0x3a              // =58
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x1d0]
               	mov	x17, #0x3b              // =59
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x1d8]
               	mov	x17, #0x3c              // =60
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x1e0]
               	mov	x17, #0x3d              // =61
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x1e8]
               	mov	x17, #0x3e              // =62
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x1f0]
               	mov	x17, #0x3f              // =63
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x1f8]
               	lsl	x3, x3, #6
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x200]
               	mov	x17, #0x41              // =65
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x208]
               	mov	x17, #0x42              // =66
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x210]
               	mov	x17, #0x43              // =67
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x218]
               	mov	x17, #0x44              // =68
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x220]
               	mov	x17, #0x45              // =69
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x228]
               	mov	x17, #0x46              // =70
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x230]
               	mov	x17, #0x47              // =71
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x238]
               	mov	x17, #0x48              // =72
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x240]
               	mov	x17, #0x49              // =73
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x248]
               	mov	x17, #0x4a              // =74
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x250]
               	mov	x17, #0x4b              // =75
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x258]
               	mov	x17, #0x4c              // =76
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x260]
               	mov	x17, #0x4d              // =77
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x268]
               	mov	x17, #0x4e              // =78
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x270]
               	mov	x17, #0x4f              // =79
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x278]
               	mov	x17, #0x50              // =80
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x280]
               	mov	x17, #0x51              // =81
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x288]
               	mov	x17, #0x52              // =82
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x290]
               	mov	x17, #0x53              // =83
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x298]
               	mov	x17, #0x54              // =84
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x2a0]
               	mov	x17, #0x55              // =85
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x2a8]
               	mov	x17, #0x56              // =86
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x2b0]
               	mov	x17, #0x57              // =87
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x2b8]
               	mov	x17, #0x58              // =88
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x2c0]
               	mov	x17, #0x59              // =89
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x2c8]
               	mov	x17, #0x5a              // =90
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x2d0]
               	mov	x17, #0x5b              // =91
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x2d8]
               	mov	x17, #0x5c              // =92
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x2e0]
               	mov	x17, #0x5d              // =93
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x2e8]
               	mov	x17, #0x5e              // =94
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x2f0]
               	mov	x17, #0x5f              // =95
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x2f8]
               	mov	x17, #0x60              // =96
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x300]
               	mov	x17, #0x61              // =97
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x308]
               	mov	x17, #0x62              // =98
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x310]
               	mov	x17, #0x63              // =99
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x318]
               	mov	x17, #0x64              // =100
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x320]
               	mov	x17, #0x65              // =101
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x328]
               	mov	x17, #0x66              // =102
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x330]
               	mov	x17, #0x67              // =103
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x338]
               	mov	x17, #0x68              // =104
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x340]
               	mov	x17, #0x69              // =105
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x348]
               	mov	x17, #0x6a              // =106
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x350]
               	mov	x17, #0x6b              // =107
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x358]
               	mov	x17, #0x6c              // =108
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x360]
               	mov	x17, #0x6d              // =109
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x368]
               	mov	x17, #0x6e              // =110
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x370]
               	mov	x17, #0x6f              // =111
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x378]
               	mov	x17, #0x70              // =112
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x380]
               	mov	x17, #0x71              // =113
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x388]
               	mov	x17, #0x72              // =114
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x390]
               	mov	x17, #0x73              // =115
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x398]
               	mov	x17, #0x74              // =116
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x3a0]
               	mov	x17, #0x75              // =117
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x3a8]
               	mov	x17, #0x76              // =118
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x3b0]
               	mov	x17, #0x77              // =119
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x3b8]
               	mov	x17, #0x78              // =120
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x3c0]
               	mov	x17, #0x79              // =121
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x3c8]
               	mov	x17, #0x7a              // =122
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x3d0]
               	mov	x17, #0x7b              // =123
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x3d8]
               	mov	x17, #0x7c              // =124
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x3e0]
               	mov	x17, #0x7d              // =125
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x3e8]
               	mov	x17, #0x7e              // =126
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x3f0]
               	mov	x17, #0x7f              // =127
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x3f8]
               	lsl	x3, x3, #7
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x400]
               	mov	x17, #0x81              // =129
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x408]
               	mov	x17, #0x82              // =130
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x410]
               	mov	x17, #0x83              // =131
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x418]
               	mov	x17, #0x84              // =132
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x420]
               	mov	x17, #0x85              // =133
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x428]
               	mov	x17, #0x86              // =134
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x430]
               	mov	x17, #0x87              // =135
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x438]
               	mov	x17, #0x88              // =136
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x440]
               	mov	x17, #0x89              // =137
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x448]
               	mov	x17, #0x8a              // =138
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x450]
               	mov	x17, #0x8b              // =139
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x458]
               	mov	x17, #0x8c              // =140
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x460]
               	mov	x17, #0x8d              // =141
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x468]
               	mov	x17, #0x8e              // =142
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x470]
               	mov	x17, #0x8f              // =143
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x478]
               	mov	x17, #0x90              // =144
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x480]
               	mov	x17, #0x91              // =145
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x488]
               	mov	x17, #0x92              // =146
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x490]
               	mov	x17, #0x93              // =147
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x498]
               	mov	x17, #0x94              // =148
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x4a0]
               	mov	x17, #0x95              // =149
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x4a8]
               	mov	x17, #0x96              // =150
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x4b0]
               	mov	x17, #0x97              // =151
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x4b8]
               	mov	x17, #0x98              // =152
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x4c0]
               	mov	x17, #0x99              // =153
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x4c8]
               	mov	x17, #0x9a              // =154
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x4d0]
               	mov	x17, #0x9b              // =155
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x4d8]
               	mov	x17, #0x9c              // =156
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x4e0]
               	mov	x17, #0x9d              // =157
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x4e8]
               	mov	x17, #0x9e              // =158
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x4f0]
               	mov	x17, #0x9f              // =159
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x4f8]
               	mov	x17, #0xa0              // =160
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x500]
               	mov	x17, #0xa1              // =161
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x508]
               	mov	x17, #0xa2              // =162
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x510]
               	mov	x17, #0xa3              // =163
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x518]
               	mov	x17, #0xa4              // =164
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x520]
               	mov	x17, #0xa5              // =165
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x528]
               	mov	x17, #0xa6              // =166
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x530]
               	mov	x17, #0xa7              // =167
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x538]
               	mov	x17, #0xa8              // =168
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x540]
               	mov	x17, #0xa9              // =169
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x548]
               	mov	x17, #0xaa              // =170
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x550]
               	mov	x17, #0xab              // =171
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x558]
               	mov	x17, #0xac              // =172
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x560]
               	mov	x17, #0xad              // =173
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x568]
               	mov	x17, #0xae              // =174
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x570]
               	mov	x17, #0xaf              // =175
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x578]
               	mov	x17, #0xb0              // =176
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x580]
               	mov	x17, #0xb1              // =177
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x588]
               	mov	x17, #0xb2              // =178
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x3, [x0, #0x590]
               	mov	x17, #0xb3              // =179
               	mul	x3, x3, x17
               	add	x2, x2, x3
               	ldr	x0, [x0, #0x598]
               	mov	x17, #0xb4              // =180
               	mul	x0, x0, x17
               	add	x0, x2, x0
               	add	x0, x0, x1
               	add	x0, x0, #0x3
               	ret

<map_a>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<map_b>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x1, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x1
               	b	<addr>
               	sxtw	x2, w0
               	str	x2, [x3, x2, lsl #3]
               	add	x0, x2, #0x1
               	cmp	w0, #0xb4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	b	<addr>
               	sxtw	x2, w0
               	ldr	x4, [x3, x2, lsl #3]
               	add	x5, x2, #0x1
               	madd	x1, x4, x5, x1
               	add	x0, x2, #0x1
               	cmp	w0, #0xb4
               	b.lt	<addr>
               	add	x20, x1, #0xa
               	mov	x0, #0x7                // =7
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x7                // =7
               	mov	x1, #0x3                // =3
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x4                // =4
               	mov	x0, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
