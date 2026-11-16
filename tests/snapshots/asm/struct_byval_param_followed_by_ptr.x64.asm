
struct_byval_param_followed_by_ptr.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	xorl	%esi, %esi
               	movl	%esi, -0x8(%rbp)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1e, %esi
               	testl	%esi, %esi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movl	-0x8(%rbp), %edx
               	movl	<rip>, %ecx # <addr>
               	movq	%rsi, 0x8(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	movq	0x8(%rsp), %rsi
               	movq	%rsi, %rax
               	leave
               	retq
               	movl	-0x8(%rbp), %esi
               	cmpl	$0x1, %esi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x1, -0x8(%rbp)
               	jmp	<addr>
