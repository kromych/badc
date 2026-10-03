
noreturn_calls_end_their_block.x64:	file format elf64-x86-64

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

<die>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movq	%rdi, %rsi
               	movq	%rax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<via_return>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	leaq	0x4(%rax), %rdi
               	callq	<addr>
               	ud2

<maybe_spin>:
               	movl	$0x2, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x4, %edi
               	callq	<addr>
               	ud2
               	cmpl	$0x4, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>
