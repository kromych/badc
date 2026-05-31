
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
               	leaq	0xfe75(%rip), %r11      # 0x4100d0
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x1, %r11
               	je	0x40027f <.text+0x5f>
               	movl	$0xc, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfe4a(%rip), %rax      # 0x4100d0
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x2, %rax
               	je	0x4002a6 <.text+0x86>
               	movl	$0xd, %eax
               	retq
               	leaq	0xfe23(%rip), %r11      # 0x4100d0
               	movq	%r11, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x3, %r11
               	je	0x4002d1 <.text+0xb1>
               	movl	$0xe, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfdf8(%rip), %rax      # 0x4100d0
               	movq	%rax, %r11
               	addq	$0x10, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x4, %rax
               	je	0x4002f8 <.text+0xd8>
               	movl	$0xf, %eax
               	retq
               	leaq	0xfdd1(%rip), %r11      # 0x4100d0
               	movq	%r11, %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x5, %r11
               	je	0x400323 <.text+0x103>
               	movl	$0x10, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfda6(%rip), %rax      # 0x4100d0
               	movq	%rax, %r11
               	addq	$0x18, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x6, %rax
               	je	0x40034a <.text+0x12a>
               	movl	$0x11, %eax
               	retq
               	leaq	0xfd7f(%rip), %r11      # 0x4100d0
               	movq	%r11, %rax
               	addq	$0x1c, %rax
               	movslq	(%rax), %r11
               	cmpq	$0xc8, %r11
               	je	0x400375 <.text+0x155>
               	movl	$0x12, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfd74(%rip), %rax      # 0x4100f0
               	movslq	(%rax), %r11
               	cmpq	$0xa, %r11
               	je	0x400396 <.text+0x176>
               	movl	$0x15, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfd53(%rip), %rax      # 0x4100f0
               	movq	%rax, %r11
               	addq	$0x4, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x14, %rax
               	je	0x4003bd <.text+0x19d>
               	movl	$0x16, %eax
               	retq
               	leaq	0xfd2c(%rip), %r11      # 0x4100f0
               	movq	%r11, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x1e, %r11
               	je	0x4003e8 <.text+0x1c8>
               	movl	$0x17, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfd01(%rip), %rax      # 0x4100f0
               	movq	%rax, %r11
               	addq	$0xc, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x28, %rax
               	je	0x40040f <.text+0x1ef>
               	movl	$0x18, %eax
               	retq
               	leaq	0xfcea(%rip), %r11      # 0x410100
               	movslq	(%r11), %rax
               	cmpq	$0x7, %rax
               	je	0x40042c <.text+0x20c>
               	movl	$0x1f, %eax
               	retq
               	leaq	0xfccd(%rip), %r11      # 0x410100
               	movq	%r11, %rax
               	addq	$0x4, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x8, %r11
               	je	0x400457 <.text+0x237>
               	movl	$0x20, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfca2(%rip), %rax      # 0x410100
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x9, %rax
               	je	0x40047e <.text+0x25e>
               	movl	$0x21, %eax
               	retq
               	leaq	0xfc7b(%rip), %r11      # 0x410100
               	movq	%r11, %rax
               	addq	$0xc, %rax
               	movslq	(%rax), %r11
               	cmpq	$0xb, %r11
               	je	0x4004a9 <.text+0x289>
               	movl	$0x22, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfc50(%rip), %rax      # 0x410100
               	movq	%rax, %r11
               	addq	$0x10, %r11
               	movslq	(%r11), %rax
               	cmpq	$0xd, %rax
               	je	0x4004d0 <.text+0x2b0>
               	movl	$0x23, %eax
               	retq
               	leaq	0xfc29(%rip), %r11      # 0x410100
               	movq	%r11, %rax
               	addq	$0x14, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x11, %r11
               	je	0x4004fb <.text+0x2db>
               	movl	$0x24, %r11d
               	movq	%r11, %rax
               	retq
               	leaq	0xfbfe(%rip), %rax      # 0x410100
               	movq	%rax, %r11
               	addq	$0x18, %r11
               	movslq	(%r11), %rax
               	cmpq	$0x13, %rax
               	je	0x400522 <.text+0x302>
               	movl	$0x25, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
               	addb	%al, (%rax)
