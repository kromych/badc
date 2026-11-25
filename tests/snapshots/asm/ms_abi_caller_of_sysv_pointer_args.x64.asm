
ms_abi_caller_of_sysv_pointer_args.x64:	file format elf64-x86-64

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

<callee>:
               	subq	$0x18, %rsp
               	movq	0x20(%rsp), %r10
               	movq	%r10, (%rsp)
               	movq	0x28(%rsp), %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	(%rdi,%rdi,2), %rax
               	addq	%rsi, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rdx, <rip> # <addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%r8,%r8,2), %rax
               	addq	%r9, %rax
               	movq	%rax, <rip> # <addr>
               	movq	(%rsp), %rax
               	leaq	(%rax,%rax,2), %rax
               	movq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movl	0x30(%rsp), %eax
               	movq	%rax, <rip> # <addr>
               	movq	0x38(%rsp), %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq

<caller>:
               	pushq	%rax
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	leaq	0x1(%rcx), %rdi
               	movl	$0x2, %eax
               	movq	0x48(%rsp), %rdx
               	leaq	(%r8,%r8,8), %rcx
               	leaq	0x2(%rcx), %r12
               	leaq	0x1(%rsi), %r8
               	movl	$0x5, %r9d
               	movq	0x40(%rsp), %rcx
               	incq	%rcx
               	movl	$0x6, %ebx
               	shlq	%rsi
               	addq	$0x5, %rsi
               	movq	%rcx, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	$0x134ac, 0x18(%rsp)    # imm = 0x134AC
               	movq	%rax, %rsi
               	movq	%r12, %rcx
               	callq	*%rdx
               	addq	$0x20, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq

<main>:
               	pushq	%rax
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x10, %rsp
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
               	vaddsd	<rip>, %xmm0, %xmm0
               	movq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdi
               	movq	<rip>, %rax # <addr>
               	leaq	0x2(%rax), %rbx
               	movq	<rip>, %rax # <addr>
               	leaq	0x3(%rax), %rdx
               	movq	<rip>, %rax # <addr>
               	leaq	0x4(%rax), %r12
               	movq	<rip>, %rax # <addr>
               	leaq	0x5(%rax), %r14
               	movq	<rip>, %rax # <addr>
               	leaq	0x6(%rax), %r9
               	movq	<rip>, %rax # <addr>
               	leaq	0x7(%rax), %r13
               	movq	%r13, (%rsp)
               	leaq	-<rip>, %r10 # <addr>
               	movq	%r10, 0x8(%rsp)
               	movq	%rbx, %rsi
               	movq	%r14, %r8
               	movq	%r12, %rcx
               	callq	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	cmpq	$0x8, %rax
               	movq	%rdx, %rax
               	cmovneq	%rcx, %rax
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
               	leaq	(%r14,%r14,8), %rdx
               	addq	$0x2, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	orq	$0x2, %rax
               	leaq	0x1(%rbx), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	$0x5, %rcx
               	movq	%rax, %rdx
               	orq	$0x4, %rdx
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rcx, %rsi
               	cmovneq	%rdx, %rax
               	movq	<rip>, %rcx # <addr>
               	leaq	0x1(%r13), %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	$0x6, %rdx
               	cmpq	%rdx, %rcx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x134ac, %rcx          # imm = 0x134AC
               	je	<addr>
               	orq	$0x8, %rax
               	movq	%rbx, %rcx
               	shlq	%rcx
               	addq	$0x5, %rcx
               	movl	%ecx, %ecx
               	movq	%rax, %rdx
               	orq	$0x10, %rdx
               	movq	<rip>, %rsi # <addr>
               	cmpq	%rcx, %rsi
               	cmovneq	%rdx, %rax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r11
               	retq
