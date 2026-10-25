
aio_read_write_completes.x64:	file format elf64-x86-64

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

<finish>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rbx, -0x18(%rbp)
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rdi
               	movl	$0x1, %esi
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x73, %rax
               	je	<addr>
               	movl	$0x1, %ecx
               	testl	%eax, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	%r12, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2e8, %rsp            # imm = 0x2E8
               	pushq	%rbx
               	leaq	-0x2b8(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movl	0x10(%rax), %r10d
               	movl	%r10d, 0x10(%rdi)
               	movzbq	0x14(%rax), %r10
               	movb	%r10b, 0x14(%rdi)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x2b8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x1f8(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xa8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x1f8(%rbp), %rdi
               	movl	%ebx, -0x1f8(%rbp)
               	leaq	<rip>, %rax
               	movq	%rax, -0x1e8(%rbp)
               	movq	$0xc, -0x1e0(%rbp)
               	movq	$0x0, -0x178(%rbp)
               	movl	$0x1, -0x1cc(%rbp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x1f8(%rbp), %rdi
               	movl	$0xc, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xa8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x150(%rbp), %rdi
               	movl	%ebx, -0x150(%rbp)
               	leaq	-0x2d8(%rbp), %rax
               	movq	%rax, -0x140(%rbp)
               	movq	$0x8, -0x138(%rbp)
               	movq	$0x0, -0xd0(%rbp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x150(%rbp), %rdi
               	movl	$0x8, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x2d8(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0xa8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%ebx, -0xa8(%rbp)
               	leaq	-0x2d0(%rbp), %rax
               	movq	%rax, -0x98(%rbp)
               	movq	$0x4, -0x90(%rbp)
               	movq	$0x8, -0x28(%rbp)
               	xorl	%esi, %esi
               	movl	%esi, -0xa4(%rbp)
               	leaq	-0x2a0(%rbp), %rdi
               	movl	$0xa8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x2a0(%rbp), %rax
               	movl	%ebx, -0x2a0(%rbp)
               	movl	$0x2, %edx
               	movl	%edx, -0x29c(%rbp)
               	leaq	-0x2c8(%rbp), %rsi
               	xorl	%edi, %edi
               	leaq	-0xa8(%rbp), %rcx
               	movq	%rcx, -0x2c8(%rbp)
               	movq	%rax, -0x2c0(%rbp)
               	movq	%rdi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	leaq	-0x2d0(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x101000, %edi         # imm = 0x101000
               	leaq	-0x1f8(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x1f8(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
