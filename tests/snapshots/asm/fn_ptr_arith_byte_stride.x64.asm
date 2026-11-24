
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
               	subq	$0x28, %rsp
               	leaq	-<rip>, %rcx # <addr>
               	leaq	-<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	leaq	-<rip>, %rsi # <addr>
               	subq	%rsi, %rax
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x28, %rsp
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
               	addq	$0x28, %rsp
               	retq
               	leaq	-<rip>, %rax # <addr>
               	incq	%rax
               	decq	%rax
               	leaq	-<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x28, %rsp
               	retq
               	addq	$0x3, %rax
               	leaq	-<rip>, %rcx # <addr>
               	addq	$0x3, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x28, %rsp
               	retq
               	subq	$0x5, %rax
               	leaq	-<rip>, %rcx # <addr>
               	subq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	0x8(%rsp), %rax
               	leaq	-<rip>, %rcx # <addr>
               	movq	%rcx, 0x8(%rsp)
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rdx, 0x10(%rsp)
               	movq	%rcx, 0x18(%rsp)
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
               	addq	$0x28, %rsp
               	retq
               	addq	$0x8, %rax
               	addq	$0x8, %rax
               	leaq	0x8(%rsp), %rcx
               	addq	$0x10, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	addq	$0x28, %rsp
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
               	addq	$0x28, %rsp
               	retq
               	leaq	0x10(%rsp), %rax
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
               	addq	$0x28, %rsp
               	retq
               	cmpq	$0xc, %rcx
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0x28, %rsp
               	retq
               	leaq	-0x4(%rdx), %rcx
               	leaq	0x8(%rax), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x28, %rsp
               	retq
               	subq	$0x8, %rcx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0x28, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x28, %rsp
               	retq
