
ms_abi_caller_of_sysv_pointer_args.x64:	file format elf64-x86-64

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

<callee>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x10(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x8(%rbp)
               	leaq	(%rdi,%rdi,2), %rax
               	addq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rdx, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%r8,%r8,2), %rax
               	addq	%r9, %rax
               	movq	%rax, <rip> # <addr>
               	movq	-0x10(%rbp), %rax
               	leaq	(%rax,%rax,2), %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movl	0x20(%rbp), %eax
               	movq	%rax, <rip> # <addr>
               	movq	0x28(%rbp), %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x8, %eax
               	leave
               	retq

<caller>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	leaq	-0x30(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x1(%rcx), %rax
               	movq	%rax, -0x30(%rbp)
               	movq	$0x2, -0x28(%rbp)
               	movq	0x18(%rbp), %rdx
               	leaq	(%r8,%r8,8), %rax
               	leaq	0x2(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1(%rsi), %rax
               	movq	%rax, -0x20(%rbp)
               	movq	$0x5, -0x18(%rbp)
               	leaq	-0x20(%rbp), %r8
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rbp), %rax
               	incq	%rax
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %r9
               	movq	$0x6, -0x8(%rbp)
               	shlq	%rsi
               	leaq	0x5(%rsi), %rax
               	movl	$0x134ac, %esi          # imm = 0x134AC
               	movq	0x18(%rbp), %rbx
               	subq	$0x20, %rsp
               	movq	%rax, 0x10(%rsp)
               	movq	%rsi, 0x18(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	movq	0x8(%r8), %r9
               	movq	(%r8), %r8
               	callq	*%rbx
               	addq	$0x20, %rsp
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %rax # <addr>
               	xorps	%xmm0, %xmm0
               	movq	%rax, %r10
               	testq	%r10, %r10
               	js	<addr>
               	cvtsi2sd	%r10, %xmm0
               	jmp	<addr>
               	movq	%r10, %r11
               	shrq	%r11
               	andq	$0x1, %r10
               	orq	%r10, %r11
               	cvtsi2sd	%r11, %xmm0
               	addsd	%xmm0, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdi
               	movq	<rip>, %rax # <addr>
               	leaq	0x2(%rax), %rbx
               	movq	<rip>, %rax # <addr>
               	leaq	0x3(%rax), %rdx
               	movq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %r12
               	movq	<rip>, %rax # <addr>
               	leaq	0x5(%rax), %r13
               	movq	<rip>, %rax # <addr>
               	leaq	0x6(%rax), %r9
               	movq	<rip>, %rax # <addr>
               	leaq	0x7(%rax), %r14
               	leaq	-<rip>, %rax # <addr>
               	subq	$0x10, %rsp
               	movq	%r14, (%rsp)
               	movq	%rax, 0x8(%rsp)
               	movq	%rbx, %rsi
               	movq	%r13, %r8
               	movq	%r12, %rcx
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x1(%r12), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	$0x2, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	leaq	-<rip>, %rdx # <addr>
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	leaq	(%r13,%r13,8), %rdx
               	addq	$0x2, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	orq	$0x2, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x1(%rbx), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	$0x5, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	orq	$0x4, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x1(%r14), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	$0x6, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x134ac, %rcx          # imm = 0x134AC
               	je	<addr>
               	orq	$0x8, %rax
               	movq	<rip>, %rcx # <addr>
               	movq	%rbx, %rdx
               	shlq	%rdx
               	addq	$0x5, %rdx
               	movl	%edx, %edx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	orq	$0x10, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>
