
block_scope_thread_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<counter>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$-0x60, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq

<array_and_struct>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rcx
               	addq	$-0x58, %rcx
               	movl	$0x5, %eax
               	movb	%al, 0x3(%rcx)
               	movq	%fs:0x0, %rax
               	addq	$-0x18, %rax
               	movl	$0x9, %edx
               	movq	%rdx, (%rax)
               	movl	$0xb, %esi
               	movq	%rsi, 0x8(%rax)
               	movsbq	0x3(%rcx), %rcx
               	addq	%rdx, %rcx
               	leaq	(%rcx,%rsi), %rax
               	popq	%rbp
               	retq

<with_bool>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movslq	(%rax), %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movl	$0x1, %ecx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
