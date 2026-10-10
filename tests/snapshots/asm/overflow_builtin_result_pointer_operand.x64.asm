
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
               	leaq	<rip>, %rcx      # <addr>
               	movq	(%rcx), %rdx
               	leaq	<rip>, %rsi      # <addr>
               	leaq	0x29(%rdx), %rax
               	movq	%rax, (%rsi)
               	xorq	%rax, %rdx
               	xorq	$0x29, %rax
               	andq	%rdx, %rax
               	testq	%rax, %rax
               	jl	<addr>
               	movq	(%rsi), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	(%rcx), %rax
               	leaq	<rip>, %rcx      # <addr>
               	leaq	-<rip>, %rdx       # <addr>
               	movq	%rdx, (%rcx)
               	leaq	-0x1(%rax), %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	%rax, %rsi
               	xorq	$0x1, %rsi
               	xorq	%rdx, %rax
               	andq	%rsi, %rax
               	testq	%rax, %rax
               	jl	<addr>
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	$0x7, %edi
               	movq	(%rcx), %rax
               	callq	*%rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rcx
               	leaq	<rip>, %rsi      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	%rax, (%rsi)
               	leaq	(%rcx,%rcx,4), %rdi
               	movq	%rdi, (%rax)
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$-0x1, %rcx
               	sete	%r8b
               	movzbq	%r8b, %r8
               	orq	%r8, %rax
               	movq	%rax, %r9
               	xorq	$0x1, %r9
               	imulq	%r9, %rcx
               	addq	%rax, %rcx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	andq	%r9, %rax
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rdi, %rcx
               	cmpq	%r11, %rdi
               	sete	%cl
               	movzbq	%cl, %rcx
               	andq	%r8, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	(%rsi), %rax
               	movq	(%rax), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movq	(%rsi), %rax
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
