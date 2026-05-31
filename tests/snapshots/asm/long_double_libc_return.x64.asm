
long_double_libc_return.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x4002d7 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfe04(%rip), %rbx      # 0x410100
               	xorq	%r12, %r12
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400607 <strtold>
               	subq	$0x10, %rsp
               	fstpl	(%rsp)
               	movq	(%rsp), %r10
               	addq	$0x10, %rsp
               	movq	%r10, %rax
               	movabsq	$0x45f0000000000000, %r12 # imm = 0x45F0000000000000
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400385 <.text+0xc5>
               	movl	$0xb, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd94(%rip), %r14      # 0x410120
               	xorq	%r15, %r15
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x400607 <strtold>
               	subq	$0x10, %rsp
               	fstpl	(%rsp)
               	movq	(%rsp), %r10
               	addq	$0x10, %rsp
               	movq	%r10, %rax
               	movabsq	$0x43f0000000000000, %r15 # imm = 0x43F0000000000000
               	movq	%rax, %xmm14
               	movq	%r15, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x400415 <.text+0x155>
               	movl	$0xc, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x3ff0000000000000, %rbx # imm = 0x3FF0000000000000
               	movl	$0x35, %r12d
               	movq	%rbx, %xmm0
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	0x40060d <ldexp>
               	movq	%xmm0, %rax
               	movabsq	$0x4340000000000000, %r12 # imm = 0x4340000000000000
               	movq	%rax, %xmm14
               	movq	%r12, %xmm15
               	ucomisd	%xmm15, %xmm14
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r11b
               	movzbq	%r11b, %r11
               	orq	%r11, %rax
               	cmpq	$0x0, %rax
               	je	0x40049a <.text+0x1da>
               	movl	$0xd, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
