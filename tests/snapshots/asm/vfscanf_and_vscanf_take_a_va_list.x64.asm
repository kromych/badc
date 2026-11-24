
vfscanf_and_vscanf_take_a_va_list.x64:	file format elf64-x86-64

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

<scan_file>:
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

<scan_stdin>:
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
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	leaq	-0x18(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<main>:
               	subq	$0x40, %rsp
               	pushq	%rbx
               	subq	$0x10, %rsp
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x0, 0x20(%rsp)
               	movl	$0x0, 0x28(%rsp)
               	movw	$0x0, 0x30(%rsp)
               	leaq	0x38(%rsp), %rcx
               	movq	$0x0, (%rcx)
               	movb	$0x0, 0x40(%rsp)
               	leaq	0x48(%rsp), %rax
               	movl	$0x0, (%rax)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rbx, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	0x38(%rsp), %rcx
               	leaq	0x40(%rsp), %r8
               	leaq	0x48(%rsp), %r9
               	leaq	0x28(%rsp), %rax
               	leaq	0x30(%rsp), %rdi
               	movq	%rax, (%rsp)
               	movq	%rdi, 0x8(%rsp)
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movl	0x20(%rsp), %eax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	0x40(%rsp), %rax
               	cmpl	$0x79, %eax
               	jne	<addr>
               	leaq	0x48(%rsp), %rdi
               	leaq	<rip>, %rsi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movl	0x28(%rsp), %eax
               	cmpl	$0x13, %eax
               	jne	<addr>
               	movswq	0x30(%rsp), %rax
               	cmpl	$0x63, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	leaq	<rip>, %rsi # <addr>
               	leaq	0x20(%rsp), %rdx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	addq	$0x40, %rsp
               	retq
