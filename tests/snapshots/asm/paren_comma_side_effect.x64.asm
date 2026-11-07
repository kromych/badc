
paren_comma_side_effect.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x0, <rip> # <addr>
               	movl	$0x7, <rip> # <addr>
               	movl	$0x1, <rip> # <addr>
               	movl	$0xb, <rip> # <addr>
               	movl	$0xd, <rip> # <addr>
               	movl	<rip>, %ebx # <addr>
               	cmpl	$0xd, %ebx
               	je	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	movq	%rbx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rdi # <addr>
               	jmp	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
