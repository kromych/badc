
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
               	xorq	%rax, %rax
               	movl	$0x7, %edx
               	movb	%dl, (%rcx)
               	leaq	(%rsp), %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x7, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	leaq	-0x10(%rbp), %rsp
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<nested_auto_typed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x40, %rsp
               	leaq	(%rsp), %rcx
               	xorq	%rax, %rax
               	movl	$0x9, %edx
               	movl	%edx, (%rcx)
               	leaq	(%rsp), %rcx
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	(%rsp), %rax
               	movl	(%rax), %eax
               	xorq	$0x9, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	leaq	-0x50(%rbp), %rsp
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movl	$0x3, %edx
               	movl	%edx, (%rcx)
               	andq	$0x3f, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	xorq	$0x3, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rcx
               	leaq	<rip>, %rax
               	movl	$0x5, %edx
               	movb	%dl, (%rax)
               	movq	%rax, %rdx
               	andq	$0x7f, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x5, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	leaq	(%rcx,%rax), %rbx
               	callq	<addr>
               	addq	%rax, %rbx
               	callq	<addr>
               	addq	%rbx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
