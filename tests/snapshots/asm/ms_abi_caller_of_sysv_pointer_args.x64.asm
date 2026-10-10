
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
               	leaq	<rip>, %rax      # <addr>
               	leaq	(%rdi,%rdi,2), %rdi
               	addq	%rdi, %rsi
               	movq	%rsi, (%rax)
               	leaq	<rip>, %rsi      # <addr>
               	movq	%rdx, (%rsi)
               	movq	%rcx, 0x10(%rax)
               	leaq	(%r8,%r8,2), %rcx
               	addq	%r9, %rcx
               	movq	%rcx, 0x18(%rax)
               	leaq	-0x10(%rbp), %rcx
               	movq	(%rcx), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	movq	0x8(%rcx), %rcx
               	addq	%rdx, %rcx
               	movq	%rcx, 0x20(%rax)
               	movl	0x20(%rbp), %ecx
               	movq	%rcx, 0x28(%rax)
               	movq	0x28(%rbp), %rcx
               	movq	%rcx, 0x30(%rax)
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
               	movq	%rax, (%rdi)
               	movq	$0x2, 0x8(%rdi)
               	movq	0x18(%rbp), %rdx
               	leaq	(%r8,%r8,8), %rax
               	leaq	0x2(%rax), %rcx
               	leaq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x1(%rsi), %r8
               	movq	%r8, (%rax)
               	movq	$0x5, 0x8(%rax)
               	leaq	-0x20(%rbp), %r8
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rbp), %r9
               	incq	%r9
               	movq	%r9, (%rax)
               	leaq	-0x10(%rbp), %rax
               	movq	$0x6, 0x8(%rax)
               	shlq	%rsi
               	addq	$0x5, %rsi
               	movl	$0x134ac, %r9d          # imm = 0x134AC
               	movq	0x18(%rbp), %rbx
               	subq	$0x20, %rsp
               	movq	%rsi, 0x10(%rsp)
               	movq	%r9, 0x18(%rsp)
               	movq	%rax, %r10
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
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	xorps	%xmm0, %xmm0
               	movq	%rcx, %r10
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
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm15
               	addsd	%xmm15, %xmm0
               	movq	0x8(%rax), %rcx
               	leaq	0x1(%rcx), %rdi
               	movq	0x10(%rax), %rcx
               	leaq	0x2(%rcx), %rbx
               	movq	0x18(%rax), %rcx
               	leaq	0x3(%rcx), %rdx
               	movq	0x20(%rax), %rcx
               	leaq	0x4(%rcx), %r12
               	movq	0x28(%rax), %rcx
               	leaq	0x5(%rcx), %r13
               	movq	0x30(%rax), %rcx
               	leaq	0x6(%rcx), %r9
               	movq	0x38(%rax), %rax
               	leaq	0x7(%rax), %r14
               	leaq	-<rip>, %rax      # <addr>
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
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rdx
               	leaq	0x1(%r12), %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	addq	$0x2, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	movq	(%rdx), %rdx
               	leaq	-<rip>, %rsi      # <addr>
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	0x10(%rcx), %rdx
               	leaq	(%r13,%r13,8), %rsi
               	addq	$0x2, %rsi
               	cmpq	%rsi, %rdx
               	je	<addr>
               	orq	$0x2, %rax
               	movq	0x18(%rcx), %rcx
               	leaq	0x1(%rbx), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	$0x5, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	orq	$0x4, %rax
               	leaq	<rip>, %rcx      # <addr>
               	movq	0x20(%rcx), %rdx
               	leaq	0x1(%r14), %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	addq	$0x6, %rsi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	movq	0x30(%rcx), %rdx
               	cmpq	$0x134ac, %rdx          # imm = 0x134AC
               	je	<addr>
               	orq	$0x8, %rax
               	movq	0x28(%rcx), %rcx
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
