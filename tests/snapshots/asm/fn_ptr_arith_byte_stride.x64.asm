
fn_ptr_arith_byte_stride.x64:	file format elf64-x86-64

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

<f1>:
               	leaq	(%rdi,%rsi), %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	retq

<f2>:
               	imulq	%rdi, %rsi
               	leaq	(%rsi,%rdx), %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-<rip>, %rcx # <addr>
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	leaq	-<rip>, %rsi # <addr>
               	subq	%rsi, %rax
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	(%rcx,%rdx), %rax
               	movl	$0x2, %edi
               	movl	$0x3, %esi
               	movl	$0x4, %edx
               	movl	$0x5, %ecx
               	movl	$0x6, %r8d
               	callq	*%rax
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	leaq	-<rip>, %rax # <addr>
               	incq	%rax
               	decq	%rax
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	addq	$0x3, %rax
               	leaq	-<rip>, %rcx # <addr>
               	addq	$0x3, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	subq	$0x5, %rax
               	leaq	-<rip>, %rcx # <addr>
               	subq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rax
               	leaq	-<rip>, %rcx # <addr>
               	movq	%rcx, -0x18(%rbp)
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rdx, -0x10(%rbp)
               	movq	%rcx, -0x8(%rbp)
               	leaq	0x10(%rax), %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rdx
               	sarq	$0x3f, %rdx
               	shrq	$0x3d, %rdx
               	addq	%rdx, %rcx
               	sarq	$0x3, %rcx
               	cmpq	$0x2, %rcx
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	addq	$0x8, %rax
               	addq	$0x8, %rax
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x10, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	movl	$0x2, %edi
               	movl	$0x3, %esi
               	movl	$0x4, %edx
               	movl	$0x5, %ecx
               	movl	$0x6, %r8d
               	callq	<addr>
               	cmpq	$0x15, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	leaq	-0x10(%rbp), %rax
               	leaq	0xc(%rax), %rdx
               	movq	%rdx, %rcx
               	subq	%rax, %rcx
               	movq	%rcx, %rsi
               	sarq	$0x3f, %rsi
               	shrq	$0x3e, %rsi
               	addq	%rcx, %rsi
               	sarq	$0x2, %rsi
               	cmpq	$0x3, %rsi
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	leave
               	retq
               	leaq	-0x4(%rdx), %rcx
               	leaq	0x8(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	subq	$0x8, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
