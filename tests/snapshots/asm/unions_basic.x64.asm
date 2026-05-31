
unions_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %r11
               	movl	$0x2a, %r9d
               	movl	%r9d, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movslq	(%r8), %r8
               	cmpq	$0x2a, %r8
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	xorq	%rax, %rax
               	movl	%eax, (%r8)
               	leaq	-0x8(%rbp), %r11
               	leaq	<rip>, %rax
               	movq	%rax, (%r11)
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r8
               	movzbq	(%r8), %r8
               	xorq	$0x68, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movq	(%r8), %r8
               	addq	$0x1, %r8
               	movzbq	(%r8), %r8
               	xorq	$0x69, %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r8
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, (%r8)
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %r11
               	movabsq	$0x400b333333333333, %rax # imm = 0x400B333333333333
               	movq	%r11, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%r11b
               	movzbq	%r11b, %r11
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %r11
               	movabsq	$0x400ccccccccccccd, %rax # imm = 0x400CCCCCCCCCCCCD
               	movq	%r11, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	seta	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	$0x1, %eax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x8, %r8
               	movl	$0x64, %eax
               	movl	%eax, (%r8)
               	leaq	-0x18(%rbp), %r11
               	movslq	(%r11), %r11
               	cmpq	$0x1, %r11
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	addq	$0x8, %r11
               	movslq	(%r11), %r11
               	cmpq	$0x64, %r11
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	$0x2, %eax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %r8
               	addq	$0x8, %r8
               	leaq	<rip>, %rax
               	movq	%rax, (%r8)
               	leaq	-0x18(%rbp), %r11
               	movslq	(%r11), %r11
               	cmpq	$0x2, %r11
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	addq	$0x8, %r11
               	movq	(%r11), %r11
               	movzbq	(%r11), %r11
               	xorq	$0x79, %r11
               	movl	$0xffffffff, %r10d      # imm = 0xFFFFFFFF
               	andq	%r10, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
