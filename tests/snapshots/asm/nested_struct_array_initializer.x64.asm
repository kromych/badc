
nested_struct_array_initializer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfe92(%rip), %r11      # 0x4100d0
               	movslq	(%r11), %r9
               	cmpq	$0x64, %r9
               	je	0x400254 <.text+0x34>
               	movl	$0xb, %eax
               	retq
               	leaq	0xfe75(%rip), %r9       # 0x4100d0
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x1, %rax
               	je	0x40027c <.text+0x5c>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfe4d(%rip), %rax      # 0x4100d0
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x2, %r9
               	je	0x4002a0 <.text+0x80>
               	movl	$0xd, %eax
               	retq
               	leaq	0xfe29(%rip), %r9       # 0x4100d0
               	addq	$0xc, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x3, %rax
               	je	0x4002c8 <.text+0xa8>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfe01(%rip), %rax      # 0x4100d0
               	addq	$0x10, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x4, %r9
               	je	0x4002ec <.text+0xcc>
               	movl	$0xf, %eax
               	retq
               	leaq	0xfddd(%rip), %r9       # 0x4100d0
               	addq	$0x14, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x5, %rax
               	je	0x400314 <.text+0xf4>
               	movl	$0x10, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfdb5(%rip), %rax      # 0x4100d0
               	addq	$0x18, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x6, %r9
               	je	0x400338 <.text+0x118>
               	movl	$0x11, %eax
               	retq
               	leaq	0xfd91(%rip), %r9       # 0x4100d0
               	addq	$0x1c, %r9
               	movslq	(%r9), %rax
               	cmpq	$0xc8, %rax
               	je	0x400360 <.text+0x140>
               	movl	$0x12, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfd89(%rip), %rax      # 0x4100f0
               	movslq	(%rax), %r9
               	cmpq	$0xa, %r9
               	je	0x40037d <.text+0x15d>
               	movl	$0x15, %eax
               	retq
               	leaq	0xfd6c(%rip), %r9       # 0x4100f0
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x14, %rax
               	je	0x4003a5 <.text+0x185>
               	movl	$0x16, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfd44(%rip), %rax      # 0x4100f0
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x1e, %r9
               	je	0x4003c9 <.text+0x1a9>
               	movl	$0x17, %eax
               	retq
               	leaq	0xfd20(%rip), %r9       # 0x4100f0
               	addq	$0xc, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x28, %rax
               	je	0x4003f1 <.text+0x1d1>
               	movl	$0x18, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfd08(%rip), %rax      # 0x410100
               	movslq	(%rax), %r9
               	cmpq	$0x7, %r9
               	je	0x40040e <.text+0x1ee>
               	movl	$0x1f, %eax
               	retq
               	leaq	0xfceb(%rip), %r9       # 0x410100
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x8, %rax
               	je	0x400436 <.text+0x216>
               	movl	$0x20, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfcc3(%rip), %rax      # 0x410100
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x9, %r9
               	je	0x40045a <.text+0x23a>
               	movl	$0x21, %eax
               	retq
               	leaq	0xfc9f(%rip), %r9       # 0x410100
               	addq	$0xc, %r9
               	movslq	(%r9), %rax
               	cmpq	$0xb, %rax
               	je	0x400482 <.text+0x262>
               	movl	$0x22, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfc77(%rip), %rax      # 0x410100
               	addq	$0x10, %rax
               	movslq	(%rax), %r9
               	cmpq	$0xd, %r9
               	je	0x4004a6 <.text+0x286>
               	movl	$0x23, %eax
               	retq
               	leaq	0xfc53(%rip), %r9       # 0x410100
               	addq	$0x14, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x11, %rax
               	je	0x4004ce <.text+0x2ae>
               	movl	$0x24, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfc2b(%rip), %rax      # 0x410100
               	addq	$0x18, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x13, %r9
               	je	0x4004f2 <.text+0x2d2>
               	movl	$0x25, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
               	addb	%al, (%rax)
