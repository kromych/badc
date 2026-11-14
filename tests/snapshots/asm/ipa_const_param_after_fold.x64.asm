
ipa_const_param_after_fold.x64:	file format elf64-x86-64

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

<fill>:
               	movl	<rip>, %eax # <addr>
               	addq	%rdi, %rax
               	movl	%eax, %eax
               	retq

<fill_first>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rsi, -0x20(%rbp)
               	testq	%rsi, %rsi
               	je	<addr>
               	xorl	%esi, %esi
               	leave
               	jmp	<addr>
               	movq	$-0x16, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movl	%eax, (%rcx,%rax,4)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	xorl	%esi, %esi
               	movl	$0x5, %edi
               	movq	%rsi, %rdx
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
