
unions_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	movl	$0x2a, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r9
               	cmpq	$0x2a, %r9
               	je	0x400271 <.text+0x51>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	xorq	%rax, %rax
               	movl	%eax, (%r8)
               	leaq	-0x8(%rbp), %r11
               	leaq	0xfe4a(%rip), %rax      # 0x4100d0
               	movq	%rax, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x68, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x4002c6 <.text+0xa6>
               	movl	$0x2, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %r8
               	movq	%r8, %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r8
               	movq	%r8, %rax
               	xorq	$0x69, %rax
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rax, %r8
               	cmpq	$0x0, %r8
               	je	0x40030d <.text+0xed>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movabsq	$0x400c000000000000, %r8 # imm = 0x400C000000000000
               	movq	%r8, (%rax)
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %r8
               	movabsq	$0x400b333333333333, %r11 # imm = 0x400B333333333333
               	movq	%r8, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400370 <.text+0x150>
               	movl	$0x4, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %r11
               	movabsq	$0x400ccccccccccccd, %rax # imm = 0x400CCCCCCCCCCCCD
               	movq	%r11, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	je	0x4003b3 <.text+0x193>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r8, %r8
               	cmpq	$0x0, %r8
               	je	0x4003d1 <.text+0x1b1>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	movl	$0x1, %eax
               	movl	%eax, (%r8)
               	leaq	-0x18(%rbp), %r11
               	movq	%r11, %rax
               	addq	$0x8, %rax
               	movl	$0x64, %r11d
               	movl	%r11d, (%rax)
               	leaq	-0x18(%rbp), %r8
               	movslq	(%r8), %r11
               	cmpq	$0x1, %r11
               	je	0x400416 <.text+0x1f6>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r8
               	movq	%r8, %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r8
               	cmpq	$0x64, %r8
               	je	0x400446 <.text+0x226>
               	movl	$0x8, %r8d
               	movq	%r8, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movl	$0x2, %r8d
               	movl	%r8d, (%rax)
               	leaq	-0x18(%rbp), %r11
               	movq	%r11, %r8
               	addq	$0x8, %r8
               	leaq	0xfc6b(%rip), %r11      # 0x4100d3
               	movq	%r11, (%r8)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %r11
               	cmpq	$0x2, %r11
               	je	0x400491 <.text+0x271>
               	movl	$0x9, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movq	(%r11), %rax
               	movzbq	(%rax), %r11
               	movq	%r11, %rax
               	xorq	$0x79, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%rax, %r11
               	cmpq	$0x0, %r11
               	je	0x4004d8 <.text+0x2b8>
               	movl	$0xa, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x4004fa <.text+0x2da>
               	movl	$0xb, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
