
sys_queue_and_timeval_macros.x64:	file format elf64-x86-64

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

<lists>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	leaq	-0xd8(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rcx), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	movups	0x40(%rcx), %xmm14
               	movups	%xmm14, 0x40(%rax)
               	movups	0x50(%rcx), %xmm14
               	movups	%xmm14, 0x50(%rax)
               	movups	0x60(%rcx), %xmm14
               	movups	%xmm14, 0x60(%rax)
               	movups	0x70(%rcx), %xmm14
               	movups	%xmm14, 0x70(%rax)
               	movups	0x80(%rcx), %xmm14
               	movups	%xmm14, 0x80(%rax)
               	movups	0x90(%rcx), %xmm14
               	movups	%xmm14, 0x90(%rax)
               	movups	0xa0(%rcx), %xmm14
               	movups	%xmm14, 0xa0(%rax)
               	movups	0xb0(%rcx), %xmm14
               	movups	%xmm14, 0xb0(%rax)
               	movups	0xc0(%rcx), %xmm14
               	movups	%xmm14, 0xc0(%rax)
               	movq	0xd0(%rcx), %r10
               	movq	%r10, 0xd0(%rax)
               	xorl	%ecx, %ecx
               	movq	%rcx, -0x100(%rbp)
               	leaq	-0xf8(%rbp), %rax
               	movq	%rcx, -0xf8(%rbp)
               	movq	%rax, -0xf0(%rbp)
               	leaq	-0xe8(%rbp), %rax
               	movq	%rax, -0xe8(%rbp)
               	movq	%rax, -0xe0(%rbp)
               	leaq	<rip>, %rdx      # <addr>
               	cmpq	$0x0, (%rdx)
               	jne	<addr>
               	movq	-0xe8(%rbp), %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	<rip>, %rdi      # <addr>
               	leaq	-0xd8(%rbp), %rsi
               	imulq	$0x48, %rax, %rdx
               	addq	%rdx, %rsi
               	movq	%rcx, 0x8(%rsi)
               	movq	-0x100(%rbp), %rcx
               	movq	%rcx, 0x10(%rsi)
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	-0x100(%rbp), %rcx
               	leaq	-0xd8(%rbp), %r8
               	addq	%rdx, %r8
               	addq	$0x10, %r8
               	movq	%r8, 0x18(%rcx)
               	leaq	-0xd8(%rbp), %r8
               	leaq	(%r8,%rdx), %rcx
               	movq	%rcx, -0x100(%rbp)
               	imulq	$0x48, %rax, %rcx
               	leaq	(%r8,%rcx), %rdx
               	leaq	-0x100(%rbp), %r8
               	movq	%r8, 0x18(%rdx)
               	movq	$0x0, 0x20(%rdx)
               	movq	0x8(%rdi), %r8
               	leaq	-0xd8(%rbp), %rdx
               	addq	%rcx, %rdx
               	movq	%rdx, (%r8)
               	addq	$0x20, %rdx
               	movq	%rdx, 0x8(%rdi)
               	leaq	-0xd8(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	$0x0, 0x28(%rcx)
               	movq	-0xf0(%rbp), %r8
               	movq	%r8, 0x30(%rcx)
               	movq	-0xf0(%rbp), %r8
               	imulq	$0x48, %rax, %rcx
               	addq	%rcx, %rdx
               	movq	%rdx, (%r8)
               	leaq	-0xd8(%rbp), %rdx
               	addq	%rcx, %rdx
               	leaq	0x28(%rdx), %r8
               	movq	%r8, -0xf0(%rbp)
               	leaq	-0xe8(%rbp), %r8
               	movq	%r8, 0x38(%rdx)
               	leaq	-0xd8(%rbp), %rdx
               	addq	%rcx, %rdx
               	movq	-0xe0(%rbp), %r9
               	movq	%r9, 0x40(%rdx)
               	movq	-0xe8(%rbp), %rdx
               	cmpq	%r8, %rdx
               	jne	<addr>
               	leaq	-0xd8(%rbp), %rdx
               	addq	%rcx, %rdx
               	movq	%rdx, -0xe8(%rbp)
               	jmp	<addr>
               	movq	-0xe0(%rbp), %rdx
               	leaq	-0xd8(%rbp), %r8
               	imulq	$0x48, %rax, %r9
               	addq	%r9, %r8
               	movq	%r8, 0x38(%rdx)
               	leaq	-0xd8(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, -0xe0(%rbp)
               	incq	%rax
               	movq	%rsi, %rcx
               	cmpl	$0x3, %eax
               	jl	<addr>
               	xorl	%edx, %edx
               	movq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	imulq	$0xa, %rdx, %rdx
               	movslq	(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x141, %rdx            # imm = 0x141
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	-0x100(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	imulq	$0xa, %rdx, %rdx
               	movslq	(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x10(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x141, %rdx            # imm = 0x141
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	imulq	$0xa, %rdx, %rdx
               	movslq	(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x20(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x7b, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	-0xf0(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	imulq	$0xa, %rdx, %rdx
               	movslq	(%rax), %rsi
               	addq	%rsi, %rdx
               	movq	0x30(%rax), %rax
               	movq	0x8(%rax), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x141, %rdx            # imm = 0x141
               	jne	<addr>
               	movq	-0xf0(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	(%rax), %rdx
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x90(%rax), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	-0x60(%rbp), %rdx
               	movq	0x8(%rdx), %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	leaq	-0xe8(%rbp), %rsi
               	movq	-0xe8(%rbp), %rax
               	cmpq	%rsi, %rax
               	je	<addr>
               	imulq	$0xa, %rdx, %rdx
               	movslq	(%rax), %rdi
               	addq	%rdi, %rdx
               	movq	0x38(%rax), %rax
               	cmpq	%rsi, %rax
               	jne	<addr>
               	cmpq	$0x7b, %rdx
               	jne	<addr>
               	movq	-0xe0(%rbp), %rdx
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x90(%rax), %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	leaq	0x48(%rax), %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	0x8(%rcx), %rcx
               	leaq	-0xd8(%rbp), %rdx
               	cmpq	$0x0, -0x80(%rbp)
               	je	<addr>
               	movq	-0x80(%rbp), %rax
               	movq	-0x78(%rbp), %rsi
               	movq	%rsi, 0x18(%rax)
               	movq	-0x78(%rbp), %rax
               	movq	-0x80(%rbp), %rsi
               	movq	%rsi, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rsi
               	addq	$0x48, %rdx
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	movq	(%rax), %rdx
               	movq	0x20(%rdx), %rdx
               	movq	%rdx, (%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	movq	%rax, 0x8(%rax)
               	cmpq	$0x0, -0x68(%rbp)
               	je	<addr>
               	movq	-0x68(%rbp), %rax
               	movq	-0x60(%rbp), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	-0x60(%rbp), %rax
               	movq	-0x68(%rbp), %rdx
               	movq	%rdx, (%rax)
               	movq	-0x58(%rbp), %rdx
               	leaq	-0xe8(%rbp), %rax
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	-0x50(%rbp), %rdx
               	movq	%rdx, -0xe0(%rbp)
               	movq	-0x50(%rbp), %rdx
               	cmpq	%rax, %rdx
               	jne	<addr>
               	movq	-0x58(%rbp), %rax
               	movq	%rax, -0xe8(%rbp)
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x8(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x100(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x10(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x20(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0xf8(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x28(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0xe8(%rbp), %rdx
               	movq	-0xe8(%rbp), %rcx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rsi
               	addq	%rsi, %rax
               	movq	0x38(%rcx), %rcx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movl	$0xbaa145b1, %r11d      # imm = 0xBAA145B1
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-0xd8(%rbp), %rax
               	movq	-0x18(%rbp), %rcx
               	movq	%rcx, -0x60(%rbp)
               	leaq	0x90(%rax), %rdx
               	movq	%rdx, -0x68(%rbp)
               	addq	$0x48, %rax
               	movq	%rax, (%rcx)
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x70(%rax), %rcx
               	movq	%rcx, -0x18(%rbp)
               	movq	-0xc8(%rbp), %rcx
               	movq	%rcx, -0x80(%rbp)
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	-0xc8(%rbp), %rcx
               	leaq	0x58(%rax), %rdx
               	movq	%rdx, 0x18(%rcx)
               	addq	$0x48, %rax
               	movq	%rax, -0xc8(%rbp)
               	leaq	-0xd8(%rbp), %rax
               	addq	$0x10, %rax
               	movq	%rax, -0x78(%rbp)
               	xorl	%eax, %eax
               	movq	-0xf8(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x28(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	-0x100(%rbp), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	imulq	$0xa, %rax, %rax
               	movslq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movq	0x10(%rcx), %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	cmpq	$0x1e1b0, %rax          # imm = 0x1E1B0
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	movq	0x20(%rcx), %rcx
               	movq	%rcx, (%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	%rax, 0x8(%rax)
               	movq	(%rax), %rax
               	leaq	-0xd8(%rbp), %rcx
               	addq	$0x90, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x28(%rbp)
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movq	-0x50(%rbp), %rax
               	movq	-0x58(%rbp), %rdx
               	movq	%rdx, 0x38(%rax)
               	jmp	<addr>
               	movq	-0x58(%rbp), %rdx
               	movq	-0x50(%rbp), %rsi
               	movq	%rsi, 0x40(%rdx)
               	jmp	<addr>
               	movq	-0x60(%rbp), %rax
               	movq	%rax, -0xf0(%rbp)
               	jmp	<addr>
               	movq	(%rax), %rax
               	jmp	<addr>
               	movq	0x20(%rax), %rax
               	movq	0x20(%rax), %rdx
               	leaq	-0xd8(%rbp), %rsi
               	addq	$0x48, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	0x20(%rax), %rdx
               	movq	0x20(%rdx), %rdx
               	movq	%rdx, 0x20(%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	addq	$0x20, %rax
               	movq	%rax, 0x8(%rdx)
               	jmp	<addr>
               	movq	%rcx, %rax
               	movq	0x8(%rax), %rsi
               	cmpq	%rdx, %rsi
               	je	<addr>
               	movq	0x8(%rax), %rax
               	movq	0x8(%rax), %rsi
               	cmpq	%rdx, %rsi
               	jne	<addr>
               	movq	0x8(%rax), %rdx
               	movq	0x8(%rdx), %rdx
               	movq	%rdx, 0x8(%rax)
               	jmp	<addr>

<platform_lists>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x20(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movq	%rcx, -0x10(%rbp)
               	movq	%rax, -0x8(%rbp)
               	movq	%rcx, -0x28(%rbp)
               	leaq	-0x30(%rbp), %rdx
               	movq	%rdx, (%rax)
               	leaq	0x8(%rdx), %rax
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movq	-0x10(%rbp), %rdx
               	movq	%rdx, -0x18(%rbp)
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	0x8(%rax), %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	%rax, -0x10(%rbp)
               	testq	%rax, %rax
               	je	<addr>
               	imulq	$0xa, %rcx, %rcx
               	movl	(%rax), %edx
               	addq	%rdx, %rcx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdx
               	movq	-0x10(%rbp), %rax
               	leaq	-0x30(%rbp), %rsi
               	cmpq	%rsi, %rax
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	0x8(%rax), %rax
               	movq	%rax, -0x10(%rbp)
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%rdx, -0x8(%rbp)
               	cmpl	$0x15, %ecx
               	jne	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	-0x20(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x18(%rbp)
               	jne	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0xe, %eax
               	jmp	<addr>
               	movq	-0x10(%rbp), %rax
               	jmp	<addr>
               	movq	0x8(%rax), %rax
               	movq	0x8(%rax), %rdx
               	leaq	-0x30(%rbp), %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	0x8(%rax), %rdx
               	movq	0x8(%rdx), %rdx
               	movq	%rdx, 0x8(%rax)
               	testq	%rdx, %rdx
               	jne	<addr>
               	addq	$0x8, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>

<timevals>:
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	jmp	<addr>
