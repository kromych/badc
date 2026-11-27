
divide_in_loop_live_values.x64:	file format elf64-x86-64

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

<sum_div_mod>:
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
               	retq

<mix>:
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
               	nopl	(%rax,%rax)
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	movq	%rsi, %rax
               	popq	%rbx
               	retq

<main>:
               	subq	$0x318, %rsp            # imm = 0x318
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x7, 0x310(%rsp)
               	movq	$0xd, 0x318(%rsp)
               	xorl	%ebx, %ebx
               	movl	$0x1, %r12d
               	movl	$0x9e3779b9, %ecx       # imm = 0x9E3779B9
               	movq	%rbx, %rax
               	imulq	$0x25, %rax, %rsi
               	subq	$0x384, %rsi            # imm = 0x384
               	movl	%esi, 0x10(%rsp,%rax,4)
               	movq	%rax, %rsi
               	imulq	%rcx, %rsi
               	addq	$0x5, %rsi
               	movq	%rsi, 0x110(%rsp,%rax,8)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x40, %eax
               	jl	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x92492493, %edi       # imm = 0x92492493
               	movslq	0x10(%rsp,%rcx,4), %rax
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
               	imulq	$0x1f, %r12, %r10
               	movq	0x110(%rsp,%rcx,8), %rsi
               	movabsq	$0x4ec4ec4ec4ec4ec5, %r8 # imm = 0x4EC4EC4EC4EC4EC5
               	movq	%rsi, %rax
               	mulq	%r8
               	movq	%rdx, %r9
               	shrq	$0x2, %r9
               	movq	%rsi, %rax
               	mulq	%r8
               	shrq	$0x2, %rdx
               	imulq	$0xd, %rdx, %rax
               	subq	%rax, %rsi
               	incq	%rsi
               	movq	%r9, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	leaq	(%r10,%rax), %r12
               	incq	%rcx
               	nopw	(%rax,%rax)
               	cmpl	$0x40, %ecx
               	jl	<addr>
               	movl	0x310(%rsp), %edx
               	leaq	0x10(%rsp), %rdi
               	movl	$0x40, %esi
               	callq	<addr>
               	cmpl	%ebx, %eax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movq	0x318(%rsp), %rdx
               	leaq	0x110(%rsp), %rdi
               	movl	$0x40, %esi
               	callq	<addr>
               	cmpq	%r12, %rax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	addq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	addq	$0x318, %rsp            # imm = 0x318
               	retq
