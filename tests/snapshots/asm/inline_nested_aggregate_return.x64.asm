
inline_nested_aggregate_return.x64:	file format elf64-x86-64

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

<make_pair>:
               	movq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	retq

<make_wide>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	leaq	-0x30(%rbp), %rcx
               	movq	%rsi, -0x30(%rbp)
               	leaq	0x1(%rsi), %rax
               	movq	%rax, -0x28(%rbp)
               	leaq	0x2(%rsi), %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	0x3(%rsi), %rax
               	movq	%rax, -0x18(%rbp)
               	leaq	0x4(%rsi), %rax
               	movq	%rax, -0x10(%rbp)
               	leaq	0x5(%rsi), %rax
               	movq	%rax, -0x8(%rbp)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	-0x50(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rdx, %r12
               	movq	%rbx, -0x40(%rbp)
               	movq	%r12, -0x38(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	movq	-0x20(%rbp), %rdx
               	movq	-0x18(%rbp), %rsi
               	movq	-0x10(%rbp), %rdi
               	movq	-0x8(%rbp), %r8
               	leaq	(%rbx,%r12), %r9
               	addq	%r9, %rax
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	cmpq	$0x38, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rdx, %r13
               	movq	%r12, -0x40(%rbp)
               	movq	%r13, -0x38(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	-0x30(%rbp), %rax
               	movq	-0x28(%rbp), %rcx
               	movq	-0x20(%rbp), %rdx
               	movq	-0x18(%rbp), %rsi
               	movq	-0x10(%rbp), %rdi
               	movq	-0x8(%rbp), %r8
               	leaq	(%r12,%r13), %r9
               	addq	%r9, %rax
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	orq	$0x2, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rdx, %r12
               	movq	%rax, -0x10(%rbp)
               	movq	%r12, -0x8(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	addq	%r12, %rax
               	cmpq	$0x16, %rax
               	je	<addr>
               	orq	$0x4, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rdx, %r12
               	movq	%rax, -0x40(%rbp)
               	movq	%r12, -0x38(%rbp)
               	leaq	-0x30(%rbp), %rdi
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	-0x8(%rbp), %rax
               	addq	%r12, %rax
               	cmpq	$0x1a, %rax
               	je	<addr>
               	orq	$0x8, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, -0x10(%rbp)
               	movq	%rdx, -0x8(%rbp)
               	shlq	%rax
               	addq	%rdx, %rax
               	cmpq	$0x1a, %rax
               	je	<addr>
               	orq	$0x10, %rbx
               	movabsq	$0x4022000000000000, %rax # imm = 0x4022000000000000
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	orq	$0x20, %rbx
               	movl	$0xa, %esi
               	leaq	-0x30(%rbp), %rdi
               	callq	<addr>
               	movq	-0x18(%rbp), %rax
               	cmpq	$0xd, %rax
               	je	<addr>
               	orq	$0x40, %rbx
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	orq	$0x80, %rbx
               	movq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%ebx, %ebx
               	jmp	<addr>
