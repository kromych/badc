
dead_phi_web.x64:	file format elf64-x86-64

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

<quot128>:
               	movq	%rdx, %rcx
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpq	%rcx, %rdi
               	jb	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rdi
               	movq	%rdi, %rdx
               	movq	%rsi, %rax
               	divq	%rcx
               	retq
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	jmp	<addr>

<rem128>:
               	movq	%rdx, %rcx
               	testq	%rdi, %rdi
               	je	<addr>
               	cmpq	%rcx, %rdi
               	jb	<addr>
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rdi
               	movq	%rdi, %rdx
               	movq	%rsi, %rax
               	divq	%rcx
               	movq	%rax, %rdx
               	imulq	%rdx, %rcx
               	movq	%rsi, %rax
               	subq	%rcx, %rax
               	retq
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rdx, %rax
               	jmp	<addr>

<rotate_dead>:
               	xorl	%eax, %eax
               	cmpl	%edi, %eax
               	jge	<addr>
               	incq	%rax
               	cmpl	%edi, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r12
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %r13
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rbx, %rbx
               	je	<addr>
               	cmpq	%r13, %rbx
               	jb	<addr>
               	movq	%rbx, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%r12, %rax
               	divq	%r13
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rbx, %rbx
               	je	<addr>
               	cmpq	%r13, %rbx
               	jb	<addr>
               	movq	%rbx, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	movq	%r12, %rax
               	divq	%r13
               	imulq	%r13, %rax
               	movq	%r12, %rdx
               	subq	%rax, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%edi, %edi
               	movl	$0x3, %edx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	movabsq	$-0x5555555555555555, %rsi # imm = 0xAAAAAAAAAAAAAAAB
               	movq	%r12, %rax
               	mulq	%rsi
               	movq	%rdx, %rax
               	shrq	%rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	testq	%rbx, %rbx
               	je	<addr>
               	cmpq	$0x1, %rbx
               	jb	<addr>
               	movq	%rbx, %rdx
               	subq	%rbx, %rdx
               	divq	%rsi
               	movq	%rax, %rdx
               	movq	%rdx, %rax
               	negq	%rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%rbx, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	%rbx, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	movq	%r12, %rax
               	divq	%rbx
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rbx, %rbx
               	je	<addr>
               	cmpq	%r12, %rbx
               	jb	<addr>
               	movq	%rbx, %rax
               	xorl	%edx, %edx
               	divq	%r12
               	movq	%rdx, %rbx
               	movq	%rbx, %rdx
               	movq	%r12, %rax
               	divq	%r12
               	imulq	%r12, %rax
               	movq	%r12, %rdx
               	subq	%rax, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%r12, %rax
               	xorl	%edx, %edx
               	divq	%r12
               	jmp	<addr>
               	movq	%r12, %rax
               	xorl	%edx, %edx
               	divq	%rbx
               	jmp	<addr>
               	movq	%rbx, %rdx
               	jmp	<addr>
               	movq	%rbx, %rdx
               	jmp	<addr>
               	movq	%r12, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	jmp	<addr>
               	movq	%rbx, %rdx
               	jmp	<addr>
               	movq	%r12, %rax
               	xorl	%edx, %edx
               	divq	%r13
               	jmp	<addr>
