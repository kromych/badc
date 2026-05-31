
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
               	leaq	-0x8(%rbp), %r9
               	xorq	%rax, %rax
               	movl	%eax, (%r9)
               	leaq	-0x8(%rbp), %r11
               	leaq	0xfe4a(%rip), %rax      # 0x4100d0
               	movq	%rax, (%r11)
               	leaq	-0x8(%rbp), %r9
               	movq	(%r9), %rax
               	movzbq	(%rax), %r9
               	xorq	$0x68, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4002bf <.text+0x9f>
               	movl	$0x2, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movq	(%r9), %rax
               	addq	$0x1, %rax
               	movzbq	(%rax), %r9
               	xorq	$0x69, %r9
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	je	0x4002fc <.text+0xdc>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %r9
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, (%r9)
               	leaq	-0x8(%rbp), %r11
               	movq	(%r11), %rax
               	movabsq	$0x400b333333333333, %r11 # imm = 0x400B333333333333
               	movq	%rax, %xmm14
               	movq	%r11, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setb	%al
               	movzbq	%al, %rax
               	setnp	%r11b
               	movzbq	%r11b, %r11
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40035f <.text+0x13f>
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
               	seta	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	je	0x4003a2 <.text+0x182>
               	movl	$0x5, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r11, %r11
               	cmpq	$0x0, %r11
               	je	0x4003c0 <.text+0x1a0>
               	movl	$0x6, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	$0x1, %eax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x8, %r9
               	movl	$0x64, %eax
               	movl	%eax, (%r9)
               	leaq	-0x18(%rbp), %r11
               	movslq	(%r11), %rax
               	cmpq	$0x1, %rax
               	je	0x400405 <.text+0x1e5>
               	movl	$0x7, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movslq	(%rax), %r11
               	cmpq	$0x64, %r11
               	je	0x40042e <.text+0x20e>
               	movl	$0x8, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r11
               	movl	$0x2, %eax
               	movl	%eax, (%r11)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x8, %r9
               	leaq	0xfc87(%rip), %rax      # 0x4100d3
               	movq	%rax, (%r9)
               	leaq	-0x18(%rbp), %r11
               	movslq	(%r11), %rax
               	cmpq	$0x2, %rax
               	je	0x400475 <.text+0x255>
               	movl	$0x9, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	movq	(%rax), %r11
               	movzbq	(%r11), %rax
               	xorq	$0x79, %rax
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x4004b6 <.text+0x296>
               	movl	$0xa, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	cmpq	$0x0, %rax
               	je	0x4004d8 <.text+0x2b8>
               	movl	$0xb, %r11d
               	movq	%r11, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
