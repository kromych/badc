
tail_recursion_constant_accumulator.x64:	file format elf64-x86-64

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

<depth>:
               	xorl	%eax, %eax
               	cmpb	$0x0, (%rdi)
               	je	<addr>
               	incq	%rdi
               	incq	%rax
               	cmpb	$0x0, (%rdi)
               	jne	<addr>
               	retq

<down>:
               	xorl	%eax, %eax
               	testq	%rdi, %rdi
               	je	<addr>
               	decq	%rdi
               	addq	$-0x3, %rax
               	testq	%rdi, %rdi
               	jne	<addr>
               	addq	$0x64, %rax
               	retq

<twice>:
               	movl	$0x1, %eax
               	testq	%rdi, %rdi
               	je	<addr>
               	decq	%rdi
               	shlq	%rax
               	testq	%rdi, %rdi
               	jne	<addr>
               	retq

<wrap>:
               	xorl	%eax, %eax
               	testq	%rdi, %rdi
               	je	<addr>
               	decq	%rdi
               	addq	$-0x7, %rax
               	testq	%rdi, %rdi
               	jne	<addr>
               	addq	$0x5, %rax
               	retq

<times8>:
               	movl	$0x1, %eax
               	testq	%rdi, %rdi
               	je	<addr>
               	decq	%rdi
               	shlq	$0x3, %rax
               	testq	%rdi, %rdi
               	jne	<addr>
               	leaq	(%rax,%rax,2), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$0x46, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x14, %edi
               	callq	<addr>
               	cmpq	$0x100000, %rax         # imm = 0x100000
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0xa, %edi
               	callq	<addr>
               	cmpq	$-0x41, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x15, %edi
               	callq	<addr>
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
