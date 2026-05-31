
array_init_constant_expression.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	leaq	0xfe92(%rip), %r11      # 0x4100d0
               	movslq	(%r11), %r9
               	cmpq	$0x10, %r9
               	je	0x400254 <.text+0x34>
               	movl	$0xb, %eax
               	retq
               	leaq	0xfe75(%rip), %r9       # 0x4100d0
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x80, %rax
               	je	0x40027c <.text+0x5c>
               	movl	$0xc, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfe4d(%rip), %rax      # 0x4100d0
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x4, %r9
               	je	0x4002a0 <.text+0x80>
               	movl	$0xd, %eax
               	retq
               	leaq	0xfe39(%rip), %r9       # 0x4100e0
               	movslq	(%r9), %rax
               	cmpq	$0x90, %rax
               	je	0x4002c1 <.text+0xa1>
               	movl	$0xe, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfe18(%rip), %rax      # 0x4100e0
               	addq	$0x4, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x94, %r9
               	je	0x4002e5 <.text+0xc5>
               	movl	$0xf, %eax
               	retq
               	leaq	0xfdf4(%rip), %r9       # 0x4100e0
               	addq	$0x8, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x10, %rax
               	je	0x40030d <.text+0xed>
               	movl	$0x10, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfddc(%rip), %rax      # 0x4100f0
               	movslq	(%rax), %r9
               	cmpq	$0x100, %r9             # imm = 0x100
               	je	0x40032a <.text+0x10a>
               	movl	$0x11, %eax
               	retq
               	leaq	0xfdbf(%rip), %r9       # 0x4100f0
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x40, %rax
               	je	0x400352 <.text+0x132>
               	movl	$0x12, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfd9f(%rip), %rax      # 0x4100f8
               	movslq	(%rax), %r9
               	cmpq	$0x11, %r9
               	je	0x40036f <.text+0x14f>
               	movl	$0x13, %eax
               	retq
               	leaq	0xfd82(%rip), %r9       # 0x4100f8
               	addq	$0x4, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x70, %rax
               	je	0x400397 <.text+0x177>
               	movl	$0x14, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfd5a(%rip), %rax      # 0x4100f8
               	addq	$0x8, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x30, %r9
               	je	0x4003bb <.text+0x19b>
               	movl	$0x15, %eax
               	retq
               	leaq	0xfd46(%rip), %r9       # 0x410108
               	movslq	(%r9), %rax
               	cmpq	$0x90, %rax
               	je	0x4003dc <.text+0x1bc>
               	movl	$0x16, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfd25(%rip), %rax      # 0x410108
               	addq	$0x4, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x10, %r9
               	je	0x400400 <.text+0x1e0>
               	movl	$0x17, %eax
               	retq
               	leaq	0xfd01(%rip), %r9       # 0x410108
               	addq	$0x8, %r9
               	movslq	(%r9), %rax
               	cmpq	$0x4, %rax
               	je	0x400428 <.text+0x208>
               	movl	$0x18, %r9d
               	movq	%r9, %rax
               	retq
               	leaq	0xfcd9(%rip), %rax      # 0x410108
               	addq	$0xc, %rax
               	movslq	(%rax), %r9
               	cmpq	$0x14, %r9
               	je	0x40044c <.text+0x22c>
               	movl	$0x19, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
