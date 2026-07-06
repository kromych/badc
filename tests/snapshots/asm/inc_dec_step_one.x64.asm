
inc_dec_step_one.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<plus_one>:
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<minus_one>:
               	leaq	-0x1(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<plus_one_l>:
               	leaq	0x1(%rdi), %rax
               	retq

<minus_neg_one>:
               	leaq	0x1(%rdi), %rax
               	retq

<count_up>:
               	movslq	%edi, %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movslq	%ecx, %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	incq	%rcx
               	jmp	<addr>
               	incq	%rax
               	movslq	%eax, %rax
               	jmp	<addr>
               	movslq	%eax, %rax
               	retq

<wrap>:
               	movl	%edi, %eax
               	incq	%rax
               	movl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	jmp	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %edi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x6, %eax
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x7, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
