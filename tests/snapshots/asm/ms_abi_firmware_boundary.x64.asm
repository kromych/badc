
ms_abi_firmware_boundary.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<step>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	leave
               	retq

<clobber_vectors>:
               	pcmpeqd	%xmm6, %xmm6
               	pcmpeqd	%xmm7, %xmm7
               	pcmpeqd	%xmm8, %xmm8
               	pcmpeqd	%xmm9, %xmm9
               	pcmpeqd	%xmm10, %xmm10
               	pcmpeqd	%xmm11, %xmm11
               	pcmpeqd	%xmm12, %xmm12
               	pcmpeqd	%xmm13, %xmm13
               	pcmpeqd	%xmm14, %xmm14
               	pcmpeqd	%xmm15, %xmm15
               	retq

<probe>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc8, %rsp
               	pushq	%rsi
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rdi
               	pushq	%rbx
               	movups	%xmm6, 0x40(%rsp)
               	movups	%xmm7, 0x50(%rsp)
               	movups	%xmm8, 0x60(%rsp)
               	movups	%xmm9, 0x70(%rsp)
               	movups	%xmm10, 0x80(%rsp)
               	movups	%xmm11, 0x90(%rsp)
               	movups	%xmm12, 0xa0(%rsp)
               	movups	%xmm13, 0xb0(%rsp)
               	movups	%xmm14, 0xc0(%rsp)
               	movups	%xmm15, 0xd0(%rsp)
               	movq	%rcx, %rbx
               	movq	%r9, %r14
               	movq	%r8, %r13
               	movq	%rdx, %r12
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r15
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, 0xf8(%rsp)
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, 0xf0(%rsp)
               	movq	%r14, %rdi
               	callq	<addr>
               	movq	%rax, 0xe8(%rsp)
               	leaq	(%rbx,%r14), %rdi
               	callq	<addr>
               	leaq	(%r12,%r13), %rdi
               	callq	<addr>
               	imulq	$0x3e8, %r15, %rax      # imm = 0x3E8
               	movq	0xf8(%rsp), %rcx
               	imulq	$0x64, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0xf0(%rsp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	addq	0xe8(%rsp), %rax
               	movups	0x40(%rsp), %xmm6
               	movups	0x50(%rsp), %xmm7
               	movups	0x60(%rsp), %xmm8
               	movups	0x70(%rsp), %xmm9
               	movups	0x80(%rsp), %xmm10
               	movups	0x90(%rsp), %xmm11
               	movups	0xa0(%rsp), %xmm12
               	movups	0xb0(%rsp), %xmm13
               	movups	0xc0(%rsp), %xmm14
               	movups	0xd0(%rsp), %xmm15
               	popq	%rbx
               	popq	%rdi
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%rsi
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r15
               	pushq	%rbx
               	leaq	-<rip>, %rbx      # <addr>
               	movq	$0x6, %rax
               	movq	%rax, %xmm6
               	movq	$0x7, %rax
               	movq	%rax, %xmm7
               	movq	$0x8, %rax
               	movq	%rax, %xmm8
               	movq	$0x9, %rax
               	movq	%rax, %xmm9
               	movq	$0xa, %rax
               	movq	%rax, %xmm10
               	movq	$0xb, %rax
               	movq	%rax, %xmm11
               	movq	$0xc, %rax
               	movq	%rax, %xmm12
               	movq	$0xd, %rax
               	movq	%rax, %xmm13
               	movq	$0xe, %rax
               	movq	%rax, %xmm14
               	movq	$0xf, %rax
               	movq	%rax, %xmm15
               	movq	%rsp, %r15
               	andq	$-0x10, %rsp
               	subq	$0xa0, %rsp
               	movq	$0x1, %rcx
               	movq	$0x2, %rdx
               	movq	$0x3, %r8
               	movq	$0x4, %r9
               	movq	$0x1111, %rsi           # imm = 0x1111
               	movq	$0x2222, %rdi           # imm = 0x2222
               	callq	*%rbx
               	movq	%r15, %rsp
               	movq	%rax, <rip>      # <addr>
               	movq	%rsi, <rip>      # <addr>
               	movq	%rdi, <rip>      # <addr>
               	xorl	%ecx, %ecx
               	movq	%xmm6, %rax
               	xorq	$0x6, %rax
               	orq	%rax, %rcx
               	movq	%xmm7, %rax
               	xorq	$0x7, %rax
               	orq	%rax, %rcx
               	movq	%xmm8, %rax
               	xorq	$0x8, %rax
               	orq	%rax, %rcx
               	movq	%xmm9, %rax
               	xorq	$0x9, %rax
               	orq	%rax, %rcx
               	movq	%xmm10, %rax
               	xorq	$0xa, %rax
               	orq	%rax, %rcx
               	movq	%xmm11, %rax
               	xorq	$0xb, %rax
               	orq	%rax, %rcx
               	movq	%xmm12, %rax
               	xorq	$0xc, %rax
               	orq	%rax, %rcx
               	movq	%xmm13, %rax
               	xorq	$0xd, %rax
               	orq	%rax, %rcx
               	movq	%xmm14, %rax
               	xorq	$0xe, %rax
               	orq	%rax, %rcx
               	movq	%xmm15, %rax
               	xorq	$0xf, %rax
               	orq	%rax, %rcx
               	movq	%rcx, <rip>      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x4d2, %rax            # imm = 0x4D2
               	je	<addr>
               	movl	$0x1, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	popq	%r15
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x1111, %rax           # imm = 0x1111
               	je	<addr>
               	movl	$0x2, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	popq	%r15
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x2222, %rax           # imm = 0x2222
               	je	<addr>
               	movl	$0x3, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	popq	%r15
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	popq	%r15
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsp
               	popq	%rbx
               	popq	%r15
               	popq	%rbp
               	retq
