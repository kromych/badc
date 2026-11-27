
overflow_builtin_result_pointer_operand.x64:	file format elf64-x86-64

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

<scaled>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	retq

<decremented>:
               	leaq	-0x1(%rdi), %rax
               	retq

<main>:
               	pushq	%rax
               	movq	<rip>, %rax # <addr>
               	leaq	0x29(%rax), %rcx
               	movq	%rcx, <rip> # <addr>
               	xorq	%rcx, %rax
               	movq	%rcx, %rdx
               	xorq	$0x29, %rdx
               	andq	%rdx, %rax
               	testq	%rax, %rax
               	jl	<addr>
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	leaq	-<rip>, %rcx # <addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x1(%rax), %rdx
               	movq	%rax, %rcx
               	xorq	$0x1, %rcx
               	xorq	%rdx, %rax
               	andq	%rax, %rcx
               	testq	%rcx, %rcx
               	jl	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movl	$0x7, %edi
               	callq	*%rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	leaq	(%rcx,%rcx,4), %rdi
               	movq	%rdi, <rip> # <addr>
               	testq	%rcx, %rcx
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$-0x1, %rcx
               	sete	%r8b
               	movzbq	%r8b, %r8
               	orq	%r8, %rax
               	movq	%rax, %rsi
               	xorq	$0x1, %rsi
               	imulq	%rsi, %rcx
               	addq	%rax, %rcx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rcx
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	andq	%rax, %rsi
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rdi, %rax
               	cmpq	%r11, %rdi
               	sete	%al
               	movzbq	%al, %rax
               	andq	%rax, %r8
               	orq	%r8, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
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
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
