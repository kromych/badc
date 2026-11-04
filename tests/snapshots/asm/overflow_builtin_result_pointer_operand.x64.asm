
overflow_builtin_result_pointer_operand.x64:	file format elf64-x86-64

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

<scaled>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	retq

<decremented>:
               	leaq	-0x1(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	<rip>, %rcx # <addr>
               	leaq	0x29(%rcx), %rax
               	movq	%rax, <rip> # <addr>
               	xorq	%rax, %rcx
               	xorq	$0x29, %rax
               	andq	%rcx, %rax
               	testq	%rax, %rax
               	jl	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	-<rip>, %rcx # <addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x1(%rax), %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rdx
               	xorq	$0x1, %rdx
               	xorq	%rcx, %rax
               	andq	%rdx, %rax
               	testq	%rax, %rax
               	jl	<addr>
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x7, %edi
               	movq	<rip>, %rax # <addr>
               	callq	*%rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rcx,%rcx,4), %rsi
               	movq	%rsi, <rip> # <addr>
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$-0x1, %rcx
               	sete	%dil
               	movzbq	%dil, %rdi
               	orq	%rdi, %rax
               	movq	%rax, %r8
               	xorq	$0x1, %r8
               	imulq	%r8, %rcx
               	addq	%rax, %rcx
               	movq	%rsi, %rax
               	cqto
               	idivq	%rcx
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	andq	%r8, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rsi, %rcx
               	cmpq	%r11, %rsi
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%rdi, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x8(%rax), %rax
               	movl	$0x7, %edi
               	callq	*%rax
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
