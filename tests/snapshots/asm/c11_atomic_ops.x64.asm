
c11_atomic_ops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%r13, (%rsp)
               	movl	$0x64, %eax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	xorq	$0x64, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0xfa, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x8(%rbp), %rax
               	movl	(%rax), %eax
               	xorq	$0xfa, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x5, %ecx
               	movl	(%rax), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movq	%rdx, %rax
               	xorq	$0xfa, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	-0x8(%rbp), %eax
               	xorq	$0xff, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x32, %ecx
               	movl	(%rax), %edx
               	movq	%rcx, %r10
               	movq	%rdx, %rcx
               	subq	%r10, %rcx
               	movl	%ecx, (%rax)
               	movq	%rdx, %rax
               	xorq	$0xff, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	-0x8(%rbp), %eax
               	xorq	$0xcd, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0xf00, %ecx            # imm = 0xF00
               	movl	(%rax), %edx
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movq	%rdx, %rax
               	xorq	$0xcd, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	-0x8(%rbp), %eax
               	xorq	$0xfcd, %rax            # imm = 0xFCD
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0xff, %ecx
               	movl	(%rax), %edx
               	andq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movq	%rdx, %rax
               	xorq	$0xfcd, %rax            # imm = 0xFCD
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	-0x8(%rbp), %eax
               	xorq	$0xcd, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0xf, %ecx
               	movl	(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movq	%rdx, %rax
               	xorq	$0xcd, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	-0x8(%rbp), %eax
               	xorq	$0xc2, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movl	$0x7, %ecx
               	movl	(%rax), %edx
               	movl	%ecx, (%rax)
               	cmpq	$0xc2, %rdx
               	je	<addr>
               	movl	$0xd, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	-0x8(%rbp), %eax
               	xorq	$0x7, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x7, %eax
               	movl	%eax, -0x10(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movl	$0x63, %edx
               	movl	(%rax), %esi
               	movl	(%rcx), %edi
               	cmpq	%rdi, %rsi
               	sete	%r8b
               	movzbq	%r8b, %r8
               	xorq	%r9, %r9
               	subq	%r8, %r9
               	xorq	%rsi, %rdx
               	andq	%r9, %rdx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movq	%rsi, %rax
               	xorq	%rdi, %rax
               	andq	%r9, %rax
               	xorq	%rsi, %rax
               	movl	%eax, (%rcx)
               	cmpq	$0x1, %r8
               	je	<addr>
               	movl	$0xf, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	-0x8(%rbp), %eax
               	xorq	$0x63, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movl	%eax, -0x18(%rbp)
               	leaq	-0x8(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	movl	$0x4d2, %edx            # imm = 0x4D2
               	movl	(%rax), %esi
               	movl	(%rcx), %edi
               	cmpq	%rdi, %rsi
               	sete	%r8b
               	movzbq	%r8b, %r8
               	xorq	%r9, %r9
               	subq	%r8, %r9
               	xorq	%rsi, %rdx
               	andq	%r9, %rdx
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax)
               	movq	%rsi, %rax
               	xorq	%rdi, %rax
               	andq	%r9, %rax
               	xorq	%rsi, %rax
               	movl	%eax, (%rcx)
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x11, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	-0x8(%rbp), %eax
               	xorq	$0x63, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	-0x18(%rbp), %eax
               	xorq	$0x63, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0xc8, %eax
               	movb	%al, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x64, %ecx
               	movzbq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, (%rax)
               	movq	%rdx, %rax
               	xorq	$0xc8, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movzbq	-0x20(%rbp), %rax
               	cmpq	$0x2c, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x9c40, %eax           # imm = 0x9C40
               	movw	%ax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x7530, %ecx           # imm = 0x7530
               	movzwq	(%rax), %rdx
               	addq	%rdx, %rcx
               	movw	%cx, (%rax)
               	movq	%rdx, %rax
               	xorq	$0x9c40, %rax           # imm = 0x9C40
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movzwq	-0x28(%rbp), %rax
               	cmpq	$0x1170, %rax           # imm = 0x1170
               	je	<addr>
               	movl	$0x17, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x1122334455667788, %rax # imm = 0x1122334455667788
               	movq	%rax, -0x30(%rbp)
               	leaq	-0x30(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	(%rax), %rdx
               	movq	%rcx, (%rax)
               	movabsq	$0x1122334455667788, %r13 # imm = 0x1122334455667788
               	movq	%rdx, %rax
               	cmpq	%r13, %rdx
               	je	<addr>
               	movl	$0x18, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	-0x30(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
