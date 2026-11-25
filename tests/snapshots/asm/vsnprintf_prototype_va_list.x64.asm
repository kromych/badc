
vsnprintf_prototype_va_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<format>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc0(%rbp), %rcx
               	movl	$0x18, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	movq	-0xc0(%rbp), %rdx
               	leaq	-0x18(%rbp), %rcx
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<format_unbounded>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdx
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<main>:
               	subq	$0x18, %rsp
               	movabsq	$0x7878787878787878, %rax # imm = 0x7878787878787878
               	movq	%rax, (%rsp)
               	movq	%rax, 0x8(%rsp)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %r8
               	leaq	(%rsp), %rdi
               	movl	$0x10, %esi
               	movl	$0x2a, %ecx
               	movl	$0x7a, %r9d
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rsi
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movabsq	$0x7878787878787878, %rax # imm = 0x7878787878787878
               	movq	%rax, (%rsp)
               	movq	%rax, 0x8(%rsp)
               	leaq	<rip>, %rdx
               	leaq	<rip>, %r8
               	leaq	(%rsp), %rdi
               	movl	$0x4, %esi
               	movl	$0x2a, %ecx
               	movl	$0x7a, %r9d
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rsi
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	movsbq	0x4(%rsp), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rdx
               	leaq	(%rsp), %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movsbq	(%rsp), %rax
               	cmpl	$0x34, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rsi
               	leaq	<rip>, %rdx
               	leaq	(%rsp), %rdi
               	movl	$0x7, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rsi
               	leaq	(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
