
nested_block_decl_alignment.x64:	file format elf64-x86-64

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

<nested_auto>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rcx
               	xorl	%eax, %eax
               	movb	$0x7, (%rcx)
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<nested_auto_typed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rcx
               	xorl	%eax, %eax
               	movl	$0x9, (%rcx)
               	movq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	(%rcx), %eax
               	xorq	$0x9, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	-0x50(%rbp), %rsp
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rcx
               	xorl	%eax, %eax
               	movl	$0x3, (%rcx)
               	movq	%rcx, %rdx
               	andq	$0x3f, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	(%rcx), %ecx
               	xorq	$0x3, %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rdx
               	movb	$0x5, (%rdx)
               	movq	%rdx, %rsi
               	andq	$0x7f, %rsi
               	testq	%rsi, %rsi
               	jne	<addr>
               	movsbq	(%rdx), %rax
               	cmpl	$0x5, %eax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	(%rcx,%rax), %rbx
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	addq	%rbx, %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
