
divide_in_loop_live_values.x64:	file format elf64-x86-64

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

<sum_div_mod>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdx, %r8
               	xorl	%ecx, %ecx
               	movq	%rcx, %rsi
               	movl	(%rdi,%rcx,4), %r9d
               	movl	%r9d, %eax
               	cltd
               	idivl	%r8d
               	movq	%rax, %rbx
               	movl	%r9d, %eax
               	cltd
               	idivl	%r8d
               	leaq	(%rbx,%rdx), %rax
               	addq	%rax, %rsi
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	leave
               	retq

<mix>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdx, %r8
               	movl	$0x1, %esi
               	xorl	%ecx, %ecx
               	movq	(%rdi,%rcx,8), %r9
               	movq	%r9, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %rbx
               	movq	%r9, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	imulq	$0x1f, %rsi, %rsi
               	leaq	0x1(%rdx), %r9
               	movq	%rbx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	addq	%rax, %rsi
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x310, %rsp            # imm = 0x310
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x7, -0x10(%rbp)
               	movq	$0xd, -0x8(%rbp)
               	xorl	%ebx, %ebx
               	movl	$0x1, %r12d
               	movl	$0x9e3779b9, %ecx       # imm = 0x9E3779B9
               	movq	%rbx, %rax
               	leaq	-0x310(%rbp), %rdx
               	imulq	$0x25, %rax, %rsi
               	subq	$0x384, %rsi            # imm = 0x384
               	movl	%esi, (%rdx,%rax,4)
               	leaq	-0x210(%rbp), %rdx
               	movq	%rax, %rsi
               	imulq	%rcx, %rsi
               	addq	$0x5, %rsi
               	movq	%rsi, (%rdx,%rax,8)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	leaq	-0x310(%rbp), %rax
               	movslq	(%rax,%rcx,4), %rax
               	movq	%rax, %rdx
               	imulq	%rdi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rdx, %rsi
               	movq	%rax, %rdx
               	imulq	%rdi, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %r8
               	shrq	$0x3f, %r8
               	addq	%r8, %rdx
               	imulq	$0x7, %rdx, %rdx
               	subq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rax, %rbx
               	imulq	$0x1f, %r12, %r9
               	leaq	-0x210(%rbp), %rax
               	movq	(%rax,%rcx,8), %rsi
               	movabsq	$0x4ec4ec4ec4ec4ec5, %r8 # imm = 0x4EC4EC4EC4EC4EC5
               	movq	%rsi, %rax
               	mulq	%r8
               	movq	%rdx, %r12
               	shrq	$0x2, %r12
               	movq	%rsi, %rax
               	mulq	%r8
               	shrq	$0x2, %rdx
               	imulq	$0xd, %rdx, %rax
               	subq	%rax, %rsi
               	incq	%rsi
               	movq	%r12, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	leaq	(%r9,%rax), %r12
               	incq	%rcx
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	leaq	-0x310(%rbp), %rdi
               	movl	$0x40, %esi
               	movl	-0x10(%rbp), %edx
               	callq	<addr>
               	cmpl	%ebx, %eax
               	setne	%bl
               	movzbq	%bl, %rbx
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x40, %esi
               	movq	-0x8(%rbp), %rdx
               	callq	<addr>
               	cmpq	%r12, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
